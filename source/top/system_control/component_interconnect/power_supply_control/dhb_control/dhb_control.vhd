library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;

library common_library;
    use common_library.timing_pkg.all;

library work;
    use work.dhb_control_pkg.all;
    use work.phase_modulator_pkg.all;
    use work.multiplier_pkg.all;


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

    alias core_clock      is dhb_control_clocks.core_clock;
    alias modulator_clock is dhb_control_clocks.modulator_clock;
    alias reset_n is dhb_control_clocks.pll_lock;

    signal phase_modulator_clocks : phase_modulator_clock_group;
    signal phase_modulator_data_in : phase_modulator_data_input_group;
    signal phase_modulator_data_out : phase_modulator_data_output_group;

    signal multiplier_clocks   : multiplier_clock_group;
    signal multiplier_data_in  : multiplier_data_input_group;
    signal multiplier_data_out :  multiplier_data_output_group;

    type t_dhb_states is (idle,ramping_up,running,trip);
    signal st_dhb_states : t_dhb_states;

    signal delay_timer_data_in  : delay_timer_data_input_group;
    signal delay_timer_data_out : delay_timer_data_output_group;
begin
------------------------------------------------------------------------
    delay_10us : delay_timer
    generic map (count_up_to => 1280)
    port map( core_clock,
    	  delay_timer_data_in,
    	  delay_timer_data_out);
----------------------------------------------------------------------
    dhb_control : process(core_clock)
        constant kp : int18 := 22e3;
        constant ki : int18 := 2500;

        variable integrator : int18;
        variable radix : int18;

        variable process_counter : int18;
        ------------------------------------------------------------------------
        impure function "*" (left, right : int18) return int18
        is
        begin
            alu_mpy(left, right, multiplier_data_in, multiplier_data_out);
            return get_result(multiplier_data_out,radix);
        end "*";
        ------------------------------------------------------------------------
    begin
        if rising_edge(core_clock) then
            if reset_n = '0' then
            -- reset state
                st_dhb_states <= idle;
                integrator := 0;
                radix := 16;
    
            else

                CASE st_dhb_states is
                    WHEN idle =>

                    WHEN ramping_up =>

                    WHEN running =>

                    WHEN trip =>
                end CASE;
    
            end if; -- rstn
        end if; --rising_edge
    end process dhb_control;	
------------------------------------------------------------------------
    multiplier_clocks.dsp_clock <= core_clock;
    u_multiplier : multiplier
        port map(
            multiplier_clocks, 
            multiplier_data_in,
            multiplier_data_out 
        );
------------------------------------------------------------------------
    phase_modulator_clocks <= (core_clock => core_clock, 
                              modulator_clock => modulator_clock);
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
