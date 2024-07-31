LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;

    use work.boost_model_pkg.all;

    use work.fpga_interconnect_pkg.all;
    use work.boost_rtl_entity_interface_pkg.all;

    use work.real_to_fixed_pkg.all;
    use work.tubepsu_addresses_pkg;
    use work.boost_control_interface_pkg.all;
    use work.sincos_pkg.all;
    use work.multiplier_pkg.all;

    use work.fpga_interconnect_pkg.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity pfc_control_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of pfc_control_tb is

    constant clock_period      : time    := 1 ns;
    constant simtime_in_clocks : integer := 500;
    
    signal simulator_clock     : std_logic := '0';
    signal simulation_counter  : natural   := 0;
    -----------------------------------
    -- simulation specific signals ----
    constant cl_parameters : boost_model_parameters_record := (
        inductance  => 500.0e-6 ,
        capacitance => 320.0e-6 ,
        rl          => 100.0e-3 ,
        timestep    => 1.0e-6);

    signal boost_model_interface : boost_model_interface_record;

    signal bus_from_stimulus : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_boost_model : fpga_interconnect_record := init_fpga_interconnect;
    signal voltage : real := 0.0;

begin

------------------------------------------------------------------------
    simtime : process
    begin
        test_runner_setup(runner, runner_cfg);
        wait for simtime_in_clocks*clock_period;
        test_runner_cleanup(runner); -- Simulation ends here
        wait;
    end process simtime;	

    simulator_clock <= not simulator_clock after clock_period/2.0;
------------------------------------------------------------------------

    stimulus : process(simulator_clock)

    begin
        if rising_edge(simulator_clock) then
            simulation_counter <= simulation_counter + 1;

            init_bus(bus_from_stimulus);

            create_boost_model_interface(boost_model_interface);


            case simulation_counter is
                WHEN 0 => request_boost_calculation(boost_model_interface);
                WHEN 80 => request_data_from_address(bus_from_stimulus, tubepsu_addresses_pkg.boost_voltage_address);
                WHEN others => --do nothing
            end case;
            if write_from_bus_is_requested(bus_from_boost_model) then
                voltage <= to_real(get_data(bus_from_boost_model),7);
            end if;

        end if; -- rising_edge
    end process stimulus;	
------------------------------------------------------------------------

    u_boost_model : entity work.boost_model
    generic map(boost_model_parameters => cl_parameters         ,
                initial_voltage        => -150.0                 ,
                load_current_address   => tubepsu_addresses_pkg.load_current_address  ,
                input_voltage_address  => tubepsu_addresses_pkg.input_voltage_address ,
                boost_current_address  => tubepsu_addresses_pkg.boost_current_address ,
                boost_voltage_address  => tubepsu_addresses_pkg.boost_voltage_address)
    port map(
        simulator_clock             ,
        bus_from_stimulus           ,
        bus_from_boost_model        ,
        boost_model_interface.input ,
        boost_model_interface.output
        /* boost_model_interface */
    );

end vunit_simulation;
