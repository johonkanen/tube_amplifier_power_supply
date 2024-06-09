library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.component_interconnect_pkg.all;

package system_control_pkg is
    
    type system_control_FPGA_input_group is record
    component_interconnect_FPGA_in : work.component_interconnect_pkg.component_interconnect_FPGA_input_group;
    end record;
    
    type system_control_FPGA_output_group is record
        component_interconnect_FPGA_out : work.component_interconnect_pkg.component_interconnect_FPGA_output_group;
        bypass_relay : std_logic;
    end record;
    
    type system_control_data_input_group is record
        component_interconnect_data_in : work.component_interconnect_pkg.component_interconnect_data_input_group;
    end record;
    
    type system_control_data_output_group is record
        component_interconnect_data_out : work.component_interconnect_pkg.component_interconnect_data_output_group;
    end record;
    
    procedure enable_power_supplies (
        signal component_control_input : out component_interconnect_data_input_group);
------------------------------------------------------------------------
    procedure disable_power_supplies (
        signal component_control_input : out component_interconnect_data_input_group);
------------------------------------------------------------------------
end package system_control_pkg;

package body system_control_pkg is
------------------------------------------------------------------------
    procedure enable_power_supplies
    (
        signal component_control_input : out component_interconnect_data_input_group
    ) is
    begin
        component_control_input.power_supplies_are_enabled <= true;
    end enable_power_supplies;
------------------------------------------------------------------------
    procedure disable_power_supplies
    (
        signal component_control_input : out component_interconnect_data_input_group
    ) is
    begin
        component_control_input.power_supplies_are_enabled <= false;
    end disable_power_supplies;
------------------------------------------------------------------------
end package body system_control_pkg;

------------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.system_clocks_pkg.all;
    use work.system_control_pkg.all;
    use work.component_interconnect_pkg.all;
    use work.led_driver_pkg.all;
    use work.tubepsu_addresses_pkg.all;
    use work.fpga_interconnect_pkg.all;

library common_library;
    use common_library.timing_pkg.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;
    use onboard_adc_library.measurement_interface_pkg.all;
    use onboard_adc_library.psu_measurement_interface_pkg.all;


entity system_control is
    port (
        system_clocks : in system_clock_group;    

        system_control_FPGA_in  : in system_control_FPGA_input_group;
        system_control_FPGA_out : out system_control_FPGA_output_group
    );
end entity system_control;
