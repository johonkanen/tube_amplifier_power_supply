LIBRARY ieee  ; 
LIBRARY std  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    USE ieee.std_logic_textio.all  ; 
    use ieee.math_real.all;
    USE std.textio.all  ; 

library work;
    use work.multiplier_pkg.all;
    use work.sincos_pkg.all;

entity tb_sincos is
end;

architecture sim of tb_sincos is
    signal rstn : std_logic;

    signal simulation_running : boolean;
    signal simulator_clock : std_logic;
    constant clock_per : time := 1 ns;
    constant clock_half_per : time := 0.5 ns;
    constant simtime_in_clocks : integer := 20e3;
    signal clocked_reset :std_logic;

    signal multiplier_clocks   : multiplier_clock_group;
    signal multiplier_data_in  : multiplier_data_input_group;
    signal multiplier_data_out : multiplier_data_output_group;

    signal sincos_clocks   : sincos_clock_group;
    signal sincos_data_in  : sincos_data_input_group;
    signal sincos_data_out : sincos_data_output_group;
    signal sincos_is_requested : boolean;
--------------- simulation signals -------------------------------------
    signal mpy_test : sign36;
    signal testcounter : integer;
    signal signal_counter : int18;
    signal jihuu_y : int18;

    signal sine : int18;
    signal cosine : int18;

    type int18_array is array (integer range <>) of int18;
    constant sinegains : int18_array(0 to 2) := (12868,21159,10180);
    constant cosgains : int18_array(0 to 2) := (32768,80805,64473);

    signal angle : int18;
    signal test_angle : int18;

    function reduce_angle
    (
        int16_angle : int18
    )
    return int18
    is
        variable sign16_angle : signed(17 downto 0);
    begin
        sign16_angle := to_signed(int16_angle,18); 
        return to_integer((sign16_angle(13 downto 0)));
    end reduce_angle;

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

    gen_clocked_reset : process(simulator_clock, rstn)
        variable reset_counter : integer;
    begin
        if rstn = '0' then
            reset_counter := 0;

            clocked_reset <= '0';
        elsif rising_edge(simulator_clock) then
            reset_counter := reset_counter + 1;
            if reset_counter = 2 then
                clocked_reset <= '1';
            end if;
        end if;
    end process;


------------------------------------------------------------------------
    calculate_sincos : process(simulator_clock, rstn)

    begin
        if rstn = '0' then
        -- reset state
            angle <= 0;
            sincos_is_requested <= false;

        elsif rising_edge(simulator_clock) then

            sincos_is_requested <= true;
            if sincos_data_out.sincos_is_ready then
                angle <= angle + 128;
                if angle > 2**16-1 then
                    angle <= 0;
                end if;
            end if;

            end if; -- rstn
    end process calculate_sincos;	
------------------------------------------------------------------------
    multiplier_clocks.dsp_clock <= simulator_clock;
    u_multiplier : multiplier
        port map(
            multiplier_clocks, 
            multiplier_data_in,
            multiplier_data_out 
        );
------------------------------------------------------------------------
    sincos_clocks <= (alu_clock => simulator_clock, reset_n => clocked_reset);
    multiplier_data_in <= sincos_data_out.multiplier_data_in;
    sine <= sincos_data_out.sine;
    cosine <= sincos_data_out.cosine;

    sincos_data_in <= (angle_pirad => angle, 
                      sincos_is_requested => sincos_is_requested, 
                      multiplier_data_out => multiplier_data_out);

    u_sincos : entity work.sincos
    port map
    (
        sincos_clocks,   
        sincos_data_in, 
        sincos_data_out 
    );
end sim;
