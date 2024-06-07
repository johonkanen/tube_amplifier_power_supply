LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;
    use std.textio.all;

library vunit_lib;
context vunit_lib.vunit_context;

    use work.fpga_interconnect_pkg.all;
    use work.real_to_fixed_pkg.all;
    use work.write_pkg.all;
    use work.boost_model_pkg.all;

entity boost_entity_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of boost_entity_tb is

    constant clock_period      : time    := 1 ns;
    constant stoptime : real := 10.0e-3;
    signal simulation_counter  : natural   := 0;
    
    signal simulator_clock     : std_logic := '0';
    -----------------------------------
    -- simulation specific signals ----
    ------------------------------------------------------------------------

    signal realtime   : real := 0.0;

    signal bus_from_stimulus    : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_boost_model : fpga_interconnect_record := init_fpga_interconnect;

    signal processor_ready : boolean := false;

    signal duty_0_to_1            : natural range 0 to 2**16-1 := integer(0.5 * 2.0**15);
    signal input_voltage_0_to_512 : natural range 0 to 2**16-1 := integer(100.0 * 2.0**7);

    signal rtl_current : integer range -2**15 to 2**15-1 := 0;
    signal rtl_voltage : integer range -2**15 to 2**15-1 := 0;
    signal ref_current : real := 0.0;
    signal ref_voltage : real := 0.0;

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

        constant load_10A     : std_logic_vector(15 downto 0) := to_fixed(number => 10.0, bit_width => 16, number_of_fractional_bits => 11);
        constant voltage_120V : std_logic_vector(15 downto 0) := to_fixed(number => 120.0, bit_width => 16, number_of_fractional_bits => 15-7);
        file file_handler         : text open write_mode is "boost_entity_tb.dat";


        variable ref_input_voltage : real := 100.0;
        variable ref_load_current  : real := 0.0;
        variable ref_duty          : real := 0.5;

        constant initial_voltage : real := 100.0;

        variable inductor_current : real := 0.0;
        variable dc_link_voltage  : real := initial_voltage;
        variable boost_model : boost_model_record := (0.0, initial_voltage);

    begin
        if rising_edge(simulator_clock) then
            simulation_counter <= simulation_counter + 1;
            if simulation_counter = 0 then
                init_simfile(file_handler, ("time", "volt", "curr", "vref", "iref"));
                boost_model := calculate_boost(self => boost_model, duty => ref_duty, load_current => ref_load_current, input_voltage => ref_input_voltage);
            end if;

            init_bus(bus_from_stimulus);
            if realtime > 2.0e-3 then
                ref_duty := 0.25;
                write_data_to_address(bus_from_stimulus, 3, integer(ref_duty*2.0**15));
            end if;

            if realtime > 4.0e-3 then
                ref_input_voltage := 120.0;
                write_data_to_address(bus_from_stimulus, 2, integer(ref_input_voltage*2.0**7));
                input_voltage_0_to_512 <= integer(120*2.0**7);
            end if;

            if realtime > 6.0e-3 then
                ref_load_current := -10.0;
                write_data_to_address(bus_from_stimulus, 1, to_fixed(number => abs(ref_load_current), bit_width => 16, number_of_fractional_bits => 11));
            end if;

            if processor_ready then
                write_to(file_handler,(realtime, real(rtl_voltage)/2.0**6, real(rtl_current)/2.0**7, boost_model.dc_link_voltage, boost_model.inductor_current));
                realtime <= realtime + work.boost_model_pkg.timestep;
                boost_model := calculate_boost(self => boost_model, duty => ref_duty, load_current => ref_load_current, input_voltage => ref_input_voltage);
            end if;
        end if; --rising_edge
    end process stimulus;	
------------------------------------------------------------------------

    u_boost_model : entity work.boost_model
    port map(
        clock        => simulator_clock      ,
        bus_to_boost_model     => bus_from_stimulus    ,
        bus_from_boost_model   => bus_from_boost_model ,

        rtl_current => rtl_current,
        rtl_voltage => rtl_voltage,

        program_ready        => processor_ready);
------------------------------------------------------------------------
end vunit_simulation;
