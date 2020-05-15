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
    alias measurement_interface is pfc_control_data_in.measurement_interface_data_out;
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

------------------------ measurement buffers ---------------------------
    signal pfc_I1_measurement : int18;
    signal pfc_I2_measurement : int18;
    signal DC_link_voltage_measurement : int18;
    signal AC_voltage_measurement : int18;
    signal pfc_current_is_buffered : boolean;
    signal vac_is_buffered : boolean;

    constant dc_link_ref_150V : int18 := 32768/663*150;
    constant dc_link_ref_200V : int18 := 32768/663*200;
    constant dc_link_ref_250V : int18 := 32768/663*250;
    constant dc_link_ref_300V : int18 := 32768/663*300;
    constant dc_link_ref_350V : int18 := 32768/663*350;
    constant dc_link_ref_400V : int18 := 32768/663*400;

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
    pfc_control : process(core_clock)
        type t_pfc_control_state is (idle, precharge, rampup, pfc_running);
        variable st_pfc_control_state : t_pfc_control_state;
        variable current_process_counter : uint8;
        variable voltage_process_counter : uint8;

        variable err : int18;
        variable pi_out : int18;
        variable integrator : int18;

        constant ikp : int18 := 22e3;
        constant iki : int18 := 250;

        constant vkp : int18 := 1500;
        constant vki : int18 := 50;

        variable voltage_err : int18;
        variable voltage_pi_out : int18;
        variable voltage_integrator : int18;

        constant radix_15 : int18 := 15;

        variable vkp_x_error : int18;
        variable ikp_x_error : int18;

    begin
        if rising_edge(core_clock) then
            if pll_lock = '0' then
            -- reset state
                st_pfc_control_state := idle;
                set_duty(0,pfc_modulator_data_in);
                disable_pfc_modulator(pfc_modulator_data_in);
                voltage_process_counter := 0;
                current_process_counter := 0;
                voltage_integrator := 0;

                vkp_x_error := 0;
                ikp_x_error := 0;

                voltage_err        := 0;
                voltage_pi_out     := 0;
                voltage_integrator := 0;
            else
                ------------- buffer pfc measurements --------------
                pfc_current_is_buffered <= pfc_I1_is_ready(measurement_interface);
                vac_is_buffered <= vac_is_ready(measurement_interface);

                get_pfc_I1 (measurement_interface,pfc_I1_measurement);
                get_pfc_I2 (measurement_interface,pfc_I2_measurement);
                get_DC_link(measurement_interface,DC_link_voltage_measurement);
                get_vac    (measurement_interface,AC_voltage_measurement);
                ----------------------------------------------------

                -- TODO, overvoltage trip, overcurrent trip

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

                    ----------------- voltage control ----------------         
                        CASE voltage_process_counter is
                            WHEN 0 => 

                                if vac_is_buffered then
                                    increment(voltage_process_counter);
                                    voltage_err := dc_link_ref_150V - DC_link_voltage_measurement;
                                    AC_voltage_measurement <= AC_voltage_measurement - 16040;
                                end if;

                            WHEN 1 => 
                                alu_mpy(vkp,voltage_err,multiplier_2_data_in);
                                increment(voltage_process_counter);

                            WHEN 2 => 
                                alu_mpy(vki,voltage_err,multiplier_2_data_in);
                                increment(voltage_process_counter);
                            WHEN 3 => 
                                -- pipeline integrator calculation
                                increment(voltage_process_counter);

                            WHEN 4 => 
                                voltage_pi_out := get_result(multiplier_2_data_out,radix_15) + voltage_integrator;
                                vkp_x_error := get_result(multiplier_2_data_out,radix_15);
                                increment(voltage_process_counter);

                            WHEN 5 => 
                                if voltage_pi_out > 32768 then
                                    voltage_pi_out := 32768;
                                    voltage_integrator := 32768-vkp_x_error;
                                    increment(voltage_process_counter);
                                end if;

                                if voltage_pi_out < 0 then
                                    voltage_pi_out := 0;
                                    voltage_integrator := 0-vkp_x_error;
                                    increment(voltage_process_counter);
                                end if;
                                
                                if multiplier_is_ready(multiplier_2_data_out) then
                                    voltage_integrator := voltage_integrator + get_result(multiplier_2_data_out,radix_15);
                                    increment(voltage_process_counter);
                                end if;

                            WHEN 6 =>
                                alu_mpy(voltage_pi_out,250,multiplier_2_data_in);
                                increment(voltage_process_counter);
                            WHEN 7 =>
                                if multiplier_is_ready(multiplier_2_data_out) then
                                    -- TODO, route voltage measurement to current reference
                                    voltage_process_counter := 0;
                                end if;

                            WHEN others => 
                                voltage_process_counter := 0;
                        end CASE;

                    ----------------- current control ----------------         

                        CASE current_process_counter is 
                            WHEN 0 =>
                                if pfc_current_is_buffered then
                                    if pfc_I1_measurement > pfc_I2_measurement then
                                        err := 17000 - pfc_I1_measurement;
                                    else
                                        err := 17000 - pfc_I2_measurement;
                                    end if;
                                    increment(current_process_counter);
                                end if;

                            WHEN 1 => 
                                alu_mpy(ikp,err,multiplier_data_in);
                                increment(current_process_counter);

                            WHEN 2 => 
                                increment(current_process_counter);
                                alu_mpy(iki,err,multiplier_data_in);

                            WHEN 3 => 
                                -- pipeline integrator calculation
                                increment(current_process_counter);

                            WHEN 4 => 
                                pi_out := get_result(multiplier_data_out,radix_15) + integrator;
                                ikp_x_error := get_result(multiplier_data_out,radix_15);
                                increment(current_process_counter);

                            WHEN 5 => 
                                if pi_out > 32768 then
                                    pi_out := 32768;
                                    integrator := 32768-get_result(multiplier_data_out,radix_15);
                                    increment(current_process_counter);
                                end if;

                                if pi_out < 6560 then
                                    pi_out := 6560;
                                    integrator := 6560-get_result(multiplier_data_out,radix_15);
                                    increment(current_process_counter);
                                end if;
                                
                                if multiplier_is_ready(multiplier_data_out) then
                                    integrator := integrator + get_result(multiplier_data_out,radix_15);
                                    increment(current_process_counter);
                                end if;


                            WHEN 6 =>
                                alu_mpy(pi_out,250,multiplier_data_in);
                                increment(current_process_counter);

                            WHEN 7 =>
                                if multiplier_is_ready(multiplier_data_out) then
                                    set_duty(get_result(multiplier_data_out,15),pfc_modulator_data_in);
                                    current_process_counter := 0;
                                end if;

                            WHEN others =>
                                current_process_counter := 0;
                        end CASE;

                        -- add rampup of 
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
