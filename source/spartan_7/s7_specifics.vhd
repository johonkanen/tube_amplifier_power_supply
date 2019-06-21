library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

package vendor_specifics_pkg is

   component pll_256mhz is
   port (
       clk_out1: out  std_logic; 
       locked: out  std_logic; 
       clk_in1 : in  std_logic);
   end component;


   constant g_vendor_specific_uart_clks_per_bit : integer := 50;
   constant g_vendor_specific_RX_bytes_in_word : integer := 2;
   constant g_vendor_specific_TX_bytes_in_word : integer := 2;
end vendor_specifics_pkg;
