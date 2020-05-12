library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.measurement_interface_pkg.all;
    use onboard_adc_library.psu_measurement_interface_pkg.all;

library common_library;
    use common_library.timing_pkg.all;

library work;
    use work.llc_control_pkg.all;
    use work.llc_control_internal_pkg.all;
    use work.llc_modulator_pkg.all;
    use work.multiplier_pkg.all;

entity llc_control is
    port (
        llc_control_clocks : in llc_control_clock_group;
        llc_control_FPGA_out : out llc_control_FPGA_output_group;
        llc_control_data_in : in llc_control_data_input_group;
        llc_control_data_out : out llc_control_data_output_group
    );
end llc_control;

architecture rtl of llc_control is

    alias core_clock is llc_control_clocks.core_clock;
    alias modulator_clock is llc_control_clocks.modulator_clock;
    alias adc_interface is llc_control_data_in.measurement_interface_data_out;
----------------------- module internal signals ------------------------
    signal llc_voltage : int18;
----------------------- multiplier signals -----------------------------
    signal multiplier_clocks   : multiplier_clock_group;
    signal multiplier_data_in  : multiplier_data_input_group;
    signal multiplier_data_out :  multiplier_data_output_group;
----------------------- modulator interface signals --------------------
    signal llc_modulator_clocks   : llc_modulator_clock_group;
    signal llc_modulator_data_in  : llc_modulator_data_input_group;
    signal llc_modulator_data_out : llc_modulator_data_output_group;
------------------------------------------------------------------------
    signal delay_timer_data_in  : delay_timer_data_input_group;
    signal delay_timer_data_out : delay_timer_data_output_group;
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
            multiplier_data_out 
        );
------------------------------------------------------------------------
    heater_control : process(core_clock)
        type t_heater_control_states is (idle, precharge, run, tripped);
        variable st_heater_control_states : t_heater_control_states;
        ------------------------------------------------------------------------
        
    begin
        if rising_edge(core_clock) then
            if llc_control_clocks.pll_lock = '0' then
                disable_llc_modulator(llc_modulator_data_in);
                st_heater_control_states := idle;
            else
                -- get llc voltage measurement from measurement bus
                get_llc_voltage(adc_interface, llc_voltage);

                CASE st_heater_control_states is
                    WHEN idle =>

                        disable_llc_modulator(llc_modulator_data_in);
                        init_timer(delay_timer_data_in);

                        st_heater_control_states := idle;
                        if llc_converter_is_enabled(llc_control_data_in) then
                            st_heater_control_states := precharge;
                        end if;

                    WHEN precharge =>
                    -- wait for precharge ready
                        enable_llc_modulator(llc_modulator_data_in);
                        set_period(473,llc_modulator_data_in);

                        request_delay(delay_timer_data_in,delay_timer_data_out,50);

                        st_heater_control_states := precharge;
                        if timer_is_ready(delay_timer_data_out) then
                            st_heater_control_states := run;
                        end if;

                    WHEN run =>

                        st_heater_control_states := run;
                        -- 1. measure voltage with maximum switching frequency
                        -- 2. set reference to match measurement
                        -- 3. add 1 to measurement until reference matches set value

                    WHEN others =>
                        disable_llc_modulator(llc_modulator_data_in);
                end CASE;
            end if;
        end if; --rising_edge
    end process heater_control;	
------------------------------------------------------------------------
    --TODO, create control logic for safe llc start
    llc_modulator_clocks <= (core_clock => core_clock, modulator_clock => modulator_clock);
    -- llc_modulator_data_in.llc_is_enabled <= std_to_bool(llc_control_clocks.pll_lock);
    u_llc_modulator : llc_modulator
    port map
    (
        llc_modulator_clocks,
        llc_control_FPGA_out.llc_modulator_FPGA_out,
        llc_modulator_data_in, 
        llc_modulator_data_out
    );
------------------------------------------------------------------------
end rtl;
