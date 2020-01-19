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
    constant simtime_in_clocks : integer := 200;

    signal multiplier_clocks   : multiplier_clock_group;
    signal multiplier_data_in  : multiplier_data_input_group;
    signal multiplier_data_out :  multiplier_data_output_group;
    signal mpy_test : sign36;
    signal testcounter : integer;
    signal signal_counter : int18;
    signal jihuu_y : int18;

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

        constant b1 : int18 := 3800;
        constant a1 : int18 := 18e3;
        constant b0 : int18 := 2**15-a1-b1;
        constant uin : int18 := 10e3;
        variable mem1, mem2, y : int18;
        variable a, b: int18;
        variable mpy_result : sign36;
        variable process_counter : int18;
        variable plaaplaa :int18;
        variable radix : int18;
        ------------------------------------------------------------------------
        impure function "*" (left, right : int18) return int18
        is
            variable result : sign36;
        begin
            alu_mpy(left, right, result, multiplier_data_in, multiplier_data_out);
            return get_result(multiplier_data_out,radix);
        end "*";
        ------------------------------------------------------------------------
    begin
        if rstn = '0' then
        -- reset state
            a := 16;
            b := 16;
            mpy_test <= (others => '0');
            process_counter := 0;
            mem1 := 0;
            y := 0;
            signal_counter <= process_counter;
            process_counter := 0;
            jihuu_y <= 0;
            radix := 0;

        elsif rising_edge(simulator_clock) then
            signal_counter <= process_counter;
            testcounter <= process_counter;
            mpy_test <=multiplier_data_out.multiplier_result; 

            multiplier_data_in.multiplication_is_requested <= false;

            radix := -1;
            case process_counter is
                WHEN 0 => 
                    y := uin * b0 + mem1;
                    if multiplier_is_ready(multiplier_data_out) then
                        increment(process_counter);
                        jihuu_y <= y;
                    end if;
                WHEN 1 => 
                    mem1 := b1 * uin;
                    increment(process_counter);
                WHEN 2 => 
                    mem1 := a1 * y;
                    if multiplier_is_ready(multiplier_data_out) then
                        mem1 := get_result(multiplier_data_out,radix);
                        increment(process_counter);
                    end if;
                when 3 =>
                    mem1 := mem1 + get_result(multiplier_data_out,radix);
                    process_counter := 0;
                when others =>
            end CASE;

        end if; -- rstn
    end process test_multiplier;	

end sim;
