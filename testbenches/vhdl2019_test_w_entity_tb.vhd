LIBRARY ieee  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.numeric_std.all;

    use work.test_interface_pkg.all;

entity test_entity is
    port (
        clk : in std_logic;
        test_interface : view comm_bus_cview
    );
end entity test_entity;

architecture rtl of test_entity is

begin
    testi : process(clk)
    begin
        if rising_edge(clk) then
            init_rx(test_interface);
            loopback_interface(test_interface);
        end if; --rising_edge
    end process ;	

end rtl;

------------------------------------------------
------------------------------------------------
LIBRARY ieee  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.numeric_std.all;

    use work.test_interface_pkg.all;

library vunit_lib;
context vunit_lib.vunit_context;


entity vhdl2019_test_w_entity_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of vhdl2019_test_w_entity_tb is

    constant clock_period      : time    := 1 ns;
    constant simtime_in_clocks : integer := 50;
    
    signal simulator_clock     : std_ulogic := '0';
    signal simulation_counter  : natural   := 0;
    -----------------------------------
    -- simulation specific signals ----
    signal test_interface : comm_bus_record;

    signal result_counter : natural := 0;
    signal tests_were_actually_run : boolean := false;

begin

------------------------------------------------------------------------
    simtime : process
    begin
        test_runner_setup(runner, runner_cfg);
        wait for simtime_in_clocks*clock_period;
        check(tests_were_actually_run, "tests were not run");
        test_runner_cleanup(runner); -- Simulation ends here
        wait;
    end process simtime;	

    simulator_clock <= not simulator_clock after clock_period/2.0;
------------------------------------------------------------------------

    stimulus : process(simulator_clock)
        function to_integer
        (
            input : std_ulogic_vector
        )
        return integer
        is
        begin
            return to_integer(unsigned(input));
        end to_integer;

        procedure test
        (
            signal self : view comm_bus_view
        ) is
        begin
            simulation_counter <= simulation_counter + 1;
            init_tx(self);
            CASE simulation_counter is
                WHEN 10 =>
                    write_data(self, 10);
                WHEN 11 =>
                    write_data(self, 11);
                WHEN 12 =>
                    write_data(self, 12);
                WHEN others =>
            end CASE; --simulation_counter
            if bus_feedback_is_ready(self) then
                tests_were_actually_run <= true;
                result_counter <= result_counter + 1;
            end if;

            if bus_feedback_is_ready(self) then
                tests_were_actually_run <= true;
                CASE result_counter is
                    WHEN 0 => check(to_integer(self.data_from_entity) = 10, "first test, resolution probably failed");
                    WHEN 1 => check(to_integer(self.data_from_entity) = 11, "second test, resolution probably failed");
                    WHEN 2 => check(to_integer(self.data_from_entity) = 12, "third test, resolution probably failed");
                    when others => --do nothing
                end CASE;
            end if;
            
        end test;
    begin
        if rising_edge(simulator_clock) then
            test(test_interface);
        end if; -- rising_edge
    end process stimulus;	

    u_test_entity : entity work.test_entity
    port map(clk => simulator_clock, test_interface => test_interface);

------------------------------------------------------------------------
end vunit_simulation;
