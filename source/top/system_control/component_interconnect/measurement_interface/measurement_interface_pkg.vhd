library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;

package measurement_interface_pkg is

    type measurement_interface_clock_group is record
        core_clock : std_logic;
        ad_clock : std_logic;
        reset_n : std_logic;
    end record;
    
    type measurement_interface_FPGA_input_group is record
        onboard_ad_control_FPGA_in : onboard_ad_control_FPGA_input_group;
        llc_ad_data  : std_logic;
        dhb_ad_data  : std_logic;
    end record;
    
    type measurement_interface_FPGA_output_group is record
        onboard_ad_control_FPGA_out : onboard_ad_control_FPGA_output_group;
        llc_ad_clock : std_logic;
        llc_ad_cs : std_logic;

        dhb_ad_clock : std_logic;
        dhb_ad_cs : std_logic;
    end record;
    
    type measurement_interface_data_input_group is record
        onboard_ad_control_data_in : onboard_ad_control_data_input_group;
        llc_ad_start_request_toggle : std_logic;
        dhb_ad_start_request_toggle : std_logic;
    end record;
    
    type measurement_interface_data_output_group is record
        onboard_ad_control_data_out : onboard_ad_control_data_output_group;
        llc_ad_measurement : integer;
        llc_ad_is_done : boolean;
        dhb_ad_measurement : integer;
        dhb_ad_is_done : boolean;
    end record;
    
    component measurement_interface is
        port (
            measurement_interface_clocks : in measurement_interface_clock_group; 
            measurement_interface_FPGA_in : in measurement_interface_FPGA_input_group;
            measurement_interface_FPGA_out : out measurement_interface_FPGA_output_group; 
            measurement_interface_data_in : in measurement_interface_data_input_group;
            measurement_interface_data_out : out measurement_interface_data_output_group
        );
    end component measurement_interface;
------------------------------------------------------------------------
    function ada_is_ready ( measurement_interface_out : measurement_interface_data_output_group)
        return  boolean;
------------------------------------------------------------------------
    function adb_is_ready ( measurement_interface_out : measurement_interface_data_output_group)
        return  boolean;
------------------------------------------------------------------------
    procedure get_ada_measurement (
        measurement_interface_out : measurement_interface_data_output_group;
        signal container : out integer);
------------------------------------------------------------------------
    procedure get_adb_measurement (
        measurement_interface_out : measurement_interface_data_output_group;
        signal container : out integer);
------------------------------------------------------------------------
end package measurement_interface_pkg;

package body measurement_interface_pkg is
------------------------------------------------------------------------
    function ada_is_ready
    (
        measurement_interface_out : measurement_interface_data_output_group
    )
    return  boolean
    is
    begin
        return ad_channel_is_ready(measurement_interface_out.onboard_ad_control_data_out.ada_measurements);
    end ada_is_ready;
------------------------------------------------------------------------
    function adb_is_ready
    (
        measurement_interface_out : measurement_interface_data_output_group
    )
    return  boolean
    is
    begin
        return ad_channel_is_ready(measurement_interface_out.onboard_ad_control_data_out.adb_measurements);
    end adb_is_ready;
------------------------------------------------------------------------
    procedure get_ada_measurement
    (
        measurement_interface_out : measurement_interface_data_output_group;
        signal container : out integer
    ) is
    begin
        if ada_is_ready(measurement_interface_out) then
            container <= get_ad_measurement(measurement_interface_out.onboard_ad_control_data_out.ada_measurements);
        end if;
    end get_ada_measurement;
------------------------------------------------------------------------
    procedure get_adb_measurement
    (
        measurement_interface_out : measurement_interface_data_output_group;
        signal container : out integer
    ) is
    begin
        if ada_is_ready(measurement_interface_out) then
            container <= get_ad_measurement(measurement_interface_out.onboard_ad_control_data_out.ada_measurements);
        end if;
    end get_adb_measurement;
------------------------------------------------------------------------
end package body measurement_interface_pkg;

