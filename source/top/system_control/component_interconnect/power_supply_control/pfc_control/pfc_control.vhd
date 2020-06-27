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
    alias pfc_data_to_uart is pfc_control_data_out.pfc_data_to_uart;
-------------------- feedback measurements -----------------------------
    alias measurement_interface is pfc_control_data_in.measurement_interface_data_out;
    signal pfc_I1_measurement : int18;
    signal pfc_I2_measurement : int18;
    signal DC_link_voltage_measurement : int18;
    signal AC_voltage_measurement : int18;
------------------------------------------------------------------------
    signal multiplier_clocks   : multiplier_clock_group;
    signal multiplier_data_in  : multiplier_input_array(0 to 2);
    signal multiplier_data_out : multiplier_output_array(0 to 2);
------------------------------------------------------------------------
    signal delay_timer_50us_in  : delay_timer_data_input_group;
    signal delay_timer_50us_out : delay_timer_data_output_group;
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

    constant ac_voltage_10v : int18 := 32768/663/2*10;

------------------------ voltage control signals -----------------------
    for u_pfc_voltage_control : feedback_control use entity work.feedback_control(arch_pfc_voltage_control);

    constant number_of_voltage_control_measurements : natural := 2;
    signal voltage_control_input : feedback_measurements(0 to number_of_voltage_control_measurements -1);
    signal voltage_control_output : feedback_control_data_output_group;

    signal voltage_control_data_from_multiplier        : multiplier_data_output_group;
    signal voltage_control_data_to_multiplier          : multiplier_data_input_group;
    signal voltage_control_feedback_control_is_enabled : boolean;
    signal trigger_voltage_control : boolean;

------------------------ current control signals -----------------------
    for u_pfc_current_control : feedback_control use entity work.feedback_control(arch_pfc_current_control);

    constant number_of_measurements    : natural := 4;
    signal feedback_control_clocks     : feedback_control_clock_group;
    signal current_control_input    : feedback_measurements(0 to number_of_measurements -1);
    signal current_control_output   : feedback_control_data_output_group;
    signal data_from_multiplier        : multiplier_data_output_group;
    signal data_to_multiplier          : multiplier_data_input_group;
    signal feedback_control_is_enabled : boolean;

    signal pfc_duty_during_ramp_up : int8;

------------------------------------------------------------------------
begin

------------------------------------------------------------------------
    delay_50us : delay_timer
    generic map (count_up_to => 5*1280)
    port map( core_clock,
    	  delay_timer_50us_in,
    	  delay_timer_50us_out);

------------------------------------------------------------------------
    multiplier_clocks.dsp_clock <= core_clock;

    pfc_multiplier_generator : for i in 0 to 2 generate
    u_multiplier : multiplier
        port map(
            multiplier_clocks, 
            multiplier_data_in(i),
            multiplier_data_out(i) 
        );
    end generate;

------------------------------------------------------------------------
    multiplier_data_in(0) <= voltage_control_data_to_multiplier;
    voltage_control_data_from_multiplier <= multiplier_data_out(0);

    voltage_control_input(0).control_reference           <= dc_link_ref_250V;
    voltage_control_input(0).measurement                 <= DC_link_voltage_measurement;
    voltage_control_input(1).measurement                 <= AC_voltage_measurement;
    voltage_control_input(0).control_is_requested        <= trigger_voltage_control;
    voltage_control_input(0).feedback_control_is_enabled <= feedback_control_is_enabled;

    feedback_control_clocks <= (clock => core_clock);
    
    u_pfc_voltage_control : feedback_control
    generic map(number_of_voltage_control_measurements)
    port map(feedback_control_clocks,
             voltage_control_input,
             voltage_control_output,
             voltage_control_data_from_multiplier,
             voltage_control_data_to_multiplier);

------------------------------------------------------------------------
    multiplier_data_in(1) <= data_to_multiplier;
    data_from_multiplier <= multiplier_data_out(1);

    current_control_input(0).control_reference <= voltage_control_output.control_out;
    current_control_input(0).control_is_requested <= pfc_current_is_buffered;
    current_control_input(0).feedback_control_is_enabled <= feedback_control_is_enabled;
    current_control_input(0).measurement <= DC_link_voltage_measurement;
    current_control_input(1).measurement <= AC_voltage_measurement;
    current_control_input(2).measurement <= pfc_I1_measurement;
    current_control_input(3).measurement <= pfc_I2_measurement;

    u_pfc_current_control : feedback_control
    generic map(number_of_measurements)
    port map(feedback_control_clocks,
             current_control_input,
             current_control_output,
             data_from_multiplier,
             data_to_multiplier);

------------------------------------------------------------------------
    pfc_control : process(core_clock)
        type t_pfc_control_state is (idle, precharge, rampup, pfc_running, pfc_tripped);
        variable st_pfc_control_state : t_pfc_control_state;
        constant radix_15 : int18 := 15;
        variable voltage_control_trigger_delay : uint5;

    begin
        if rising_edge(core_clock) then
            if pll_lock = '0' then
            -- reset state
                st_pfc_control_state := idle;
                set_duty(0,pfc_modulator_data_in);
                disable_pfc_modulator(pfc_modulator_data_in);
                feedback_control_is_enabled <= false;
                pfc_duty_during_ramp_up <= 50;

                pfc_control_data_out.pfc_is_ready <= false;
                voltage_control_trigger_delay := 0;
                trigger_voltage_control <= false;
            else

                ------------- buffer pfc measurements --------------
                pfc_current_is_buffered <= pfc_I1_is_ready(measurement_interface);
                vac_is_buffered <= vac_is_ready(measurement_interface);



                if vac_is_ready(measurement_interface) then
                    AC_voltage_measurement <= get_adb_measurement(measurement_interface) - 16088;
                    increment(voltage_control_trigger_delay);
                end if;

                trigger_voltage_control <= false;
                if voltage_control_trigger_delay = 20 then
                    voltage_control_trigger_delay := 0;
                    trigger_voltage_control <= true;
                end if;

                if pfc_I1_is_ready(measurement_interface) then
                    pfc_I1_measurement <= get_adb_measurement(measurement_interface) - 16050;
                end if;

                if pfc_I2_is_ready(measurement_interface) then
                    pfc_I2_measurement <= get_ada_measurement(measurement_interface) - 16050;
                end if;

                -- route pfc current measurement to uart
                if pfc_I2_measurement > pfc_I2_measurement then
                    pfc_data_to_uart.current_measurement <= pfc_I2_measurement;
                else
                    pfc_data_to_uart.current_measurement <= pfc_I1_measurement;
                end if;

                get_DC_link(measurement_interface,DC_link_voltage_measurement);
                -- get_vac    (measurement_interface,AC_voltage_measurement);
                -- get_pfc_I1 (measurement_interface,pfc_I1_measurement);
                -- get_pfc_I2 (measurement_interface,pfc_I2_measurement);
                ----------------------------------------------------

                -- TODO, overvoltage trip, overcurrent trip

                feedback_control_is_enabled <= false;
                pfc_control_data_out.pfc_is_ready <= false;
                enable_multiplier(multiplier_data_in(2));
                init_timer(delay_timer_50us_in);

                CASE st_pfc_control_state is
                    WHEN idle =>
                        disable_pfc_modulator(pfc_modulator_data_in);
                        pfc_duty_during_ramp_up <= 10;


                        st_pfc_control_state := idle;
                        if pfc_control_data_in.enable_pfc then
                            st_pfc_control_state := precharge;
                            set_duty(10,pfc_modulator_data_in);
                        end if;

                    WHEN precharge =>
                        enable_pfc_modulator(pfc_modulator_data_in);
                        request_delay(delay_timer_50us_in,delay_timer_50us_out,20);

                        if timer_is_ready(delay_timer_50us_out) then
                            set_duty(pfc_duty_during_ramp_up,pfc_modulator_data_in);
                            pfc_duty_during_ramp_up <= pfc_duty_during_ramp_up + 1;
                        end if;

                        st_pfc_control_state := precharge;
                        if pfc_duty_during_ramp_up = 120 then
                            st_pfc_control_state := rampup;
                        end if;


                    WHEN rampup => 
                        st_pfc_control_state := rampup;

                        request_delay(delay_timer_50us_in,delay_timer_50us_out,1000);
                        if timer_is_ready(delay_timer_50us_out) or 
                            abs(AC_voltage_measurement) < ac_voltage_10v then

                            st_pfc_control_state := pfc_running;
                        end if;

                    WHEN pfc_running => 
                        st_pfc_control_state := pfc_running;

                        pfc_control_data_out.pfc_is_ready <= true;
                        feedback_control_is_enabled <= true;

                        if feedback_is_ready(current_control_output) then
                            alu_mpy(get_control_output(current_control_output),920,multiplier_data_in(2));
                        end if;

                        if multiplier_is_ready(multiplier_data_out(2)) then
                            set_duty(get_result(multiplier_data_out(2),15),pfc_modulator_data_in);
                        end if;

                    WHEN pfc_tripped => 
                        -- TODO, go to tripped at overcurrent or overvoltage

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
