library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    library work;
        use work.vendor_specifics_pkg.all;

entity pll_wrapper is
    port (
        xclk : in std_logic;
        core_clk : out std_logic;
        modulator_clk : out std_logic;
        modulator_clk2 : out std_logic;
        pll_lock : out std_logic
    );
end entity pll_wrapper;

architecture rtl of pll_wrapper is

    component pll_1x256mhz 
 port (
      -- Clock out ports
      clk_out1 : out std_logic;
      clk_out2 : out std_logic;
      -- Status and control signals
      locked : out std_logic;
      -- Clock in ports
      clk_in1 : in std_logic
     );
    end component;
 signal r_modulator_clk : std_logic; 

begin
    modulator_clk <= r_modulator_clk;
    modulator_clk2 <= r_modulator_clk;

    core_clocks : pll_1x256mhz
    port map(r_modulator_clk, core_clk, pll_lock, xclk);



end rtl;
