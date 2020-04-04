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
    end record;
    
    component delay_timer is
        generic (count_up_to : integer);
        port (
            delay_timer_clocks   : in std_logic;
            delay_timer_data_in  : in delay_timer_data_input_group;
            delay_timer_data_out : out delay_timer_data_output_group
        );
    end component delay_timer;
    
    -- signal delay_timer_clock   : std_logic;
    -- signal delay_timer_data_in  : delay_timer_data_input_group;
    -- signal delay_timer_data_out : delay_timer_data_output_group;
    
    -- u_delay_timer : delay_timer
    -- generic map (count_up_to => 2560000)
    -- port map( delay_timer_clocks,
    --	  delay_timer_data_in,
    --	  delay_timer_data_out);
------------------------------------------------------------------------

end package timing_pkg;
