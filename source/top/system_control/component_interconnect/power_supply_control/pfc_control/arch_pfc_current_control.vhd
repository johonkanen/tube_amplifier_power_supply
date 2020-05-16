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

architecture pfc_current_control of feedback_control is
    alias dc_link is feedback_control_data_in(0).measurement;
    alias vac is feedback_control_data_in(1).measurement;
    alias pfc_I1 is feedback_control_data_in(2).measurement;
    alias pfc_I2 is feedback_control_data_in(3).measurement;

    alias feedback_reference is feedback_control_data_in(0).control_reference;
    alias control_is_requested is feedback_control_data_in(0).control_is_requested;
    alias multiplier_data_in is data_to_multiplier;
    alias multiplier_data_out is data_from_multiplier;

    signal mem : int18;
    signal ekp : int18;
    signal pi_out : int18;

    constant pi_saturate_high : int18 := 846;
    constant pi_saturate_low : int18  := 474;

    constant kp : int18 := 22e2;
    constant ki : int18 := 200;

begin

    feedback_control_data_out.control_out <= pi_out;

    pi_control_calculation : process(feedback_control_clocks.clock)
        variable process_counter : natural range 0 to 5;
        variable control_error : int18;

        
    begin
        if rising_edge(feedback_control_clocks.clock) then

            enable_multiplier(multiplier_data_in);
            feedback_control_data_out.feedback_is_ready <= false;

            if feedback_control_data_in(0).feedback_control_is_enabled = false then
                mem <= 0;
            end if;
                CASE process_counter is 
                    WHEN 0 =>
                        if control_is_requested then
                            if pfc_I1 > pfc_I2 then
                                control_error := 17000 - pfc_I1;
                            else
                                control_error := 17000 - pfc_I2;
                            end if;
                            increment(process_counter);
                        end if;

                    WHEN 1 => 
                        alu_mpy(kp,control_error,multiplier_data_in);
                        increment(process_counter);

                    WHEN 2 => 
                        increment(process_counter);
                        alu_mpy(ki,control_error,multiplier_data_in);

                    WHEN 3 => 
                        -- pipeline mem calculation
                        increment(process_counter);

                    WHEN 4 => 
                        pi_out <= get_result(multiplier_data_out,15) + mem;
                        ekp <= get_result(multiplier_data_out,15);
                        increment(process_counter);

                    WHEN 5 => 
                        if pi_out > 32768 then
                            pi_out <= 32768;
                            mem <= 32768-get_result(multiplier_data_out,15);
                            increment(process_counter);
                        end if;

                        if pi_out < 6560 then
                            pi_out <= 6560;
                            mem <= 6560-get_result(multiplier_data_out,15);
                            increment(process_counter);
                        end if;
                        
                        if multiplier_is_ready(multiplier_data_out) then
                            mem <= mem + get_result(multiplier_data_out,15);
                            increment(process_counter);
                        end if;

                    WHEN others =>
                        process_counter := 0;
                end CASE;
        end if; --rising_edge
    end process;	

end pfc_current_control;

