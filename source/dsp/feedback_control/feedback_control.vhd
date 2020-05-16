library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.feedback_control_pkg.all;
    use work.multiplier_pkg.all;

entity feedback_control is
    generic(number_of_measurements : natural);
    port (
        feedback_control_clocks : in feedback_control_clock_group; 
        feedback_control_data_in : in feedback_measurements(0 to number_of_measurements -1 );
        feedback_control_data_out : out feedback_control_data_output_group;
        data_from_multiplier : in multiplier_data_output_group;
        data_to_multiplier :  out multiplier_data_input_group
    );
end entity;

-- empty entity, to allow polymorphism via varying architectures
