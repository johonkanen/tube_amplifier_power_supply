library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.feedback_control_pkg.all;
    use work.multiplier_pkg.all;

-- entity feedback_control is
--     generic(number_of_measurements : natural);
--     port (
--         feedback_control_clocks : in feedback_control_clock_group; 
--         feedback_control_data_in : in feedback_measurements(0 to number_of_measurements -1 );
--         feedback_control_data_out : out feedback_control_data_output_group;
--         data_from_multiplier : in multiplier_data_output_group;
--         data_to_multiplier :  out multiplier_data_input_group
--     );
-- end entity;

architecture llc_pi_control of feedback_control is
    alias feedback_measurement is feedback_control_data_in(0).measurement;
    alias feedback_reference is feedback_control_data_in(0).control_reference;
    alias control_is_requested is feedback_control_data_in(0).control_is_requested;
    alias multiplier_data_in is data_to_multiplier;
    alias multiplier_data_out is data_from_multiplier;

    signal mem : int18;
    signal ekp : int18;
    signal pi_out : int18;

    constant pi_saturate_high : int18 :=  2**15;
    constant pi_saturate_low : int18 := -2**15;

    constant kp : int18 := 22e3;
    constant ki : int18 := 2000;
begin

    feedback_control_data_out.control_out <= pi_out;

    pi_control_calculation : process(feedback_control_clocks.clock)
        variable process_counter : natural range 0 to 4;
        variable control_error : int18;

        
    begin

        feedback_control_data_out.control_is_done <= false;
        if rising_edge(feedback_control_clocks.clock) then
            CASE process_counter is
                WHEN 0 =>
                    -- do nothing
                    control_error :=  feedback_reference - feedback_measurement;

                    if control_is_requested then
                        increment(process_counter);
                        alu_mpy(control_error, kp, multiplier_data_in);
                    end if;

                WHEN 1 => 
                    increment(process_counter);
                    alu_mpy(control_error, ki, multiplier_data_in);

                WHEN 2 => 
                    increment(process_counter);

                WHEN 3 => 
                    increment(process_counter);
                    pi_out <= mem + get_result(multiplier_data_out,15);
                    ekp <= get_result(multiplier_data_out,15);

                WHEN 4 =>
                    process_counter := 0;
                    feedback_control_data_out.control_is_done <= false;

                    mem <= mem + get_result(multiplier_data_out,15);
                    if pi_out >  pi_saturate_high then
                        pi_out <= pi_saturate_high ;
                        mem    <= pi_saturate_high -ekp;
                    end if;

                    if pi_out <  pi_saturate_low then
                        pi_out <= pi_saturate_low ;
                        mem    <= pi_saturate_low -ekp;
                    end if; 

                WHEN others =>
                    process_counter := 0;
            end CASE;
        end if; --rising_edge
    end process;	

end llc_pi_control;

