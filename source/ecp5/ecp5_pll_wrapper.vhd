library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity pll_wrapper is
    port (
        xclk : in std_logic;
        core_clk : out std_logic;
        modulator_clk : out std_logic;
        modulator_clk2 : out std_logic;
        pll_lock : out std_logic
    );
end  pll_wrapper;

architecture rtl of pll_wrapper is

   component main_pll is
   port (
       CLKI: in  std_logic; 
       CLKOP: out  std_logic; 
       CLKOS: out  std_logic; 
       CLKOS2: out  std_logic; 
       LOCK: out  std_logic);
   end component;

begin

    core_clocks : main_pll
    port map(xclk, modulator_clk, core_clk, modulator_clk2, pll_lock);



end rtl;
