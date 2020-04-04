library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package timing_pkg is
------------------------------------------------------------------------
    type delay_timer_data_input_group is record
        start_delay : boolean;
        number_of_counter_wraps : integer range 0 to 2**12-1;
    end record;
    
    type delay_timer_data_output_group is record
        delay_is_complete : boolean;
        delay_is_running : boolean;
    end record;
    
    component delay_timer is
        generic (count_up_to : integer);
        port (
            delay_timer_clocks   : in std_logic;
            delay_timer_data_in  : in delay_timer_data_input_group;
            delay_timer_data_out : out delay_timer_data_output_group
        );
    end component delay_timer;
    
    -- signal delay_timer_data_in  : delay_timer_data_input_group;
    -- signal delay_timer_data_out : delay_timer_data_output_group;
    
    -- u_delay_timer : delay_timer
    -- generic map (count_up_to => 2560000)
    -- port map( delay_timer_clocks,
    --	  delay_timer_data_in,
    --	  delay_timer_data_out);
------------------------------------------------------------------------
    procedure init_timer (
        signal timer_control : out delay_timer_data_input_group);
------------------------------------------------------------------------
    procedure request_delay (
        signal timer_control : out delay_timer_data_input_group;
        timer_control_out : in delay_timer_data_output_group;
        constant number_of_timer_tics : integer);
------------------------------------------------------------------------
    function timer_is_ready ( timer_control : delay_timer_data_output_group)
        return boolean;
------------------------------------------------------------------------

end package timing_pkg;

package body timing_pkg is
------------------------------------------------------------------------
    procedure init_timer
    (
        signal timer_control : out delay_timer_data_input_group
    ) is
    begin
        timer_control.start_delay <= false;
    end init_timer;
------------------------------------------------------------------------
    procedure request_delay
    (
        signal timer_control : out delay_timer_data_input_group;
        timer_control_out : in delay_timer_data_output_group;
        constant number_of_timer_tics : integer
    ) is
    begin
        if timer_control_out.delay_is_running = false then
            timer_control.start_delay <= true;
            timer_control.number_of_counter_wraps <= number_of_timer_tics;
        end if;
    end request_delay;
------------------------------------------------------------------------
    function timer_is_ready
    (
        timer_control : delay_timer_data_output_group
    )
    return boolean
    is
    begin
        return timer_control.delay_is_complete;
    end timer_is_ready;
------------------------------------------------------------------------
end package body timing_pkg;
