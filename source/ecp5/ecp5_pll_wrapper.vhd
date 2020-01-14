library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.system_clocks_pkg.all;

entity pll_wrapper is
    port (
        xclk : in std_logic;
        system_clocks : out system_clock_group
    );
end  pll_wrapper;

architecture rtl of pll_wrapper is

   component main_pll is
   port (
       CLKI: in  std_logic; 
       CLKOP: out  std_logic; 
       CLKOS: out  std_logic; 
       LOCK: out  std_logic);
   end component;

   component adc_clock is
   port (
       CLKI: in  std_logic; 
       CLKOP: out  std_logic; 
       LOCK: out  std_logic);
   end component;
   signal adc_pll_lock : std_logic; 

begin

    core_clocks : main_pll
    port map(xclk, system_clocks.core_clock, system_clocks.modulator_clock, system_clocks.pll_lock);

    u_adc_clock : adc_clock
    port map(xclk, system_clocks.adc_clock, system_clocks.adc_pll_lock);



end rtl;
