LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;

    use work.main_state_machine_pkg.all;
    use work.component_interconnect_pkg.all;
    use work.timing_pkg.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity main_state_machine_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of main_state_machine_tb is

    constant clock_period      : time    := 1 ns;
    constant simtime_in_clocks : integer := 50;
    
    signal simulator_clock     : std_logic := '0';
    signal simulation_counter  : natural   := 0;
    -----------------------------------
    -- simulation specific signals ----
    signal main_state_machine : main_state_machine_record := init_main_state_machine;
    signal delay_timer_1ms_data_in  : delay_timer_data_input_group;
    signal delay_timer_1ms_data_out : delay_timer_data_output_group;

    signal onehot_states : std_logic_vector(main_state_machine.st_main_states'length-1 downto 0) := (others => '0');
    signal component_interconnect_data_in : component_interconnect_data_input_group;

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
------------------------------------------------------------------------

    u_delay_timer : delay_timer
    generic map (count_up_to => 128)
    port map(simulator_clock,
    	  delay_timer_1ms_data_in,
    	  delay_timer_1ms_data_out);
------------------------------------------------------------------------

    stimulus : process(simulator_clock)

    begin
        if rising_edge(simulator_clock) then
            simulation_counter <= simulation_counter + 1;

            create_system_control(
                main_state_machine             ,
                '1'                            ,
                component_interconnect_data_in ,
                delay_timer_1ms_data_in        ,
                delay_timer_1ms_data_out       ,
                500);


        end if; -- rising_edge
    end process stimulus;	
------------------------------------------------------------------------
end vunit_simulation;
