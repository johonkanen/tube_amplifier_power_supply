library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.multiplier_pkg.all;

entity sincos is
    port (
        alu_clock : in std_logic;
        reset_n : in std_logic	
    );
end entity sincos;


architecture rtl of sincos is

    signal multiplier_clocks   : multiplier_clock_group;
    signal multiplier_data_in  : multiplier_data_input_group;
    signal multiplier_data_out : multiplier_data_output_group;
--------------- simulation signals -------------------------------------

    signal sine : int18;
    signal cosine : int18;

    signal angle : int18;
    signal test_angle : int18;

--------------- module signals -------------------------------------

    type int18_array is array (integer range <>) of int18;
    constant sinegains : int18_array(0 to 2) := (12868,21159,10180);
    constant cosgains : int18_array(0 to 2) := (32768,80805,64473);

    function reduce_angle ( int16_angle : int18)
        return int18
    is
        variable sign16_angle : signed(17 downto 0);
    begin
        sign16_angle := to_signed(int16_angle,18); 
        return to_integer((sign16_angle(13 downto 0)));
    end reduce_angle;


begin

    multiplier_clocks.dsp_clock <= alu_clock;
    u_multiplier : multiplier
        port map(
            multiplier_clocks, 
            multiplier_data_in,
            multiplier_data_out 
        );

    calculate_sincos : process(alu_clock, reset_n)

        variable process_counter : int18;
        variable radix : int18;


        variable z : int18;
        variable prod : int18;
        variable sin16 : int18;
        variable cos16 : int18;

        ------------------------------------------------------------------------
        impure function "*" (left, right : int18) return int18
        is
            variable result : sign36;
        begin
            alu_mpy(left, right, multiplier_data_in, multiplier_data_out);
            return get_result(multiplier_data_out,radix);
        end "*";
        ------------------------------------------------------------------------
    begin
        if reset_n = '0' then
        -- reset state
            process_counter := 0;
            radix := 0;
            angle <= 0;
            sin16 := 0;
            test_angle <= 0;
            cos16 := 0;
            sine <= 0;
            cosine <= 0;

        elsif rising_edge(alu_clock) then

            case process_counter is
               WHEN 0 => 
                    radix := 18;
                    z := test_angle*test_angle;
                    if multiplier_is_ready(multiplier_data_out) then
                        increment(process_counter);
                    end if;
                WHEN 1 => 
                    radix := 12;
                    prod := z * sinegains(2);
                    if multiplier_is_ready(multiplier_data_out) then
                        increment(process_counter);
                    end if;
                WHEN 2 => 
                    radix := 12;
                    prod := z*(sinegains(1) - prod);
                    if multiplier_is_ready(multiplier_data_out) then
                        increment(process_counter);
                    end if;
                when 3 =>
                    radix := 12;
                    sin16 := test_angle * (sinegains(0) - prod);
                    if multiplier_is_ready(multiplier_data_out) then
                        increment(process_counter);
                    end if;
                when 4 =>
                    radix := 12;
                    prod := z*cosgains(2);
                    if multiplier_is_ready(multiplier_data_out) then
                        increment(process_counter);
                    end if;
                when 5 =>
                    radix := 11;
                    prod := z*(cosgains(1) - prod);
                    if multiplier_is_ready(multiplier_data_out) then
                        increment(process_counter);
                    end if;
                when 6 =>
                    increment(process_counter);
                    cos16 := cosgains(0) - prod;
                    if angle < 8192 then
                        sine   <= sin16;
                        cosine <= cos16;
                    elsif angle < 24576 then
                        sine   <= cos16;
                        cosine <= -sin16;
                    elsif angle < 40960 then
                        sine   <= -sin16;
                        cosine <= -cos16;
                    elsif angle < 57344 then
                        sine   <= -cos16;
                        cosine <= sin16;
                    else
                        sine   <= sin16;
                        cosine <= cos16;
                    end if;
                WHEN 7 =>
                    increment(process_counter);
                    angle <= angle + 128;
                when 8 =>
                    test_angle <= reduce_angle(angle);
                    if angle > 2**16-1 then
                        test_angle <= reduce_angle(0);
                        angle <= 0;
                    end if;
                    process_counter := 0;

                when others =>
                    process_counter := 0;
            end CASE;

        end if; -- reset_n
    end process calculate_sincos;	



end rtl;
