library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;

package power_supply_control_pkg is

    type power_supply_control_clock_group is record
        core_clock : std_logic;
        modulator_clock : std_logic;
        pll_lock : std_logic;
    end record;
    
    type power_supply_control_FPGA_output_group is record
        pfc_control_FPGA_out : work.pfc_control_pkg.pfc_control_FPGA_output_group;
    end record;
    
    type power_supply_control_data_input_group is record
        onboard_ad_control_data_out : onboard_ad_control_data_output_group;
    end record;
    
    type power_supply_control_data_output_group is record
        onboard_ad_control_data_in : onboard_ad_control_data_input_group;
    end record;
    
    component power_supply_control is
        port (
            power_supply_control_clocks : in power_supply_control_clock_group;
    
            power_supply_control_FPGA_out : out power_supply_control_FPGA_output_group;
    
            power_supply_control_data_in : in power_supply_control_data_input_group;
            power_supply_control_data_out : out power_supply_control_data_output_group
        );
    end component power_supply_control;
        
end package power_supply_control_pkg;
