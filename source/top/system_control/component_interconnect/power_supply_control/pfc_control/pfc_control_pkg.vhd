library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;

package pfc_control_pkg is

    type pfc_control_clock_group is record
        core_clock : std_logic;
        modulator_clock : std_logic;
        pll_lock : std_logic;
    end record;
    
    type pfc_control_FPGA_output_group is record
        clock : std_logic;
    end record;
    
    type pfc_control_data_input_group is record
        start_pfc : boolean;
        onboard_ad_control_data_out : onboard_ad_control_data_output_group;
    end record;
    
    type pfc_control_data_output_group is record
        pfc_is_running : boolean;
        onboard_ad_control_data_in : onboard_ad_control_data_input_group;
    end record;
    
    component pfc_control is
        port (
            pfc_control_clocks : in pfc_control_clock_group;
            pfc_control_FPGA_out : out pfc_control_FPGA_output_group;
            pfc_control_data_in : in pfc_control_data_input_group;
            pfc_control_data_out : out pfc_control_data_output_group
        );
    end component pfc_control;

end package pfc_control_pkg;
