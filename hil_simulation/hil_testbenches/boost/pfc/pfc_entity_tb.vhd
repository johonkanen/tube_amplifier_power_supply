--------------------------
LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;
    use std.textio.all;

library vunit_lib;
context vunit_lib.vunit_context;

    use work.write_pkg.all;
    use work.boost_model_pkg.all;

    use work.fpga_interconnect_pkg.all;
    use work.boost_model_interface_pkg.all;

    use work.real_to_fixed_pkg.all;
    use work.multiplier_pkg.all;
    use work.division_pkg.all;
    use work.voltage_control_pkg.all;
    use work.half_bridge_current_control_pkg.all;
    use work.pfc_control_pkg.all;

entity pfc_entity_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of pfc_entity_tb is

    constant clock_period     : time    := 1 ns;
    constant stoptime         : real    := 200.0e-3;
    signal simulation_counter : natural := 0;
    
    signal simulator_clock     : std_logic := '0';
    -----------------------------------
    -- simulation specific signals ----
    ------------------------------------------------------------------------

    signal realtime   : real := 0.0;

    signal bus_from_stimulus : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_boost_model : fpga_interconnect_record := init_fpga_interconnect;

    signal calculation_interval : real := 1.0/30.0e3;
    signal interrupt_time       : real := 0.0;

    constant cl_parameters : boost_model_parameters_record := (
        inductance  => 500.0e-6 ,
        capacitance => 320.0e-6 ,
        rl          => 100.0e-3 ,
        timestep    => 2.5e-6);

    signal vkp : integer := to_fixed(0.05          , 15);
    signal vki : integer := to_fixed(0.016125/10.0 , 15);

    constant dutymax : integer := to_fixed(0.90, number_of_fractional_bits => 15);
    constant dutymin : integer := to_fixed(0.10, number_of_fractional_bits => 15);

    constant initial_voltage : real := 330.0;

    signal boost_model_interface : boost_model_interface_record;
    alias rtl_current is boost_model_interface.output.rtl_current;
    alias rtl_voltage is boost_model_interface.output.rtl_voltage;

    signal pfc_ref_counter : natural := 9;

    signal self : pfc_control_record := init_pfc_control;

    signal sequence_counter : natural := 0;
    signal do_a_thing : boolean := true;

------------------------------------------------------------------------
begin

------------------------------------------------------------------------
    simtime : process
    begin
        test_runner_setup(runner, runner_cfg);
        wait until realtime > stoptime;
        test_runner_cleanup(runner); -- Simulation ends here
        wait;
    end process simtime;	

    simulator_clock <= not simulator_clock after clock_period/2.0;
------------------------------------------------------------------------

    stimulus : process(simulator_clock)

        file file_handler         : text open write_mode is "pfc_entity_tb.dat";

        variable ref_input_voltage : real := 100.0;
        variable ref_load_current  : real := 0.0;
        variable ref_duty          : real := 0.5;


        variable inductor_current : real := 0.0;
        variable dc_link_voltage  : real := initial_voltage;
        variable boost_model : boost_model_record := (0.0, initial_voltage);
        variable voltage_reference : real := 400.0;

        variable mains_voltage           : real := 0.0;
        variable mains_voltage_amplitude : real := 325.0;

    begin
        if rising_edge(simulator_clock) then
            simulation_counter <= simulation_counter + 1;
            if simulation_counter = 0 then
                init_simfile(file_handler, ("time", "volt", "curr", "vref", "iref"));
            end if;

            create_boost_model_interface(boost_model_interface);
            init_bus(bus_from_stimulus);

            create_pfc_control(self             ,
                to_integer(signed(rtl_voltage)) ,
                to_fixed(ref_input_voltage      , number_of_fractional_bits => 7) ,
                dutymax ,
                dutymin ,
                vkp     ,
                vki);

            do_a_thing <= false;
            if current_control_is_ready(self.current_control) then
                ref_duty := to_real(to_integer(get_multiplier_result(self.multiplier, 7, 20, target_radix => 15)), number_of_fractional_bits => 15);
                do_a_thing <= true;

                set_duty(boost_model_interface, get_int_multiplier_result(self.multiplier, 7, 20, target_radix => 15));

            end if;

            mains_voltage     := sin(realtime*2.0*math_pi*50.0);
            ref_input_voltage := mains_voltage_amplitude * abs(mains_voltage);
            set_input_voltage(boost_model_interface, to_fixed(ref_input_voltage, 7));

            if do_a_thing then
                do_a_thing <= false;
                CASE sequence_counter is 
                    WHEN 0 =>
                        if realtime > 00.0e-3 then -- if (t > 20.0e-3) iload = -2.0;
                            ref_load_current := -0.3;
                            write_data_to_address(bus_from_stimulus, 1, std_logic_vector(-to_signed(to_fixed(ref_load_current, 11), 16)));
                            sequence_counter <= sequence_counter + 1;
                        end if;
                    WHEN 1 =>
                        if realtime > 30.0e-3 then -- if (t > 30.0e-3) vref = 120.0;
                            /* voltage_reference := 120.0; */
                            sequence_counter <= sequence_counter + 1;
                        end if;
                    WHEN 2 =>
                        if realtime > 100.0e-3 then -- if (t > 40.0e-3) vin = 130.0;
                            ref_load_current := -2.0;
                            write_data_to_address(bus_from_stimulus, 1, std_logic_vector(-to_signed(to_fixed(ref_load_current, 11), 16)));
                            /* ref_input_voltage := 130.0; */
                            /* /1* write_data_to_address(bus_from_stimulus, 2, std_logic_vector(to_signed(to_fixed(ref_input_voltage, 7), 16))); *1/ */
                            /* set_input_voltage(boost_model_interface, to_fixed(ref_input_voltage, 7)); */
                            sequence_counter <= sequence_counter + 1;
                        end if;
                    WHEN 3 =>
                        if realtime > 50.0e-3 then -- if (t > 50.0e-3) vref = 180.0;
                            /* voltage_reference := 180.0; */
                            sequence_counter <= sequence_counter + 1;
                        end if;
                    WHEN 4 =>
                        if realtime > 65.0e-3 then -- if (t > 65.0e-3) iload = 10.0;
                            /* ref_load_current := -10.0; */
                            /* write_data_to_address(bus_from_stimulus, 1, std_logic_vector(to_signed(to_fixed(ref_load_current, 11), 16))); */
                            sequence_counter <= sequence_counter + 1;
                        end if;
                    WHEN 5 =>
                        if realtime > 70.0e-3 then -- if (t > 70.0e-3) iload = -10.0;
                            /* ref_load_current := 10.0; */
                            /* write_data_to_address(bus_from_stimulus, 1, std_logic_vector(to_signed(to_fixed(ref_load_current, 11), 16))); */
                            sequence_counter <= sequence_counter + 1;
                        end if;
                    WHEN 6 =>
                        if realtime > 80.0e-3 then -- if (t > 80.0e-3) iload = 0.0;
                            /* ref_load_current := 0.0; */
                            /* write_data_to_address(bus_from_stimulus, 1, std_logic_vector(to_signed(to_fixed(ref_load_current, 11), 16))); */
                            sequence_counter <= sequence_counter + 1;
                        end if;
                    WHEN others =>
                end CASE;
            end if;

            if boost_model_is_ready(boost_model_interface) then
                write_to(file_handler,(realtime, real(to_integer(signed(rtl_voltage)))/2.0**6, real(to_integer(signed(rtl_current)))/2.0**7, boost_model.dc_link_voltage, boost_model.inductor_current));
                realtime <= realtime + cl_parameters.timestep;
                request_boost_calculation(boost_model_interface);

                if realtime >= interrupt_time then
                    interrupt_time <= realtime + calculation_interval;

                    request_current_control(self.current_control, 
                            radix_multiply(self.voltage_control.current_ref , to_fixed(ref_input_voltage/325.0,15), int_word_length,15), 
                            to_integer(signed(rtl_current)*2**4));

                    if pfc_ref_counter < 9 then
                        pfc_ref_counter <= pfc_ref_counter + 1;
                    else
                        pfc_ref_counter <= 0;
                        request_voltage_control(self.voltage_control, to_fixed(voltage_reference , 7) , to_integer(signed(rtl_voltage))*2);
                    end if;

                end if;
            end if;
            if simulation_counter = 0 then
                request_boost_calculation(boost_model_interface);
            end if;

        end if; --rising_edge
    end process stimulus;	
------------------------------------------------------------------------

    u_boost_model : entity work.boost_model
    generic map(boost_model_parameters => cl_parameters, initial_voltage => initial_voltage)
    port map(
        clock => simulator_clock ,

        bus_to_boost_model   => bus_from_stimulus,
        bus_from_boost_model => bus_from_boost_model,

        boost_in  => boost_model_interface.input,
        boost_out => boost_model_interface.output);
  ----------------------------------------------------------------------
end vunit_simulation;
