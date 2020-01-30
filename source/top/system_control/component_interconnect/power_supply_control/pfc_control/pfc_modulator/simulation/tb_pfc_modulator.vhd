LIBRARY ieee  ; 
LIBRARY std  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    USE ieee.std_logic_textio.all  ; 
    use ieee.math_real.all;
    USE std.textio.all  ; 

library work;
    use work.pfc_modulator_pkg.all;

entity tb_pfc_modulator is
end;

architecture sim of tb_pfc_modulator is
    signal rstn : std_logic;

    signal simulation_running : boolean;
    signal simulator_clock : std_logic;
    constant clock_per : time := 4 ns;
    constant clock_half_per : time := 2 ns;
    constant simtime_in_clocks : integer := 15e3;


    signal pfc_modulator_clocks   : pfc_modulator_clock_group;
    signal pfc_modulator_FPGA_out : pfc_modulator_FPGA_output_group;
    signal pfc_modulator_data_in  : pfc_modulator_data_input_group;
    signal pfc_modulator_data_out : pfc_modulator_data_output_group;

    signal master_carrier : integer;
    signal gate1 : std_logic;
    signal gate2 : std_logic;

begin

    simtime : process
    begin
        simulation_running <= true;
        wait for simtime_in_clocks*clock_per;
        simulation_running <= false;
        wait;
    end process simtime;	


    sim_clock_gen : process
    begin
        simulator_clock <= '0';
        rstn <= '0';
        simulator_clock <= '0';
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
    
        elsif rising_edge(simulator_clock) then
            master_carrier <= master_carrier + 1;
            if master_carrier > 1896 then
                master_carrier <= 0;
            end if;
        end if; -- rstn
    end process create_carrier;	
------------------------------------------------------------------------
    test_pwm : process
    begin
        pfc_modulator_data_in.duty <= 10;
        wait for 15 us;
        pfc_modulator_data_in.duty <= 850;
        wait for 18 us;
        pfc_modulator_data_in.duty <= 10;
        wait;
    end process test_pwm;	
------------------------------------------------------------------------
    pfc_modulator_clocks <= (modulator_clock => simulator_clock, core_clock => simulator_clock);

    pfc_modulator_data_in.pfc_carrier <= master_carrier;

    gate1 <= pfc_modulator_FPGA_out.ac1_switch;
    gate2 <= pfc_modulator_FPGA_out.ac2_switch;

    u_pfc_modulator : pfc_modulator
    generic map(1896)
    port map
    (
        pfc_modulator_clocks,
        pfc_modulator_FPGA_out,
        pfc_modulator_data_in, 
        pfc_modulator_data_out
    );

        

end sim;
