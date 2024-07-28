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
    constant stoptime         : real    := 220.0e-3;
    signal simulation_counter : natural := 0;
    
    signal simulator_clock     : std_logic := '0';
    -----------------------------------
    -- simulation specific signals ----
    ------------------------------------------------------------------------

    signal realtime   : real := 0.0;

    signal bus_from_stimulus    : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_boost_model : fpga_interconnect_record := init_fpga_interconnect;

    signal calculation_interval : real := 1.0/30.0e3;
    signal interrupt_time       : real := 0.0;

    constant cl_parameters : boost_model_parameters_record := (
        inductance  => 500.0e-6 ,
        capacitance => 320.0e-6 ,
        rl          => 100.0e-3 ,
        timestep    => 4.0e-6);

    signal vkp : integer := to_fixed(0.05          , 15);
    signal vki : integer := to_fixed(0.016125/10.0 , 15);

    constant dutymax : integer := to_fixed(0.90, number_of_fractional_bits => 15);
    constant dutymin : integer := to_fixed(0.10, number_of_fractional_bits => 15);

    constant initial_voltage : real := 330.0;

    signal boost_model_interface : boost_model_interface_record;
    alias rtl_current is boost_model_interface.output.rtl_current;
    alias rtl_voltage is boost_model_interface.output.rtl_voltage;

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

        variable inductor_current : real := 0.0;
        variable dc_link_voltage  : real := initial_voltage;
        variable voltage_reference : real := 400.0;

        variable mains_voltage           : real := 0.0;
        variable mains_voltage_amplitude : real := 325.0;
    -------------------------------------
        procedure request_pfc_control
        (
            signal self : inout pfc_control_record;
            current_measurement : in integer;
            voltage_measurement : in integer
        ) is
        begin
            self.pfc_sequence <= 0;
            self.current_measurement <= current_measurement;

            if self.pfc_ref_counter < 9 then
                self.pfc_ref_counter <= self.pfc_ref_counter + 1;
            else
                self.pfc_ref_counter <= 0;
                request_voltage_control(self.voltage_control, to_fixed(400.0 , 7) , voltage_measurement);
            end if;
        end request_pfc_control;
    -------------------------------------

    begin
        if rising_edge(simulator_clock) then
            simulation_counter <= simulation_counter + 1;
            if simulation_counter = 0 then
                init_simfile(file_handler, ("time", "volt", "curr"));
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
            if current_control_is_ready(self) then
                do_a_thing <= true;
                set_duty(boost_model_interface, get_duty(self));

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
                        if realtime > 100.0e-3 then -- if (t > 40.0e-3) vin = 130.0;
                            ref_load_current := -2.0;
                            write_data_to_address(bus_from_stimulus, 1, std_logic_vector(-to_signed(to_fixed(ref_load_current, 11), 16)));
                            sequence_counter <= sequence_counter + 1;
                        end if;
                    WHEN others =>
                end CASE;
            end if;

            if boost_model_is_ready(boost_model_interface) then
                write_to(file_handler,(realtime, real(to_integer(signed(rtl_voltage)))/2.0**6, real(to_integer(signed(rtl_current)))/2.0**11));
                realtime <= realtime + cl_parameters.timestep;
                request_boost_calculation(boost_model_interface);

                if realtime >= interrupt_time then
                    interrupt_time <= realtime + calculation_interval;
                    request_pfc_control(self, to_integer(signed(rtl_current)), to_integer(signed(rtl_voltage))*2);
                end if;
            end if;
            if simulation_counter = 0 then
                request_boost_calculation(boost_model_interface);
            end if;

        end if; --rising_edge
    end process stimulus;	
------------------------------------------------------------------------

    u_boost_model : entity work.boost_model
    generic map(boost_model_parameters => cl_parameters,
                initial_voltage        => initial_voltage,
                inductor_current_radix => 11)
    port map(
        clock => simulator_clock ,

        bus_to_boost_model   => bus_from_stimulus,
        bus_from_boost_model => bus_from_boost_model,

        boost_in  => boost_model_interface.input,
        boost_out => boost_model_interface.output);
  ----------------------------------------------------------------------
end vunit_simulation;
