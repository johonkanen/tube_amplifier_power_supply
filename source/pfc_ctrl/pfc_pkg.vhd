library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package pfc_pkg is

    type bridgeless_pfc_pwm is record
        ac1 : std_logic;
        ac2 : std_logic;
    end record;

end pfc_pkg;
