library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package onboard_ad_ctrl_pkg is


type rec_onboard_ad_ctrl_signals is record
    std16_ad_bus : std_logic_vector(15 downto 0);
    std3_ad_address : integer;
    ad_rdy_trigger : std_logic;
end record;


end package;


package body onboard_ad_ctrl_pkg is

function ad_channel_rdy
(
    channel_num : integer;
    ad_channel : rec_onboard_ad_ctrl_signals
)
return boolean
is
begin
   return boolean(ad_channel.std3_ad_address = channel_num AND ad_channel.ad_rdy_trigger = '1');
end ad_channel_rdy;



end onboard_ad_ctrl_pkg;
