--------------------------------------------------
package test_generic_pkg is
    generic(type              g_countertype ;
            g_initval :       g_countertype ;
            function "+" (l : g_countertype ; r : integer) return g_countertype );

    subtype countertype is g_countertype;
    constant init_counter : g_countertype := g_initval;

end package test_generic_pkg;

--------------------------------------------------
LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 

entity gentest is
    generic(package test_pkg is new work.test_generic_pkg generic map(<>));
    port (
        clk : in std_logic
    );
end entity gentest;

architecture test of gentest is

    use test_pkg.all;
    signal counter : countertype := init_counter;

begin
    process(clk)
    begin
        if rising_edge(clk) then
            counter <= counter + 1;
        end if;
    end process;

end test;
--------------------------------------------------
LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 

entity gen_package_tb is
end;

architecture vunit_simulation of gen_package_tb is

    subtype sig is signed(15 downto 0);
    package test_pkg is new work.test_generic_pkg generic map(g_countertype => sig, g_initval => to_signed(-6, 16), "+" => "+");
    use test_pkg.all;

    constant clock_period      : time    := 1 ns;
    constant simtime_in_clocks : integer := 50;
    
    signal simulator_clock     : std_logic := '0';
    signal simulation_counter  : natural   := 0;
    -----------------------------------
    -- simulation specific signals ----
    signal counter : countertype := init_counter;

begin

------------------------------------------------------------------------
    simtime : process
    begin
        wait for simtime_in_clocks*clock_period;
        assert false report "Simulation Finished" severity failure;
    end process simtime;	

    simulator_clock <= not simulator_clock after clock_period/2.0;
------------------------------------------------------------------------

    stimulus : process(simulator_clock)

    begin
        if rising_edge(simulator_clock) then
            simulation_counter <= simulation_counter + 1;
            counter <= counter + 1;
            assert counter = init_counter + simulation_counter report "generic package did not work correctly" severity failure;

        end if; -- rising_edge
    end process stimulus;	
------------------------------------------------------------------------
u_gentest : entity work.gentest
generic map(test_pkg)
port map(simulator_clock);

end vunit_simulation;
