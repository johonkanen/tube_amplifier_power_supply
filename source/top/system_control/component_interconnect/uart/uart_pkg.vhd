library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package uart_pkg is

    component uart_event_ctrl is
	generic (
				g_CLKS_PER_BIT : integer; 
				g_RX_bytes_in_word : integer;
				g_TX_bytes_in_word : integer 
			);
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

end package uart_pkg;
