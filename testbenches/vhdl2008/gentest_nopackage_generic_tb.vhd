
LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 


entity gentest is
    /* generic(package test_pkg is new work.test_generic_pkg generic map(<>)); */
    port (
        clk : in std_logic
    );
end entity gentest;

architecture test of gentest is

    package test_pkg is new work.test_generic_pkg generic map(g_countertype => integer, g_initval => to_integer(to_signed(-6, 16)), "+" => "+");
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

LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity gen_package_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of gen_package_tb is

    package test_pkg is new work.test_generic_pkg generic map(g_countertype => signed(15 downto 0), g_initval => to_signed(-6, 16), "+" => "+");
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
            if simulation_counter = 0 then
                check(counter = to_signed(-6,16));
            end if;
            counter <= counter + 1;

        end if; -- rising_edge
    end process stimulus;	
------------------------------------------------------------------------
u_gentest : entity work.gentest
/* generic map(test_pkg) */
port map(simulator_clock);

end vunit_simulation;
