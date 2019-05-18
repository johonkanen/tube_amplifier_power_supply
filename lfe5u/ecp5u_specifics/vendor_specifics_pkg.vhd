library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

package vendor_specifics_pkg is

   component main_pll is
   port (
       CLKI: in  std_logic; 
       CLKOP: out  std_logic; 
       CLKOS: out  std_logic; 
       CLKOS2: out  std_logic; 
       LOCK: out  std_logic);
   end component;


   constant g_vendor_specific_uart_clks_per_bit : integer := 24;
   constant g_vendor_specific_RX_bytes_in_word : integer := 2;
   constant g_vendor_specific_TX_bytes_in_word : integer := 2;
end vendor_specifics_pkg;
