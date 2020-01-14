library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package system_clocks_pkg is

    type system_clocks is record
        core_clock : std_logic;
        modulator_clock : std_logic;
        pll_lock : std_logic;
        adc_clock : std_logic;
        adc_pll_lock : std_logic;
    end record;

end package system_clocks_pkg;
