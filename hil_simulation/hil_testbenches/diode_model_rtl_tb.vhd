LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;
    use std.textio.all;

library vunit_lib;
context vunit_lib.vunit_context;

    use work.write_pkg.all;

entity diode_model_rtl_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of diode_model_rtl_tb is

    constant clock_period      : time    := 1 ns;
    constant simtime_in_clocks : integer := 5000;
    
    signal simulator_clock     : std_logic := '0';
    signal simulation_counter  : natural   := 0;
    -----------------------------------
    -- simulation specific signals ----

    signal realtime : real := 0.0;
    constant stoptime : real := 10.0e-3;
    constant timestep : real := 0.10e-6;

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

        file file_handler : text open write_mode is "diode_model_rtl_tb.dat";

        variable input_voltage         : real := 0.0;
        variable c_gain                : real := 100.0e-6;
        variable L_gain                : real := 100.0e-6;
        variable current               : real := 0.0;
        variable voltage_over_inductor : real := 0.0;
        variable diode_voltage         : real := 0.0;
        variable load_resistance : real := 50.0;

        type lc_record is record
            capacitor_voltage : real;
            inductor_current  : real;
        end record;
        variable lc : lc_record := (0.0, 0.0);

        impure function calculate_diode_model
        (
            vin : real;
            inductance : real;
            capacitance : real;
            steplength : real
        )
        return lc_record
        is
            variable retval : lc_record;
            constant inductor_gain : real := steplength/inductance;
            constant capacitor_gain : real := steplength/capacitance;
            function sum_ab_when_c_positive
            (
                a,b,c : real
            )
            return  real
            is
                variable retval : real;
            begin
                retval := a + b;
                if c <= 0.0 then
                    retval := 0.0;
                end if;

                return retval;
            end sum_ab_when_c_positive;
        begin
            if vin > lc.capacitor_voltage then
                voltage_over_inductor := vin - lc.capacitor_voltage;
            end if;

            
            voltage_over_inductor := sum_ab_when_c_positive(vin, - lc.capacitor_voltage,lc.inductor_current);
            

            retval.inductor_current  := lc.inductor_current + (-lc.inductor_current*0.1 + voltage_over_inductor)*inductor_gain;
            retval.capacitor_voltage := lc.capacitor_voltage + (lc.inductor_current - lc.capacitor_voltage/load_resistance)*capacitor_gain;

            return retval;
            
        end calculate_diode_model;

    begin
        if rising_edge(simulator_clock) then
            simulation_counter <= simulation_counter + 1;
            if simulation_counter = 0 then
                init_simfile(file_handler, ("time", "volt", "curr", "ivol", "iref", "Lvol"));
            end if;
            realtime <= realtime + timestep;

            input_voltage := (sin(realtime * 2.0*math_pi * 1000.0))*10.0;
            voltage_over_inductor := 0.0;

            lc := calculate_diode_model(input_voltage, l_gain, c_gain, timestep);

            write_to(file_handler,(realtime, lc.capacitor_voltage, current, input_voltage, lc.inductor_current, voltage_over_inductor));
        end if; -- rising_edge
    end process stimulus;	
------------------------------------------------------------------------
end vunit_simulation;
