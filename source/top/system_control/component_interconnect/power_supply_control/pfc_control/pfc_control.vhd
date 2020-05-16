library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.psu_measurement_interface_pkg.all;

library common_library;
    use common_library.timing_pkg.all;
    use common_library.typedefines_pkg.all;

library work;
    use work.pfc_control_pkg.all;
    use work.multiplier_pkg.all;
    use work.pfc_modulator_pkg.all;
    use work.feedback_control_pkg.all;

entity pfc_control is
        generic( g_carrier_max_value : integer);
        port (
            pfc_control_clocks : in pfc_control_clock_group;
            pfc_control_FPGA_out : out pfc_control_FPGA_output_group;
            pfc_control_data_in : in pfc_control_data_input_group;
            pfc_control_data_out : out pfc_control_data_output_group
        );
end pfc_control;

architecture rtl of pfc_control is
------------------------------------------------------------------------
    alias core_clock      is pfc_control_clocks.core_clock;
    alias modulator_clock is pfc_control_clocks.modulator_clock;
    alias pll_lock        is pfc_control_clocks.pll_lock;
-------------------- feedback measurements -----------------------------
    alias measurement_interface is pfc_control_data_in.measurement_interface_data_out;
    signal pfc_I1_measurement : int18;
    signal pfc_I2_measurement : int18;
    signal DC_link_voltage_measurement : int18;
    signal AC_voltage_measurement : int18;
------------------------------------------------------------------------
    signal multiplier_clocks   : multiplier_clock_group;
    signal multiplier_data_in  : multiplier_data_input_group;
    signal multiplier_data_out : multiplier_data_output_group;
------------------------------------------------------------------------
    signal multiplier_2_data_in  : multiplier_data_input_group;
    signal multiplier_2_data_out : multiplier_data_output_group;
------------------------------------------------------------------------
    signal delay_timer_data_in  : delay_timer_data_input_group;
    signal delay_timer_data_out : delay_timer_data_output_group;
------------------------------------------------------------------------
    signal pfc_modulator_clocks   : pfc_modulator_clock_group;
    signal pfc_modulator_data_in  : pfc_modulator_data_input_group;
    signal pfc_modulator_data_out : pfc_modulator_data_output_group;

--------------------- pfc control definitions --------------------------
    signal pfc_current_is_buffered : boolean;
    signal vac_is_buffered : boolean;

    constant dc_link_ref_150V : int18 := 32768/663*150;
    constant dc_link_ref_200V : int18 := 32768/663*200;
    constant dc_link_ref_250V : int18 := 32768/663*250;
    constant dc_link_ref_300V : int18 := 32768/663*300;
    constant dc_link_ref_350V : int18 := 32768/663*350;
    constant dc_link_ref_400V : int18 := 32768/663*400;

------------------------ current control signals -----------------------
    for u_pfc_current_control : feedback_control use entity work.feedback_control(arch_pfc_current_control);

    constant number_of_measurements    : natural := 4;
    signal feedback_control_clocks     : feedback_control_clock_group;
    signal feedback_control_data_in    : feedback_measurements(0 to number_of_measurements -1);
    signal feedback_control_data_out   : feedback_control_data_output_group;
    signal data_from_multiplier        : multiplier_data_output_group;
    signal data_to_multiplier          : multiplier_data_input_group;
    signal feedback_control_is_enabled : boolean;

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
    multiplier_clocks.dsp_clock <= core_clock;
    u_multiplier_2 : multiplier
        port map(
            multiplier_clocks, 
            multiplier_2_data_in,
            multiplier_2_data_out 
        );

------------------------------------------------------------------------
    feedback_control_data_in(0).feedback_control_is_enabled <= feedback_control_is_enabled;
    feedback_control_data_in(0).measurement <= DC_link_voltage_measurement;
    feedback_control_data_in(1).measurement <= AC_voltage_measurement;
    feedback_control_data_in(2).measurement <= pfc_I1_measurement;
    feedback_control_data_in(3).measurement <= pfc_I2_measurement;

    u_pfc_current_control : feedback_control
    generic map(number_of_measurements)
    port map(feedback_control_clocks,
             feedback_control_data_in,
             feedback_control_data_out,
             data_from_multiplier,
             data_to_multiplier);

------------------------------------------------------------------------
    pfc_control : process(core_clock)
        type t_pfc_control_state is (idle, precharge, rampup, pfc_running, pfc_tripped);
        variable st_pfc_control_state : t_pfc_control_state;
        constant radix_15 : int18 := 15;

    begin
        if rising_edge(core_clock) then
            if pll_lock = '0' then
            -- reset state
                st_pfc_control_state := idle;
                set_duty(0,pfc_modulator_data_in);
                disable_pfc_modulator(pfc_modulator_data_in);
                feedback_control_is_enabled <= false;

                pfc_control_data_out.pfc_is_ready <= false;
            else
                ------------- buffer pfc measurements --------------
                pfc_current_is_buffered <= pfc_I1_is_ready(measurement_interface);
                vac_is_buffered <= vac_is_ready(measurement_interface);

                get_DC_link(measurement_interface,DC_link_voltage_measurement);
                get_vac    (measurement_interface,AC_voltage_measurement);
                get_pfc_I1 (measurement_interface,pfc_I1_measurement);
                get_pfc_I2 (measurement_interface,pfc_I2_measurement);
                ----------------------------------------------------

                -- TODO, overvoltage trip, overcurrent trip

                feedback_control_is_enabled <= false;

                pfc_control_data_out.pfc_is_ready <= false;
                multiplier_data_in.multiplication_is_requested <= false;
                multiplier_2_data_in.multiplication_is_requested <= false;
                CASE st_pfc_control_state is
                    WHEN idle =>
                        disable_pfc_modulator(pfc_modulator_data_in);
                        if pfc_control_data_in.enable_pfc then
                            st_pfc_control_state := precharge;
                        end if;

                    WHEN precharge =>
                        enable_pfc_modulator(pfc_modulator_data_in);
                        set_duty(50,pfc_modulator_data_in);
                        request_delay(delay_timer_data_in,delay_timer_data_out,1000);

                        if timer_is_ready(delay_timer_data_out) then
                            st_pfc_control_state := rampup;
                        end if;

                    WHEN rampup => 
                        request_delay(delay_timer_data_in,delay_timer_data_out,1);

                        if timer_is_ready(delay_timer_data_out) then
                            st_pfc_control_state := pfc_running;
                        end if;

                    WHEN pfc_running => 
                        pfc_control_data_out.pfc_is_ready <= true;
                        feedback_control_is_enabled <= true;

                        if feedback_is_ready(feedback_control_data_out) then
                            set_duty(get_control_output(feedback_control_data_out),pfc_modulator_data_in);
                        end if;

                    WHEN pfc_tripped => 

                end CASE;
            end if; -- rstn
        end if; --rising_edge
    end process pfc_control;	
------------------------------------------------------------------------
    pfc_modulator_clocks <= (modulator_clock => modulator_clock, core_clock => core_clock);
    pfc_modulator_data_in.pfc_carrier <= pfc_control_data_in.pfc_carrier;
    u_pfc_modulator : pfc_modulator
        generic map( g_carrier_max_value)
        port map 
        (
            pfc_modulator_clocks,
            pfc_control_FPGA_out.pfc_modulator_FPGA_out,
            pfc_modulator_data_in,
            pfc_modulator_data_out
        );
------------------------------------------------------------------------
end rtl;
