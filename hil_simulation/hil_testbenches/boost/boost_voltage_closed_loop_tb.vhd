
------------------------------------------------------------------------
------------------------------------------------------------------------
LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;
    use std.textio.all;

library vunit_lib;
context vunit_lib.vunit_context;

    use work.fpga_interconnect_pkg.all;
    use work.write_pkg.all;
    use work.boost_model_pkg.all;
    use work.real_to_fixed_pkg.all;
    use work.multiplier_pkg.all;
    use work.division_pkg.all;

    use work.voltage_control_pkg.all;

    use work.half_bridge_current_control_pkg.all;

entity boost_voltage_closed_loop_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of boost_voltage_closed_loop_tb is

    constant clock_period     : time    := 1 ns;
    constant stoptime         : real    := 100.0e-3;
    signal simulation_counter : natural := 0;
    
    signal simulator_clock     : std_logic := '0';
    -----------------------------------
    -- simulation specific signals ----
    ------------------------------------------------------------------------

    signal realtime : real := 0.0;

    signal bus_from_stimulus    : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_boost_model : fpga_interconnect_record := init_fpga_interconnect;

    signal processor_ready : boolean := false;

    signal duty_0_to_1            : natural range 0 to 2**16-1 := to_fixed(0.5   , number_of_fractional_bits => 15);
    signal input_voltage_0_to_512 : natural range 0 to 2**16-1 := to_fixed(100.0 , number_of_fractional_bits => 7);

    signal rtl_current : integer range -2**15 to 2**15-1 := 0;
    signal rtl_voltage : integer range -2**15 to 2**15-1 := 0;
    signal ref_current : real := 0.0;
    signal ref_voltage : real := 0.0;

    constant cl_parameters : boost_model_parameters_record := (
        inductance  => 500.0e-6 ,
        capacitance => 320.0e-6 ,
        rl          => 100.0e-3 ,
        timestep    => 1.5e-6);

    signal calculation_interval : real := 1.0/30.0e3;
    signal interrupt_time : real := 0.0;

    constant dutymax : integer  := to_fixed(0.90, number_of_fractional_bits => 15);
    constant dutymin  : integer := to_fixed(0.10, number_of_fractional_bits => 15);

    signal iref       : int := to_fixed(4.0, number_of_fractional_bits => 11);
    signal check_duty : real := 0.0;

    signal current_control : current_control_record := init_current_control(16.0, 10.0, number_of_fractional_bits => 7);

    signal multiplier         : multiplier_record := init_multiplier;
    signal divider            : division_record   := init_division;
    signal divider_multiplier : multiplier_record := init_multiplier;

    signal vkp : integer := to_fixed(0.5, 11);
    signal vki : integer := to_fixed(0.5, 11);
    signal voltage_multiplier : multiplier_record := init_multiplier;


    signal self : voltage_control_record := init_voltage_control;

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

        constant load_10A     : std_logic_vector(15 downto 0) := to_fixed(number => 10.0  , bit_width => 16 , number_of_fractional_bits => 11);
        constant voltage_120V : std_logic_vector(15 downto 0) := to_fixed(number => 120.0 , bit_width => 16 , number_of_fractional_bits => 15-7);
        file file_handler     : text open write_mode is "boost_voltage_closed_loop.dat";

        variable ref_input_voltage : real := 100.0;
        variable ref_load_current  : real := 0.0;
        variable ref_duty          : real := 0.5;

        constant initial_voltage : real := 150.0;

        variable inductor_current  : real := 0.0;
        variable dc_link_voltage   : real := initial_voltage;
        variable boost_model       : boost_model_record := (0.0, initial_voltage);
        variable voltage_reference : real := 200.0;



    begin
        if rising_edge(simulator_clock) then
            simulation_counter <= simulation_counter + 1;
            if simulation_counter = 0 then
                init_simfile(file_handler, ("time", "volt", "curr", "vref", "iref"));
            end if;

            init_bus(bus_from_stimulus);
            if realtime > 2.0e-3 then
                write_data_to_address(bus_from_stimulus, 3, to_fixed(ref_duty, number_of_fractional_bits => 15));
            end if;

            /* if realtime > 4.0e-3 then */
            /*     ref_input_voltage := 120.0; */
            /*     write_data_to_address(bus_from_stimulus, 2, to_fixed(ref_input_voltage, number_of_fractional_bits => 7)); */
            /*     input_voltage_0_to_512 <= to_fixed(120.0, number_of_fractional_bits => 7); */
            /* end if; */

            if realtime > 20.0e-3 then ref_load_current  := -2.0;  end if;
            if realtime > 30.0e-3 then voltage_reference := 120.0; end if;
            if realtime > 40.0e-3 then ref_input_voltage := 130.0; end if;
            if realtime > 50.0e-3 then voltage_reference := 180.0; end if;
            if realtime > 65.0e-3 then ref_load_current  := 10.0;  end if;
            if realtime > 70.0e-3 then ref_load_current  := -10.0; end if;
            if realtime > 80.0e-3 then ref_load_current  := 0.0;   end if;

            ---------------------
            
            create_divider_and_multiplier(divider,divider_multiplier);
            create_multiplier(multiplier);
            create_current_control(current_control,multiplier, divider, divider_multiplier,
                                    to_fixed(boost_model.dc_link_voltage , number_of_fractional_bits => 7) ,
                                    to_fixed(ref_input_voltage           , number_of_fractional_bits => 7) ,
                                    dutymax                              ,
                                    dutymin);

            create_multiplier(voltage_multiplier);
            create_voltage_control(self, voltage_multiplier,
            proportional_gain => to_fixed(0.25     , 15),
            integral_gain     => to_fixed(0.016125 , 15)
        );

            if realtime >= interrupt_time then
                interrupt_time <= realtime + calculation_interval;
                request_current_control(current_control, self.current_ref, to_fixed(boost_model.inductor_current, number_of_fractional_bits => 11));
                request_voltage_control(self, to_fixed(voltage_reference , 7) , to_fixed(boost_model.dc_link_voltage , number_of_fractional_bits => 7));

            end if;

            if current_control_is_ready(current_control) then
                ref_duty := to_real(to_integer(get_multiplier_result(multiplier, 7, 20, target_radix => 15)), number_of_fractional_bits => 15);
            end if;

            CASE current_control.counter2 is
                WHEN 6 =>
                    write_to(file_handler,(realtime, to_real(rtl_voltage, number_of_fractional_bits => 6), to_real(rtl_current, number_of_fractional_bits => 7), boost_model.dc_link_voltage, boost_model.inductor_current));
                    boost_model := calculate_boost(self => boost_model, parameters => cl_parameters, duty => ref_duty, load_current => ref_load_current, input_voltage => ref_input_voltage);
                    realtime <= realtime + cl_parameters.timestep;
                WHEN others =>
            end CASE;

        end if; --rising_edge
    end process stimulus;	
------------------------------------------------------------------------

    /* u_boost_model : entity work.boost_model */
    /* port map( */
    /*     clock => simulator_clock , */

    /*     bus_to_boost_model     => bus_from_stimulus    , */
    /*     bus_from_boost_model   => bus_from_boost_model , */

    /*     rtl_current => rtl_current , */
    /*     rtl_voltage => rtl_voltage , */

    /*     program_ready        => processor_ready); */
------------------------------------------------------------------------
end vunit_simulation;
