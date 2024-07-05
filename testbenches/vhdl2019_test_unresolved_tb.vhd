library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    
package test_interface_pkg is
    type comm_bus_record is record
        data_to_entity              : std_ulogic_vector(15 downto 0);
        write_data_to_entity_with_1 : std_ulogic;

        data_from_entity              : std_ulogic_vector(15 downto 0);
        write_data_from_entity_with_1 : std_ulogic;
    end record comm_bus_record;

    view comm_bus_cview of comm_bus_record is
        data_to_entity              : in;
        write_data_to_entity_with_1 : in;

        data_from_entity              : out;
        write_data_from_entity_with_1 : out;
    end view;
    alias comm_bus_view is comm_bus_cview'converse;

    procedure init_tx (
        signal self : view comm_bus_view);

    procedure write_data (
        signal self : view comm_bus_view;
        data : in std_ulogic_vector);

    procedure write_data (
        signal self : view comm_bus_view;
        data : in integer);

    procedure init_rx (
        signal self : view comm_bus_cview);

    procedure loopback_interface (
        signal self : view comm_bus_cview);

    function bus_feedback_is_ready ( self : comm_bus_record)
        return boolean;


end package test_interface_pkg;


package body test_interface_pkg is
    procedure init_tx
    (
        signal self : view comm_bus_view
    ) is
    begin
        self.data_to_entity <= (others => '0');
        self.write_data_to_entity_with_1 <= '0';
    end init_tx;

    procedure init_rx
    (
        signal self : view comm_bus_cview
    ) is
    begin
        self.data_from_entity <= (others => '0');
        self.write_data_from_entity_with_1 <= '0';
    end init_rx;

    procedure write_data
    (
        signal self : view comm_bus_view;
        data : in std_ulogic_vector
    ) is
    begin
        self.data_to_entity <= data;
        self.write_data_to_entity_with_1 <= '1';
    end write_data;

    procedure write_data
    (
        signal self : view comm_bus_view;
        data : in integer
    ) is
    begin
        self.data_to_entity <= std_ulogic_vector(to_signed(data,self.data_from_entity'length));
        self.write_data_to_entity_with_1 <= '1';
    end write_data;

    procedure loopback_interface
    (
        signal self : view comm_bus_cview
    ) is
    begin
        if self.write_data_to_entity_with_1 = '1' then
            self.data_from_entity <= self.data_to_entity;
            self.write_data_from_entity_with_1 <= '1';
        end if;
        
    end loopback_interface;

    function bus_feedback_is_ready
    (
        self : comm_bus_record
    )
    return boolean
    is
    begin
        return self.write_data_from_entity_with_1 = '1';
    end bus_feedback_is_ready;

end package body test_interface_pkg;
------------------------------------------------
LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;

    use work.test_interface_pkg.all;

library vunit_lib;
context vunit_lib.vunit_context;


entity vhdl2019_test_unresolved_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of vhdl2019_test_unresolved_tb is

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
    begin
        if rising_edge(simulator_clock) then
            simulation_counter <= simulation_counter + 1;
            init_tx(test_interface);
            CASE simulation_counter is
                WHEN 10 =>
                    write_data(test_interface, 10);
                WHEN 11 =>
                    write_data(test_interface, 11);
                WHEN 12 =>
                    write_data(test_interface, 12);
                WHEN others =>
            end CASE; --simulation_counter
            if bus_feedback_is_ready(test_interface) then
                result_counter <= result_counter + 1;
            end if;

            if bus_feedback_is_ready(test_interface) then
                tests_were_actually_run <= true;
                CASE result_counter is
                    WHEN 0 => check(to_integer(test_interface.data_from_entity) = 10, "first test, resolution probably failed");
                    WHEN 1 => check(to_integer(test_interface.data_from_entity) = 11, "second test, resolution probably failed");
                    WHEN 2 => check(to_integer(test_interface.data_from_entity) = 12, "third test, resolution probably failed");
                    when others => --do nothing
                end CASE;
            end if;

        end if; -- rising_edge
    end process stimulus;	

    testi : process(simulator_clock)
    begin
        if rising_edge(simulator_clock) then
            init_rx(test_interface);
            loopback_interface(test_interface);
        end if; --rising_edge
    end process ;	
------------------------------------------------------------------------
end vunit_simulation;
