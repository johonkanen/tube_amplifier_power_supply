library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package delay_timer_pkg is
------------------------------------------------------------------------
    type delay_timer_data_input_group is record
        start_delay : boolean;
        number_of_counter_wraps : natural;
    end record;
    
    type delay_timer_data_output_group is record
        delay_is_complete : boolean;
        delay_is_running : boolean;
    end record;

    type delay_timer_record is record
        delay_timer_in : delay_timer_data_input_group;
        delay_timer_out : delay_timer_data_output_group;
    end record;

    view delay_timer_view of delay_timer_record is
        delay_timer_in : in;
        delay_timer_out : out;
    end view;

    alias delay_timer_cview is delay_timer_view'converse;
    
------------------------------------------------------------------------
    procedure init_timer (
        signal delay_timer_interface : view delay_timer_cview);
------------------------------------------------------------------------
    procedure request_delay (
        signal delay_timer_interface : view delay_timer_cview;
        constant number_of_timer_tics : integer);
------------------------------------------------------------------------
    impure function signal timer_is_ready (signal delay_timer_interface : view delay_timer_view);
        return boolean;
------------------------------------------------------------------------

end package delay_timer_pkg;

package body delay_timer_pkg is
------------------------------------------------------------------------
    procedure init_timer
    (
        signal delay_timer_interface : view delay_timer_cview
    ) is
    begin
        delay_timer_interface.start_delay <= false;
    end init_timer;
------------------------------------------------------------------------
    impure function timer_is_ready
    (
        signal delay_timer_interface : view delay_timer_view
    )
    return boolean
    is
    begin
        return timer_control.delay_is_complete;
    end timer_is_ready;
------------------------------------------------------------------------
    procedure request_delay
    (
        signal delay_timer_interface : view delay_timer_cview
        constant number_of_timer_tics : integer
    ) is
    begin
        timer_control.number_of_counter_wraps <= number_of_timer_tics;
        if timer_is_ready(delay_timer_interface) then
            timer_control.start_delay <= false;
        else
            timer_control.start_delay <= true;
        end if;
    end request_delay;
------------------------------------------------------------------------
end package body delay_timer_pkg;
