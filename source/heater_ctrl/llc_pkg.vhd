library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package llc_pkg is
    
    type hb_llc_pwm is record
        pri_high : std_logic;
        pri_low : std_logic;
        sync1 : std_logic;
        sync2 : std_logic;
    end record;

end llc_pkg;
