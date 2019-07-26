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

component s6_core_clocks
port
 (
      -- Clock in ports
      CLK_IN1           : in     std_logic;
      -- Clock out ports
      CLK_OUT1          : out    std_logic;
      CLK_OUT2          : out    std_logic;
      -- Status and control signals
      LOCKED            : out    std_logic
 );
end component;

signal r_modulator_clk : std_logic;

begin
    modulator_clk2 <= r_modulator_clk;
    modulator_clk <= r_modulator_clk;

    core_clocks : s6_core_clocks
    port map(xclk, r_modulator_clk, core_clk, pll_lock);
end rtl;
