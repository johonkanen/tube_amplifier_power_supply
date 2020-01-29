library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.onboard_ad_control_data_output_group;
    use onboard_adc_library.onboard_ad_control_pkg.onboard_ad_control_data_input_group;

package dhb_control_pkg is
------------------------------------------------------------------------
    type t_dhb_states is (disabled, ramping_up, running);
------------------------------------------------------------------------
    type dhb_control_clock_group is record
        core_clock : std_logic;
        modulator_clock : std_logic;
        pll_lock : std_logic;
    end record;
    
    type dhb_control_FPGA_output_group is record
        phase_modulator_FPGA_out : work.phase_modulator_pkg.phase_modulator_FPGA_output_group;
    end record;
    
    type dhb_control_data_input_group is record
        onboard_ad_control_data_out : onboard_ad_control_data_output_group;
        enable_dhb : boolean;
        dhb_carrier : integer;
    end record;
    
    type dhb_control_data_output_group is record
        onboard_ad_control_data_in : onboard_ad_control_data_input_group;
        dhb_state_is : t_dhb_states;
    end record;
    
    component dhb_control is
        generic (
            g_carrier_max_value : integer 
        );
        port (
            dhb_control_clocks : in dhb_control_clock_group; 
            dhb_control_FPGA_out : out dhb_control_FPGA_output_group; 
            dhb_control_data_in : in dhb_control_data_input_group;
            dhb_control_data_out : out dhb_control_data_output_group
        );
    end component dhb_control;

end package dhb_control_pkg;
