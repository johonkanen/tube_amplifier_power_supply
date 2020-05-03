library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.measurement_interface_pkg.all;

package power_supply_control_pkg is

    type power_supply_control_clock_group is record
        core_clock : std_logic;
        modulator_clock : std_logic;
        pll_lock : std_logic;
    end record;
    
    type power_supply_control_FPGA_output_group is record
        pfc_control_FPGA_out : work.pfc_control_pkg.pfc_control_FPGA_output_group;
        llc_control_FPGA_out : work.llc_control_pkg.llc_control_FPGA_output_group;
        dhb_control_FPGA_out : work.dhb_control_pkg.dhb_control_FPGA_output_group;
    end record;
    
    type power_supply_control_data_input_group is record
        measurement_interface_data_out : measurement_interface_data_output_group;
        power_supplies_are_enabled : boolean;
    end record;
    
    type power_supply_control_data_output_group is record
        measurement_interface_data_in : measurement_interface_data_input_group;
    end record;
    
    component power_supply_control is
        port (
            power_supply_control_clocks : in power_supply_control_clock_group;
    
            power_supply_control_FPGA_out : out power_supply_control_FPGA_output_group;
    
            power_supply_control_data_in : in power_supply_control_data_input_group;
            power_supply_control_data_out : out power_supply_control_data_output_group
        );
    end component power_supply_control;
    -- TODO, move this to internal package
------------------------------------------------------------------------         
    procedure trigger_ext_ad ( signal dhb_adc_trigger : inout std_logic);
------------------------------------------------------------------------
    function power_supplies_are_enabled ( power_supply_data_input : power_supply_control_data_input_group )
        return boolean;
------------------------------------------------------------------------
end package power_supply_control_pkg;

package body power_supply_control_pkg is
------------------------------------------------------------------------
    procedure trigger_ext_ad
    (
        signal dhb_adc_trigger : inout std_logic
    ) is
    begin
        dhb_adc_trigger <= not dhb_adc_trigger;
    end trigger_ext_ad;
------------------------------------------------------------------------
    function power_supplies_are_enabled
    (
        power_supply_data_input : power_supply_control_data_input_group 
    )
    return boolean
    is
    begin
        return power_supply_data_input.power_supplies_are_enabled;
        
    end power_supplies_are_enabled;
------------------------------------------------------------------------

end package body power_supply_control_pkg;
