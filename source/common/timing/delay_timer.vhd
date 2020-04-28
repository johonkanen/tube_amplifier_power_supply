library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library common_library;
    use common_library.timing_pkg.all;


entity delay_timer is
    generic (count_up_to : integer);
    port (
        delay_timer_clocks   : in std_logic;
        delay_timer_data_in  : in delay_timer_data_input_group;
        delay_timer_data_out : out delay_timer_data_output_group
    );
end entity;

architecture rtl of delay_timer is


begin

-- TODO, refactor into a component
    delay_20ms : process(delay_timer_clocks)
        variable u22_init_dly_cnt : integer; 
        variable v_number_of_delays : natural;
    begin
        if rising_edge(delay_timer_clocks) then

            delay_timer_data_out.delay_is_running <= false;
            delay_timer_data_out.delay_is_complete <= false;
            if delay_timer_data_in.start_delay then
                u22_init_dly_cnt := u22_init_dly_cnt +1;
                delay_timer_data_out.delay_is_running <= true;

                if u22_init_dly_cnt = count_up_to then
                    u22_init_dly_cnt := 0;
                    v_number_of_delays := v_number_of_delays + 1;
                    delay_timer_data_out.delay_is_running <= true;

                    if v_number_of_delays = delay_timer_data_in.number_of_counter_wraps then
                        delay_timer_data_out.delay_is_complete <= true;
                        delay_timer_data_out.delay_is_running <= false;
                    end if;

                end if;
            else
                v_number_of_delays := 0;
                u22_init_dly_cnt := 0;
            end if;

        end if;
    end process delay_20ms;


end rtl;
