library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.component_interconnect_pkg.all;

    use work.timing_pkg.all;

package main_state_machine_pkg is

    type t_system_states is (init,
                    wait_for_dc_link_to_charge,
                    bypass_relay, 
                    start_power_supplies, 
                    start_heaters, 
                    start_dhb, 
                    system_running,
                    stop);

    type main_state_machine_record is record
        st_main_states : t_system_states;
        data : std_logic;
        bypass_relay_with_1 : std_logic;
    end record;

    constant init_main_state_machine : main_state_machine_record := (init, '0', '0');

    procedure create_system_control (
        signal self : inout main_state_machine_record;
        pll_lock : in std_logic;
        signal component_interconnect_in : out component_interconnect_data_input_group;
        signal delay_timer_in : out delay_timer_data_input_group;
        delay_timer_out : in delay_timer_data_output_group;
        dc_link_voltage : in integer);

end package main_state_machine_pkg;
------------------------------------------------------------------------
package body main_state_machine_pkg is

        procedure create_system_control
        (
            signal self : inout main_state_machine_record;
            pll_lock : in std_logic;
            signal component_interconnect_in : out component_interconnect_data_input_group;
            signal delay_timer_in : out delay_timer_data_input_group;
            delay_timer_out : in delay_timer_data_output_group;
            dc_link_voltage : in integer
        ) is
        begin

            
            CASE self.st_main_states is
                WHEN init =>
                    self.bypass_relay_with_1 <= '0';
                    disable_power_supplies(component_interconnect_in);

                    self.st_main_states <= init;
                    if pll_lock = '1' then
                        self.st_main_states <= wait_for_dc_link_to_charge;
                    end if;

                WHEN wait_for_dc_link_to_charge =>

                    self.bypass_relay_with_1 <= '0';
                    disable_power_supplies(component_interconnect_in);

                    -- wait until DC link above 80V
                    self.st_main_states <= wait_for_dc_link_to_charge; 
                    if dc_link_voltage > 4000 then
                            self.st_main_states <= bypass_relay;
                    end if;
                WHEN bypass_relay=> 

                    self.bypass_relay_with_1 <= '0';
                    disable_power_supplies(component_interconnect_in);

                    request_delay(delay_timer_in,delay_timer_out,60);

                    self.st_main_states <= bypass_relay; 
                    if timer_is_ready(delay_timer_out) then
                        self.st_main_states <= start_power_supplies;
                    end if;

                WHEN start_power_supplies =>

                    self.bypass_relay_with_1 <= '1';
                    enable_power_supplies(component_interconnect_in);

                    -- TODO, add signal for indicating PFC running
                    request_delay(delay_timer_in,delay_timer_out,800);
                    
                    self.st_main_states <= start_power_supplies; 
                    if timer_is_ready(delay_timer_out) then -- OR zero_cross_event = '1' then
                        self.st_main_states <= system_running;
                        init_timer(delay_timer_in);
                    end if;
                    
                WHEN system_running =>

                    self.bypass_relay_with_1 <= '1';
                    request_delay(delay_timer_in,delay_timer_out,800);
                    enable_power_supplies(component_interconnect_in);

                    self.st_main_states <= system_running; 
                    if timer_is_ready(delay_timer_out) then
                        -- self.st_main_states := start_power_supplies; 
                    end if;

                WHEN others=>
                    self.st_main_states <= init;
            end CASE;
            
        end create_system_control;

end package body main_state_machine_pkg;
------------------------------------------------------------------------
