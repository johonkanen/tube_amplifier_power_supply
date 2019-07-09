library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    library work;
        use work.vendor_specifics_pkg.all;

entity main_pll is
    port (
        xclk : in std_logic;
        core_clk : out std_logic;
        modulator_clk : out std_logic;
        modulator_clk2 : out std_logic;
        pll_lock : out std_logic
    );
end entity main_pll;

architecture rtl of main_pll is

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
    port map(xclk, modulator_clk, core_clk, modulator_clk2, pll_lock);



end rtl;
