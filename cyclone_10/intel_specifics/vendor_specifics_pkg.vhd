library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

package vendor_specifics_pkg is

    component main_pll IS
	PORT
	(
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;
		c1		: OUT STD_LOGIC ;
		c2		: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC 
	);
    END component;
   constant g_vendor_specific_uart_clks_per_bit : integer := 25;
   constant g_vendor_specific_RX_bytes_in_word : integer := 2;
   constant g_vendor_specific_TX_bytes_in_word : integer := 2;
end vendor_specifics_pkg;
