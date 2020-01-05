library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package onboard_ad_control_pkg is

    type onboard_ad_control_clock_group is record
        core_clock : std_logic;
        ad_clock : std_logic;
        reset_n : std_logic;
    end record;

    type onboard_ad_control_FPGA_input_group is record
        ada_data : std_logic;
        adb_data : std_logic;
    end record;

    type onboard_ad_control_FPGA_output_group is record
        ada_clock : std_logic;
        ada_cs : std_logic;
        ada_mux : std_logic_vector(2 downto 0);

        adb_clock : std_logic;
        adb_cs : std_logic;
        adb_mux : std_logic_vector(2 downto 0);
    end record;

    type onboard_ad_control_data_input_group is record
        ada_start_request : boolean;
        ada_mux_position : integer;
        adb_start_request : boolean;
        adb_mux_position : integer;
    end record;

    type onboard_ad_control_data_output_group is record
        ada_conversion_data : integer range 0 to 2**16-1;
        ada_data_is_ready : boolean;
        ada_channel : integer;

        adb_conversion_data : integer range 0 to 2**16-1;
        adb_data_is_ready : boolean;
        adb_channel : integer;
    end record;

    component onboard_ad_control is
        port (
            onboard_ad_control_clocks : in onboard_ad_control_clock_group;

            onboard_ad_control_FPGA_in : in onboard_ad_control_FPGA_input_group;
            onboard_ad_control_FPGA_out : out onboard_ad_control_FPGA_output_group;

            onboard_ad_control_data_in : in onboard_ad_control_data_input_group;
            onboard_ad_control_data_out : out onboard_ad_control_data_output_group
        );
    end component onboard_ad_control;

----------------------------------------------------------------------
    function bool_to_std( test_condition : boolean) return std_logic;
----------------------------------------------------------------------     
    function drive_ad_mux( ad_channel : integer) return std_logic_vector;
----------------------------------------------------------------------
    function std_to_bool( test_condition : std_logic) return boolean;
------------------------------------------------------------------------
end package onboard_ad_control_pkg;

package body onboard_ad_control_pkg is
------------------------------------------------------------------------
    -- translate ad channels to mux positions
    type integer_array is array (integer range 0 to 7) of integer;
    constant channel_to_mux_position : integer_array := (2,1,0,3,4,6,7,5);
    constant mux_to_ad_channel : integer_array       := (2,1,0,3,4,6,7,5);
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
end package body onboard_ad_control_pkg;
