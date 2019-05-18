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
end vendor_specifics_pkg;
