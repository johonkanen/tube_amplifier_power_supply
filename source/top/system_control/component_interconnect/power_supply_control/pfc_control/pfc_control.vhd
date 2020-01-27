library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.pfc_control_pkg.all;
    use work.pfc_modulator_pkg.all;
    use work.multiplier_pkg.all;

entity pfc_control is
        port (
            pfc_control_clocks : in pfc_control_clock_group;
            pfc_control_FPGA_out : out pfc_control_FPGA_output_group;
            pfc_control_data_in : in pfc_control_data_input_group;
            pfc_control_data_out : out pfc_control_data_output_group
        );
end pfc_control;

architecture rtl of pfc_control is

    alias core_clock : std_logic is pfc_control_clocks.core_clock;
    alias modulator_clock : std_logic is pfc_control_clocks.modulator_clock;

    signal multiplier_clocks   : multiplier_clock_group;
    signal multiplier_data_in  : multiplier_data_input_group;
    signal multiplier_data_out : multiplier_data_output_group;

    signal pfc_modulator_clocks   : pfc_modulator_clock_group;
    signal pfc_modulator_data_in  : pfc_modulator_data_input_group;
    signal pfc_modulator_data_out : pfc_modulator_data_output_group;

begin
------------------------------------------------------------------------
    multiplier_clocks.dsp_clock <= core_clock;
    u_multiplier : multiplier
        port map(
            multiplier_clocks, 
            multiplier_data_in,
            multiplier_data_out 
        );
------------------------------------------------------------------------
    pfc_modulator_clocks <= (modulator_clock => modulator_clock, core_clock => core_clock);
    pfc_modulator_data_in.pfc_carrier <= pfc_control_data_in.pfc_carrier;
    u_pfc_modulator : pfc_modulator
        port map 
        (
            pfc_modulator_clocks,
            pfc_control_FPGA_out.pfc_modulator_FPGA_out,
            pfc_modulator_data_in,
            pfc_modulator_data_out
        );
------------------------------------------------------------------------

end rtl;
