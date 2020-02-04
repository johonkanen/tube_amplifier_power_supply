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
    end record;
    
    type measurement_interface_FPGA_output_group is record
        onboard_ad_control_FPGA_out : onboard_ad_control_FPGA_output_group;
    end record;
    
    type measurement_interface_data_input_group is record
        onboard_ad_control_data_in : onboard_ad_control_data_input_group;
    end record;
    
    type measurement_interface_data_output_group is record
        onboard_ad_control_data_out : onboard_ad_control_data_output_group;
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
        
end package measurement_interface_pkg;
