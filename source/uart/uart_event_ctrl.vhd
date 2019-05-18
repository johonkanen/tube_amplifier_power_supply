library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.numeric_std.all;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity uart_event_ctrl is
--- uart interface
	port(
				uart_Clk   : in std_logic;
				
				po_uart_tx_serial : out std_logic;
				pi_uart_rx_serial : in std_logic;

				si_uart_start_event	: in std_logic;
				si16_uart_tx_data	: in std_logic_vector(15 downto 0);
				
				so_uart_rx_rdy		: out std_logic;
				so16_uart_rx_data	: out std_logic_vector(15 downto 0)
		);
end uart_event_ctrl;		

architecture rtl of uart_event_ctrl is

	signal r_data_stream : std_logic_vector(15 downto 0); 
	 
	signal r_rx_data_out		: std_logic_vector(15 downto 0);
	alias rx_uart_cmd_offset	: std_logic_vector(3 downto 0) is r_rx_data_out(15 downto 12);
	alias rx_uart_cmd_data		: std_logic_vector(11 downto 0) is r_rx_data_out(11 downto 0);
	 
	type st_uart_stream is (idle, 
							ack, 
							latch, 
							ready); 
	
	signal parse_state, next_state : st_uart_stream;
	
	signal r15_uart_data_in		: std_logic_vector(15 downto 0); 
	signal route_uart_tx_data	: std_logic_vector(15 downto 0); 
	 
	signal r_uart_start_event : std_logic; 
	 
	signal route_uart_tx_active : std_logic;
	signal route_uart_tx_done : std_logic; 
	signal r_rx_ready_event : std_logic; 
	 
	signal route_uart_tx_start : std_logic; 
	 
	type uart_states is (idle, 
						ack, 
						latch, 
						ready); 
						 
	signal r_pres_state, r_next_state : uart_states; 
	 
	signal r_rx_start : std_logic; 
 
component uart is
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
	end component;	 


begin

	uart1 : uart
	generic map(
				g_CLKS_PER_BIT => 25,
				g_RX_bytes_in_word => 2,
				g_TX_bytes_in_word => 2
			)
				
	port map(
			uart_Clk   		=> uart_Clk,
			
			i_TX_start     	=> route_uart_tx_start,
			i_TX_data_in    => route_uart_tx_data,
			
			so_uart_tx_active => route_uart_tx_active,
			uart_tx_done   	=> route_uart_tx_done, 
			
			uart_tx_serial 	=> po_uart_tx_serial,
			uart_rx_serial 	=> pi_uart_rx_serial, 
			
			rx_ready_event	=> r_rx_ready_event, 
			o_RX_data_out  	=> r_rx_data_out
			
		);

---------------------------------------------

	
r_pres_state <=r_next_state;

	uart_control : process(uart_Clk,r_pres_state,route_uart_tx_active)
	begin
	if rising_edge(uart_Clk) then 
		CASE r_next_state is 
			WHEN idle =>  
				route_uart_tx_start <= '0'; 
				if si_uart_start_event = '1' then 
					r15_uart_data_in <= si16_uart_tx_data; 
					r_next_state <= ack; 
				else 
					r_next_state <= idle; 
				end if; 
			WHEN ack => 
 
				if route_uart_tx_active = '0' then 
					r_next_state <= latch; 
					route_uart_tx_start <= '1'; 
				else  
					r_next_state <= ack; 
					route_uart_tx_start <= '0'; 
				end if; 
			WHEN latch =>  
 
				if route_uart_tx_active = '1' then 
					r_next_state <= ready; 
					route_uart_tx_start <= '0'; 
				else  
					r_next_state <= latch; 
					route_uart_tx_start <= '1'; 
				end if; 
			WHEN ready =>  
				route_uart_tx_start <= '0';
				
				if si_uart_start_event = '0' then
					r_next_state <= idle;
				else 
					r_next_state <= ready;
				end if; 
				 
				 
			when others => 
				r_next_state <= idle; 
			end CASE; 
 
	end if;
	end process uart_control;
	
------------------------------------
 
-- signal routings  
	so16_uart_rx_data <= r_rx_data_out; 
	so_uart_rx_rdy <= r_rx_ready_event; 
	route_uart_tx_data <= r15_uart_data_in;  
	 
end rtl;
