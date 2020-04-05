LIBRARY ieee  ; 
LIBRARY std  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    USE ieee.std_logic_textio.all  ; 
    use ieee.math_real.all;
    USE std.textio.all  ; 

library work;
    use work.phase_modulator_pkg.all;

entity tb_phase_modulator is
end;

architecture sim of tb_phase_modulator is
    signal rstn : std_logic;

    signal simulation_running : boolean;
    signal simulator_clock : std_logic;
    constant clock_per : time := 4 ns;
    constant clock_half_per : time := 2 ns;
    constant simtime_in_clocks : integer := 15e3;

    signal master_carrier : integer;

    signal phase_modulator_clocks   : phase_modulator_clock_group;
    signal phase_modulator_FPGA_out : phase_modulator_FPGA_output_group;
    signal phase_modulator_data_in  : phase_modulator_data_input_group;
    signal phase_modulator_data_out : phase_modulator_data_output_group;
    constant g_carrier_max_value : integer := 1896;

    signal primary : std_logic_vector(1 downto 0);
    signal secondary : std_logic_vector(1 downto 0);

begin
------------------------------------------------------------------------
    simtime : process
    begin
        simulation_running <= true;
        wait for simtime_in_clocks*clock_per;
        simulation_running <= false;
        wait;
    end process simtime;	
------------------------------------------------------------------------
    sim_clock_gen : process
    begin
        simulator_clock <= '0';
        rstn <= '0';
        wait for clock_half_per;
        while simulation_running loop
            wait for clock_half_per;
                rstn <= '1';
                simulator_clock <= not simulator_clock;
            end loop;
        wait;
    end process;
------------------------------------------------------------------------
    create_carrier : process(simulator_clock, rstn)
    begin
        if rstn = '0' then
        -- reset state
            master_carrier <= 0;
            -- phase_modulator_data_in.carrier <= 0;
            phase_modulator_data_in.tg_load_phase <= '0';
    
        elsif rising_edge(simulator_clock) then
            -- phase_modulator_data_in.tg_load_phase <= not phase_modulator_data_in.tg_load_phase;

            phase_modulator_data_in.tg_load_phase <= '1';
            if phase_modulator_data_in.tg_load_phase = '1' then
                phase_modulator_data_in.tg_load_phase <= '0';
            end if;

            if master_carrier = 1895 then
                master_carrier <= 0;
            else
                master_carrier <= master_carrier + 1;
            end if;
        end if; -- rstn
    end process create_carrier;	
    phase_modulator_data_in.carrier <= master_carrier;
------------------------------------------------------------------------
    change_phase : process
        
    begin
        phase_modulator_data_in.phase <= 0;
        -- trigger(phase_modulator_data_in.tg_load_phase);
        wait for 15 us;
        phase_modulator_data_in.phase <= -250;
        -- trigger(phase_modulator_data_in.tg_load_phase);
        wait for 15 us;
        phase_modulator_data_in.phase <= 250;
        -- trigger(phase_modulator_data_in.tg_load_phase);
        wait for 15 us;
        phase_modulator_data_in.phase <= -250;
        -- trigger(phase_modulator_data_in.tg_load_phase);
    
        wait;
    end process change_phase;	
    phase_modulator_clocks <= (modulator_clock => simulator_clock, core_clock => simulator_clock);

    primary <= (phase_modulator_FPGA_out.primary.high_gate, phase_modulator_FPGA_out.primary.low_gate);
    secondary <= (phase_modulator_FPGA_out.secondary.high_gate, phase_modulator_FPGA_out.secondary.low_gate);
    -- phase_modulator_data_in.dhb_is_enabled <= true;
    u_phase_modulator : phase_modulator
    generic map(g_carrier_max_value)
    port map
    (
        phase_modulator_clocks,
        phase_modulator_FPGA_out,
        phase_modulator_data_in, 
        phase_modulator_data_out
    );

end sim;
