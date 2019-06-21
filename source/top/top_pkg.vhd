library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package top_pkg is

    type bridgeless_pfc_pwm is record
        ac1 : std_logic;
        ac2 : std_logic;
    end record;

    type hb_llc_pwm is record
        pri_high : std_logic;
        pri_low : std_logic;
        sync1 : std_logic;
        sync2 : std_logic;
    end record;

    type dhb_pwm is record
        pri_high : std_logic;
        pri_low : std_logic;
        sec_high : std_logic;
        sec_low : std_logic;
    end record;

    type rgb_led is record
        red : std_logic;
        green : std_logic;
        blue : std_logic;
    end record;

end top_pkg;
