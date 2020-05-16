library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.multiplier_pkg.all;

package feedback_control_pkg is

    type feedback_control_clock_group is record
        clock : std_logic;
    end record;

    type feedback_control_data_input_group is record
        feedback_control_is_enabled : boolean;
        control_is_requested : boolean;
        measurement : int18;
        control_reference : int18;
    end record;

    type feedback_measurements is array (integer range <>) of feedback_control_data_input_group;
    
    type feedback_control_data_output_group is record
        feedback_is_ready : boolean;
        control_out : int18;
    end record;

    component feedback_control is
        generic(number_of_measurements : natural);
        port (
            feedback_control_clocks : in feedback_control_clock_group; 
            feedback_control_data_in : in feedback_measurements(0 to number_of_measurements -1);
            feedback_control_data_out : out feedback_control_data_output_group;
            data_from_multiplier : in multiplier_data_output_group;
            data_to_multiplier :  out multiplier_data_input_group
        );
    end component feedback_control;
--------------------------------------------------
    function feedback_is_ready ( feedback_control_out : feedback_control_data_output_group)
        return boolean;
--------------------------------------------------     
    function get_control_output ( feedback_control_out : feedback_control_data_output_group)
        return int18;
--------------------------------------------------     
    -- signal feedback_control_clocks : feedback_control_clock_group;
    -- signal feedback_control_data_in : feedback_measurements(0 to number_of_measurements -1);;
    -- signal feedback_control_data_out : feedback_control_data_output_group;
    -- signal data_from_multiplier : multiplier_data_output_group;
    -- signal data_to_multiplier : multiplier_data_input_group;
    
    -- u_feedback_control : feedback_control
    -- port map( feedback_control_clocks,
    --	  feedback_control_data_in,
    --	  feedback_control_data_out,
    --    data_from_multiplier,
    --    data_to_multiplier);

end package feedback_control_pkg;

package body feedback_control_pkg is
------------------------------------------------------------------------
    function get_control_output
    (
        feedback_control_out : feedback_control_data_output_group
    )
    return int18
    is
    begin
        return feedback_control_out.control_out;
    end get_control_output;
------------------------------------------------------------------------
    function feedback_is_ready
    (
        feedback_control_out : feedback_control_data_output_group
    )
    return boolean
    is
    begin
        return feedback_control_out.feedback_is_ready;
        
    end feedback_is_ready;
------------------------------------------------------------------------
    procedure enable_feedback_control
    (
        signal feedback_control_input : out feedback_control_data_input_group
    ) is
    begin
        feedback_control_input.feedback_control_is_enabled <= true;
    end enable_feedback_control;
------------------------------------------------------------------------
    procedure disable_feedback_control
    (
        signal feedback_control_input : out feedback_control_data_input_group
    ) is
    begin
        feedback_control_input.feedback_control_is_enabled <= false;
    end disable_feedback_control;
------------------------------------------------------------------------
end package body feedback_control_pkg;
