library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
	use IEEE.NUMERIC_STD.all;

library work;
	use work.sys_ctrl_pkg.all;

entity command_shell is
    port(
	    core_clk : in std_logic;

	    po_uart_tx_serial : out std_logic;
	    pi_uart_rx_serial : in std_logic;

	    si_uart_start_event	: in std_logic;
	    si16_uart_tx_data	: in std_logic_vector(15 downto 0);

	    so_uart_ready_event	: out std_logic;
	    so16_uart_rx_data	: out std_logic_vector(15 downto 0)
	);
end command_shell;

architecture rtl of command_shell is


component uart_event_ctrl is
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
end component;		


signal r_so_uart_rx_rdy : std_logic;
signal r_so16_uart_tx_data : std_logic_vector(15 downto 0);
signal r_so16_uart_rx_data : std_logic_vector(15 downto 0);

begin
	main_comm : uart_event_ctrl	
	port map(
		    uart_Clk => core_clk,
		    
		    po_uart_tx_serial => po_uart_tx_serial,
		    pi_uart_rx_serial => pi_uart_rx_serial,

		    si_uart_start_event => si_uart_start_event, 
		    si16_uart_tx_data => si16_uart_tx_data,
		    
		    so_uart_rx_rdy => r_so_uart_rx_rdy, 
		    so16_uart_rx_data => r_so16_uart_rx_data
		);


so_uart_ready_event <= 	r_so_uart_rx_rdy;
so16_uart_rx_data <= r_so16_uart_rx_data;

end rtl;
