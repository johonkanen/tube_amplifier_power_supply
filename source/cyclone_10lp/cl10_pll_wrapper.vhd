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
end entity pll_wrapper;

architecture rtl of pll_wrapper is

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

begin

    core_clocks : main_pll
    port map(xclk, system_clocks.modulator_clock, system_clocks.core_clock, system_clocks.adc_clock, system_clocks.pll_lock);
end rtl;
