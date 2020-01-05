library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

-- maximum baudrate with 2232hl is 5Mhz => 12clk /w 60Mhz uart clk
entity uart is

	generic (
				g_CLKS_PER_BIT : integer; 
				g_RX_bytes_in_word : integer;
				g_TX_bytes_in_word : integer
			);
	port(
			uart_Clk    : in  std_logic; 
			
			i_TX_start     	: in  std_logic;
			i_TX_data_in    : in  std_logic_vector(15 downto 0);
			
			so_uart_tx_active 	: out std_logic;
			uart_tx_done   	: out std_logic;
			
			uart_tx_serial 	: out std_logic; 
			uart_rx_serial 	: in  std_logic;
			
			rx_ready_event	: out std_logic;
			o_RX_data_out  	: out std_logic_vector(15 downto 0)
		);
end uart;

architecture behavioral of uart is

	component UART_TX is
	generic (
				g_CLKS_PER_BIT : integer   
			);
	port(
			i_Clk       : in  std_logic;
			i_TX_DV     : in  std_logic;
			i_TX_Byte   : in  std_logic_vector(7 downto 0);
			
			o_TX_Active : out std_logic;
			o_TX_Serial : out std_logic;
			o_TX_Done   : out std_logic
		);
	end component;		

	component UART_RX is
	generic (
				g_CLKS_PER_BIT : integer   -- baudrate of 480e4 /w 60Mhz clk
			);
	port(
			i_Clk       : in  std_logic;
			i_RX_Serial : in  std_logic;

			o_RX_ready_event    : out std_logic;
			o_RX_Byte   		: out std_logic_vector(7 downto 0)
		);
	end component;

	signal route_uart_rx_data : std_logic_vector(7 downto 0);
	signal route_uart_tx_done : std_logic;
	
	signal i, j : std_logic :='0';
	
	signal testidata : std_logic_vector(15 downto 0) := x"0606";
	signal route_uart_tx_data : std_logic_vector(7 downto 0);
	signal route_uart_tx_active : std_logic;
	
	signal route_tx_in_progress : std_logic;
	
	signal tx_start : std_logic;
	
	signal route_rx_ready_event : std_logic;
	signal route_receive_ready_event : std_logic;
	
	signal route_RX_data_out : std_logic_vector(15 downto 0):=x"0606";
	 
	 
-- states for send data state machine	 
	type t_tx_data is (	Idle, 
						latch_word,
						start_tx,
						wait_active,
						reset_tx);
	
	signal present_state,next_state : t_tx_data;
	
-- states for receive data state machine	
	type t_rx_data is( 	idle,
						wait_active,
						latch);
						
	signal rx_pres_state, rx_next_state : t_rx_data;
						
	
begin

--- component intances
	uarttx : UART_TX 
	generic map(
				g_CLKS_PER_BIT => g_CLKS_PER_BIT
			)
			
	port map(
				i_Clk       => uart_Clk,
				i_TX_DV     => tx_start,
				i_TX_Byte   => route_uart_tx_data,
				
				o_TX_Active => route_uart_tx_active,
				o_TX_Serial => uart_tx_serial,
				o_TX_Done   => route_uart_tx_done
			);
			
			
	uartrx : UART_RX
	generic map(
				g_CLKS_PER_BIT => g_CLKS_PER_BIT
			)

	port map(
				i_Clk       	=> uart_Clk,
				i_RX_Serial 	=> uart_rx_serial,

				o_RX_ready_event => route_rx_ready_event,
				o_RX_Byte   	 => route_uart_rx_data
			);	
--- end components			
			 
	sendword : process(uart_Clk,present_state)
	begin
		if rising_edge(uart_Clk) then
			
			CASE present_state is
				WHEN Idle =>
					i <= '0';
					tx_start <= '0';
					route_tx_in_progress <='0';
					
					if i_TX_start = '1' then
						next_state <= latch_word;
						route_tx_in_progress <= '1';					
					end if;
				WHEN latch_word =>				
					
					if i = '0' then
						route_uart_tx_data <= i_TX_data_in(7 downto 0);
						tx_start <= '1';
						i <= '1';
					else
						route_uart_tx_data <= i_TX_data_in(15 downto 8);
						tx_start <= '1';
						i <= '0';
					end if;

					next_state <= wait_active;
					
				WHEN wait_active =>
					
					if route_uart_tx_done = '1' then
						tx_start <= '0';
						
						if i = '1' then						
							next_state <= latch_word;
						else 
							next_state <= reset_tx;
							tx_start <= '0';
						end if;
					end if;
				WHEN reset_tx =>
				
					route_tx_in_progress <='0';
					tx_start <= '0';
				
					next_state <= Idle;
				WHEN others => 
					next_state <= idle;
			end CASE;
		end if;
	end process sendword;
	

	receiveword : process(uart_Clk,rx_pres_state)
	begin
		if rising_edge(uart_Clk) then
		
			case rx_pres_state is
			
				WHEN idle => 
					j <= '0';
					route_receive_ready_event <= '0';
					rx_next_state <= wait_active;
					
				WHEN wait_active=>
					
					if route_rx_ready_event = '1' then 
						if j = '0' then
							j <= '1';
							testidata(15 downto 8) <= route_uart_rx_data;
						else 
							testidata(7 downto 0) <= route_uart_rx_data;
							rx_next_state <= latch;
						end if;
					end if;
					
				WHEN latch =>
					route_RX_data_out <= testidata;
					route_receive_ready_event <= '1';
					rx_next_state <= idle;
					
				WHEN others => 
					rx_next_state <= idle;
			end case;
		end if;
	end process receiveword;

	-- traverse tx states
	present_state <= next_state;		
	-- traverse rx states
	rx_pres_state <= rx_next_state;

	o_RX_data_out	<=route_RX_data_out;
	
	so_uart_tx_active <= route_tx_in_progress;
	rx_ready_event <= route_receive_ready_event;

end behavioral;
