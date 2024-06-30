library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    
package test_interface_pkg is
    type comm_bus_record is record
        data_to_entity              : std_logic_vector(15 downto 0);
        write_data_to_entity_with_1 : std_logic;

        data_from_entity              : std_logic_vector(15 downto 0);
        write_data_from_entity_with_1 : std_logic;
    end record comm_bus_record;

    view comm_bus_internal of comm_bus_record is
        data_to_entity              : in;
        write_data_to_entity_with_1 : in;

        data_from_entity              : out;
        write_data_from_entity_with_1 : out;
    end view;
    alias comm_bus_external is comm_bus_internal'converse;

    procedure init_tx (
        signal p : view comm_bus_external);

    procedure init_rx (
        signal p : view comm_bus_internal);

    procedure write_data (
        signal p : view comm_bus_external;
        data : in std_logic_vector);

    procedure write_data (
        signal p : view comm_bus_external;
        data : in integer);

    procedure loopback_interface (
        signal p : view comm_bus_internal);

end package test_interface_pkg;


package body test_interface_pkg is
    procedure init_tx
    (
        signal p : view comm_bus_external
    ) is
    begin
        p.data_to_entity <= (others => '0');
        p.write_data_to_entity_with_1 <= '0';
    end init_tx;

    procedure init_rx
    (
        signal p : view comm_bus_internal
    ) is
    begin
        p.data_from_entity <= (others => '0');
        p.write_data_from_entity_with_1 <= '0';
    end init_rx;

    procedure write_data
    (
        signal p : view comm_bus_external;
        data : in std_logic_vector
    ) is
    begin
        p.data_to_entity <= data;
        p.write_data_to_entity_with_1 <= '1';
    end write_data;

    procedure write_data
    (
        signal p : view comm_bus_external;
        data : in integer
    ) is
    begin
        p.data_to_entity <= std_logic_vector(to_signed(data,p.data_from_entity'length));
        p.write_data_to_entity_with_1 <= '1';
    end write_data;

    procedure loopback_interface
    (
        signal p : view comm_bus_internal
    ) is
    begin
        if p.write_data_to_entity_with_1 = '1' then
            p.data_from_entity <= p.data_to_entity;
            p.write_data_from_entity_with_1 <= '1';
        end if;
        
    end loopback_interface;

end package body test_interface_pkg;
------------------------------------------------
LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;

    use work.test_interface_pkg.all;

library vunit_lib;
context vunit_lib.vunit_context;


entity vhdl2019_test_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of vhdl2019_test_tb is

    constant clock_period      : time    := 1 ns;
    constant simtime_in_clocks : integer := 50;
    
    signal simulator_clock     : std_logic := '0';
    signal simulation_counter  : natural   := 0;
    -----------------------------------
    -- simulation specific signals ----
    signal test_interface : comm_bus_record;

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
