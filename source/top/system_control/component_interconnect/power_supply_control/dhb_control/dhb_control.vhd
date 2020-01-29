library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;

library work;
    use work.dhb_control_pkg.all;
    use work.phase_modulator_pkg.all;


entity dhb_control is
    generic (
        g_carrier_max_value : integer 
    );
    port (
        dhb_control_clocks : in dhb_control_clock_group; 
        dhb_control_FPGA_out : out dhb_control_FPGA_output_group; 
        dhb_control_data_in : in dhb_control_data_input_group;
        dhb_control_data_out : out dhb_control_data_output_group
    );
end dhb_control;


architecture rtl of dhb_control is

    alias core_clock : std_logic is dhb_control_clocks.core_clock;
    alias modulator_clock : std_logic is dhb_control_clocks.modulator_clock;
    signal phase_modulator_clocks : phase_modulator_clock_group;
    signal phase_modulator_data_in : phase_modulator_data_input_group;
    signal phase_modulator_data_out : phase_modulator_data_output_group;
    

begin
------------------------------------------------------------------------
    phase_modulator_clocks <= (core_clock => core_clock, modulator_clock => modulator_clock);
    u_phase_modulator : phase_modulator
    generic map(g_carrier_max_value)
    port map
    (
        phase_modulator_clocks,
        dhb_control_FPGA_out.phase_modulator_FPGA_out,
        phase_modulator_data_in,
        phase_modulator_data_out
    );
------------------------------------------------------------------------
                


end rtl;

