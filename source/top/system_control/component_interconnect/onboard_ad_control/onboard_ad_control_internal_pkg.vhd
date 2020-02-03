library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package onboard_ad_control_internal_pkg is
----------------------------------------------------------------------
    function bool_to_std( test_condition : boolean) return std_logic;
----------------------------------------------------------------------     
    function drive_ad_mux( ad_channel : integer) return std_logic_vector;
----------------------------------------------------------------------
    function read_ad_mux_position (ad_mux_position : std_logic_vector) return integer;
------------------------------------------------------------------------
    function std_to_bool( test_condition : std_logic) return boolean;
------------------------------------------------------------------------
    function read_ad_data ( ad_spi_data : std_logic_vector) return integer;
------------------------------------------------------------------------
end package onboard_ad_control_internal_pkg;

package body onboard_ad_control_internal_pkg is
------------------------------------------------------------------------
    -- translate ad channels to mux positions
    type integer_array is array (integer range 0 to 7) of integer;
    constant channel_to_mux_position : integer_array := (2,1,0,3,4,6,7,5);
    constant mux_to_ad_channel : integer_array       := (2,1,0,3,4,7,5,6);
------------------------------------------------------------------------
    function bool_to_std ( test_condition : boolean)
    return std_logic
    is
    begin
        if test_condition then
            return '1';
        else
            return '0';
        end if;
    end bool_to_std;
------------------------------------------------------------------------
    function drive_ad_mux
    (
        ad_channel : integer
    )
    return std_logic_vector
    is
    begin
        return std_logic_vector(to_unsigned(channel_to_mux_position(ad_channel),3));
    end drive_ad_mux;
------------------------------------------------------------------------
    function read_ad_mux_position
    (
        ad_mux_position : std_logic_vector
    )
    return integer
    is
    begin
        return mux_to_ad_channel(to_integer(unsigned(ad_mux_position)));
    end read_ad_mux_position;
------------------------------------------------------------------------
    function std_to_bool
    (
        test_condition : std_logic   
    )
    return boolean
    is
    begin
        if test_condition = '1' then
            return true;
        else
            return false;
        end if;
    end std_to_bool;
------------------------------------------------------------------------
    function read_ad_data
    (
        ad_spi_data : std_logic_vector
    )
    return integer
    is
    begin
        return to_integer(unsigned(ad_spi_data));
    end read_ad_data;
------------------------------------------------------------------------
end package body onboard_ad_control_internal_pkg;
