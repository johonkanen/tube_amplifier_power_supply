library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;
    use onboard_adc_library.measurement_interface_pkg.all;
    use onboard_adc_library.psu_measurement_interface_pkg.all;


library common_library;
    use common_library.timing_pkg.all;

library work;
    use work.dhb_control_pkg.all;
    use work.phase_modulator_pkg.all;
    use work.multiplier_pkg.all;

entity dhb_control is
    generic (g_carrier_max_value : integer);
    port (
        dhb_control_clocks : in dhb_control_clock_group; 
        dhb_control_FPGA_out : out dhb_control_FPGA_output_group; 
        dhb_control_data_in : in dhb_control_data_input_group;
        dhb_control_data_out : out dhb_control_data_output_group
    );
end dhb_control;


architecture rtl of dhb_control is

------------------------------------------------------------------------
    alias core_clock      is dhb_control_clocks.core_clock;
    alias modulator_clock is dhb_control_clocks.modulator_clock;
    alias reset_n is dhb_control_clocks.pll_lock;
    alias measurement_interface_data is dhb_control_data_in.measurement_interface_data_out;
------------------------------------------------------------------------
    signal phase_modulator_clocks : phase_modulator_clock_group;
    signal phase_modulator_data_in : phase_modulator_data_input_group;
    signal phase_modulator_data_out : phase_modulator_data_output_group;
------------------------------------------------------------------------
    signal multiplier_clocks   : multiplier_clock_group;
    signal multiplier_data_in  : multiplier_data_input_group;
    signal multiplier_data_out :  multiplier_data_output_group;
------------------------------------------------------------------------
    type t_dhb_states is (idle,ramping_up,running,trip);
    signal st_dhb_states : t_dhb_states;
------------------------------------------------------------------------
    signal delay_timer_data_in  : delay_timer_data_input_group;
    signal delay_timer_data_out : delay_timer_data_output_group;
------------------------------------------------------------------------
    signal dhb_voltage : int18;
    signal dhb_voltage_is_buffered : boolean;
    signal dhb_current : int18;
    signal dhb_current_is_buffered : boolean;
------------------------------------------------------------------------
    constant dhb_ref_410v : integer := 19770/400*410;
    constant dhb_ref_400v : integer := 19770/400*400;
    constant dhb_ref_350v : integer := 19770/400*350;
    constant dhb_ref_300v : integer := 19770/400*300;
    constant dhb_ref_200v : integer := 19770/400*200;
    constant dhb_ref_100v : integer := 19770/400*100;
------------------------------------------------------------------------
begin
------------------------------------------------------------------------
    delay_50us : delay_timer
    generic map (count_up_to => 5*1280)
    port map( core_clock,
    	  delay_timer_data_in,
    	  delay_timer_data_out);
------------------------------------------------------------------------
    multiplier_clocks.dsp_clock <= core_clock;
    u_multiplier : multiplier
        port map(
            multiplier_clocks, 
            multiplier_data_in,
            multiplier_data_out);
----------------------------------------------------------------------
    dhb_control : process(core_clock)
        constant kp : int18 := 22e3;
        constant ki : int18 := 2500;

        variable pi_out : int18;
        variable mult : int18;
        variable err : int18;
        variable integrator : int18;
        constant radix : int18 := 15;

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
                init_timer(delay_timer_data_in);
                process_counter := 0;
                dhb_voltage <= 0;
                init_multiplier(multiplier_data_in);
                phase_modulator_data_in.dhb_is_enabled <= '0';
    
            else
                ------------- buffer dhb measurements --------------
                dhb_voltage_is_buffered <= dhb_voltage_is_ready(measurement_interface_data);
                get_dhb_voltage(measurement_interface_data,dhb_voltage);

                dhb_current_is_buffered <= dhb_current_is_ready(measurement_interface_data);
                get_dhb_current(measurement_interface_data,dhb_current);
                ----------------------------------------------------

                multiplier_data_in.multiplication_is_requested <= false;
                CASE st_dhb_states is
                    WHEN idle =>

                        -- set_phase(0,phase_modulator_data_in);
                        phase_modulator_data_in.phase <= 0;
                        trigger(phase_modulator_data_in.tg_load_phase);
                        disable_dhb_modulator(phase_modulator_data_in);

                        st_dhb_states <= idle;
                        if dhb_control_data_in.enable_dhb then
                            init_timer(delay_timer_data_in);
                            st_dhb_states <= ramping_up;
                        end if;

                    WHEN ramping_up =>

                        request_delay(delay_timer_data_in,delay_timer_data_out,1);
                        -- TODO, add rampup for pwm
                        -- phase_modulator_data_in.dhb_is_enabled <= '1';
                        -- enable_dhb_modulator(phase_modulator_data_in);
                        disable_dhb_modulator(phase_modulator_data_in);
                            
                        st_dhb_states <= ramping_up;
                        if timer_is_ready(delay_timer_data_out) then
                            init_timer(delay_timer_data_in);
                            st_dhb_states <= running;
                        end if;

                    WHEN running =>
                        -- phase_modulator_data_in.dhb_is_enabled <= '1';
                        enable_dhb_modulator(phase_modulator_data_in);

                    -- PI controller for dhb voltage
                    -- TODO, refactor PI control to own procedure
                        CASE process_counter is 
                            WHEN 0 =>
                                if dhb_voltage_is_buffered then
                                    err := 2000 - dhb_voltage;
                                    increment(process_counter);
                                end if;

                            WHEN 1 => 
                                -- TODO, add rampup from measured voltage to reference
                                alu_mpy(kp,err,multiplier_data_in);
                                increment(process_counter);

                            WHEN 2 => 
                                -- pipeline integrator calculation
                                alu_mpy(ki,err,multiplier_data_in);
                                increment(process_counter);

                            WHEN 3 => 
                                pi_out := get_result(multiplier_data_out,radix) + integrator;
                                increment(process_counter);

                            WHEN 4 => 
                                if pi_out > 32768 then
                                    pi_out := 32768;
                                    integrator := 32768-get_result(multiplier_data_out,radix);

                                elsif pi_out < -32768 then
                                    pi_out := -32768;
                                    integrator := -32768-get_result(multiplier_data_out,radix);

                                else
                                    integrator := integrator + get_result(multiplier_data_out,radix);

                                end if;
                                increment(process_counter);

                            WHEN 5 =>
                                alu_mpy(pi_out,70,multiplier_data_in);
                                increment(process_counter);

                            WHEN 6 =>
                                if multiplier_is_ready(multiplier_data_out) then
                                    phase_modulator_data_in.phase <= get_result(multiplier_data_out,16);
                                    trigger(phase_modulator_data_in.tg_load_phase);
                                    process_counter := 0;
                                end if;

                            WHEN others =>
                                process_counter := 0;
                        end CASE;

                    WHEN trip =>
                end CASE;
    
            end if; -- rstn
        end if; --rising_edge
    end process dhb_control;	
------------------------------------------------------------------------
    phase_modulator_clocks <= (core_clock     => core_clock,
                              modulator_clock => modulator_clock);

    u_phase_modulator : phase_modulator
    generic map(g_carrier_max_value)
    port map (
        phase_modulator_clocks,
        dhb_control_FPGA_out.phase_modulator_FPGA_out,
        phase_modulator_data_in,
        phase_modulator_data_out);
------------------------------------------------------------------------
end rtl;
