LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;
    use std.textio.all;

library vunit_lib;
context vunit_lib.vunit_context;

    use work.write_pkg.all;

entity diode_model_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of diode_model_tb is

    constant clock_period      : time    := 1 ns;
    
    signal simulator_clock     : std_logic := '0';
    signal simulation_counter  : natural   := 0;
    -----------------------------------
    -- simulation specific signals ----

    signal realtime : real := 0.0;
    constant stoptime : real := 10.0e-3;
    constant timestep : real := 1.0e-6;

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

        file file_handler : text open write_mode is "diode_model_tb.dat";

        variable input_voltage         : real := 0.0;
        variable capacitor_voltage     : real := 0.0;
        variable c_gain                : real := timestep/100.0e-6;
        variable L_gain                : real := timestep/100.0e-6;
        variable current               : real := 0.0;
        variable voltage_over_inductor : real := 0.0;
        variable inductor_current      : real := 0.0;
        variable diode_voltage         : real := 0.0;

    begin
        if rising_edge(simulator_clock) then
            simulation_counter <= simulation_counter + 1;
            if simulation_counter = 0 then
                init_simfile(file_handler, ("time", "volt", "curr", "ivol", "iref", "Lvol"));
            end if;
            realtime <= realtime + timestep;

            input_voltage := (sin(realtime * 2.0*math_pi * 1000.0))*10.0;
            voltage_over_inductor := 0.0;

            if input_voltage > capacitor_voltage + diode_voltage then
                current := (input_voltage - capacitor_voltage)*10.0;
                voltage_over_inductor := input_voltage - capacitor_voltage - diode_voltage;
            else
                current := 0.0;
            end if;

            if inductor_current > 0.0 then
                voltage_over_inductor := input_voltage - capacitor_voltage - diode_voltage;
            end if;

            inductor_current  := inductor_current + (-inductor_current*0.1 + voltage_over_inductor)*L_gain;
            if inductor_current < 0.0 then
                inductor_current := 0.0;
            end if;
            capacitor_voltage := capacitor_voltage + (inductor_current - capacitor_voltage/50.0)*c_gain;

            write_to(file_handler,(realtime, capacitor_voltage, current, input_voltage, inductor_current, voltage_over_inductor));
        end if; -- rising_edge
    end process stimulus;	
------------------------------------------------------------------------
end vunit_simulation;
