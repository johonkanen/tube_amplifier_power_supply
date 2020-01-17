library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.multiplier_pkg.all;

entity multiplier is
    port (
        multiplier_clocks : in multiplier_clock_group;

        multiplier_data_in : in multiplier_data_input_group;
        multiplier_data_out : out multiplier_data_output_group
    );
end entity;

architecture rtl of multiplier is


    signal mult_result : result_array(0 to 1);
    signal mult_a, mult_b : sign_array(0 to 1);

begin

    test_multiplier : process(multiplier_clocks.dsp_clock)

        variable multiplier_counter : integer range 0 to 7; 
    begin
        if rising_edge(multiplier_clocks.dsp_clock) then

            mult_a(0) <= to_signed(multiplier_data_in.mult_a,18);
            mult_b(0) <= to_signed(multiplier_data_in.mult_b,18);
            mult_a(1) <= mult_a(0);
            mult_b(1) <= mult_b(0);
            mult_result(0) <= mult_a(0) * mult_b(0);
            mult_result(1) <= mult_result(0);

            multiplier_data_out.multiplier_result <= mult_result(0);

            multiplier_data_out.multiplier_is_ready <= false;
            CASE multiplier_counter is
                WHEN 0 =>
                    if multiplier_data_in.multiplication_is_requested then
                        multiplier_counter := multiplier_counter + 1;
                    end if;
                WHEN 1 => 
                    multiplier_counter := multiplier_counter + 1;
                WHEN 2 => 
                    multiplier_data_out.multiplier_is_ready <= true;
                    multiplier_counter := 0;
                WHEN others =>
                    multiplier_counter := 0;
            end CASE;
        end if; --rising_edge
    end process test_multiplier;	

end rtl;
