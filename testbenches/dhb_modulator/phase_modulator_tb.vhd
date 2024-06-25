LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;

library vunit_lib;
context vunit_lib.vunit_context;

    use work.phase_modulator_pkg.all;

entity phase_modulator_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of phase_modulator_tb is

    constant clock_period      : time    := 1 ns;
    constant simtime_in_clocks : integer := 5000;
    
    signal simulator_clock     : std_logic := '0';
    signal modulator_clock     : std_logic := '0';
    signal simulation_counter  : natural   := 0;
    -----------------------------------
    -- simulation specific signals ----
    signal phase_modulator_data_in : phase_modulator_data_input_group;
    signal phase_modulator_data_out : phase_modulator_data_output_group;

    signal phase_modulator_fpga_out : phase_modulator_FPGA_output_group := (('0','0'),('0','0'));

    signal carrier : natural := 0;

    signal phase_modulator_clocks : phase_modulator_clock_group := ('0','0');

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
    modulator_clock <= not modulator_clock after clock_period/4.0;
------------------------------------------------------------------------
    carrier_gen : process(modulator_clock)
        
    begin
        if rising_edge(modulator_clock) then
            if carrier <= 948 then
                carrier <= carrier + 1;
            else
                carrier <= 0;
            end if;

        end if; --rising_edge
    end process carrier_gen;	

    stimulus : process(simulator_clock)

    begin
        if rising_edge(simulator_clock) then
            simulation_counter <= simulation_counter + 1;
            disable_dhb_modulator(phase_modulator_data_in);

            if simulation_counter > 100 then
                enable_dhb_modulator(phase_modulator_data_in);
            end if;

            CASE simulation_counter is
                WHEN 0 => set_phase(phase_modulator_data_in, 0);
                /* WHEN 1 => phase_modulator_data_in.reset_n <= '1'; */
                WHEN others => --do nothing
                
            end CASE; --


        end if; -- rising_edge
    end process stimulus;	
------------------------------------------------------------------------
    phase_modulator_clocks <= (core_clock => simulator_clock,  modulator_clock=> modulator_clock);

    u_phase_modulator : entity work.phase_modulator
    generic map(128e6/135e3)
    port map (
        phase_modulator_clocks,
        phase_modulator_FPGA_out ,
        phase_modulator_data_in  ,
        phase_modulator_data_out);
------------------------------------------------------------------------
end vunit_simulation;
