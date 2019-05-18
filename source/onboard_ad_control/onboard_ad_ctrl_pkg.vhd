library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package onboard_ad_ctrl_pkg is


type rec_onboard_ad_ctrl_signals is record
    std16_ad_bus : std_logic_vector(15 downto 0);
    std3_ad_address : std_logic_vector(2 downto 0);
    ad_rdy_trigger : std_logic;
end record;


end package;
