LIBRARY ieee  ; 
LIBRARY std  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    USE ieee.std_logic_textio.all  ; 
    use ieee.math_real.all;
    USE std.textio.all  ; 

library work;
    use work.multiplier_pkg.all;

entity tb_multiplier is
end;

architecture sim of tb_multiplier is
    signal rstn : std_logic;

    signal simulation_running : boolean;
    signal simulator_clock : std_logic;
    constant clock_per : time := 1 ns;
    constant clock_half_per : time := 0.5 ns;
    constant simtime_in_clocks : integer := 50;

    signal multiplier_clocks   : multiplier_clock_group;
    signal multiplier_data_in  : multiplier_data_input_group;
    signal multiplier_data_out :  multiplier_data_output_group;
    signal mpy_test : sign36;
    signal testcounter : integer;

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

    multiplier_clocks.dsp_clock <= simulator_clock;
    u_multiplier : multiplier
        port map(
            multiplier_clocks, 
            multiplier_data_in,
            multiplier_data_out 
        );

    test_multiplier : process(simulator_clock, rstn)

        variable a, b: int18;
        variable mpy_result : sign36;
        variable process_counter : integer;
        ------------------------------------------------------------------------
        impure function "*" (left, right : int18) return sign36
        is
            variable result : sign36;
        begin
            alu_mpy(left, right, result, multiplier_data_in, multiplier_data_out, process_counter);
            return result;
        end "*";
        ------------------------------------------------------------------------
    begin
        if rstn = '0' then
        -- reset state
            a := 16;
            b := 16;
            mpy_test <= (others => '0');
            process_counter := 0;

        elsif rising_edge(simulator_clock) then
            mpy_result := a * b;
            mpy_test <=multiplier_data_out.multiplier_result; 
            testcounter <= process_counter;

        end if; -- rstn
    end process test_multiplier;	

end sim;
