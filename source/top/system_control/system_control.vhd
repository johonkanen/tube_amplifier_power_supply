library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.component_interconnect_pkg.all;

library common_library;
    use common_library.timing_pkg.all;

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
architecture rtl of system_control is

    use work.main_state_machine_pkg.all;

    signal dc_link_measurement : integer range -2**17 to 2**17-1 := 0;

    signal component_interconnect_data_in  : component_interconnect_data_input_group;
    signal component_interconnect_data_out : component_interconnect_data_output_group;

    alias led1_color : led_counters is component_interconnect_data_in.led1_color;
    alias led2_color : led_counters is component_interconnect_data_in.led2_color;
    alias led3_color : led_counters is component_interconnect_data_in.led3_color;

    signal delay_timer_1ms_data_in  : delay_timer_data_input_group;
    signal delay_timer_1ms_data_out : delay_timer_data_output_group;

    signal main_state_machine : main_state_machine_record := init_main_state_machine;

    signal bus_from_system_control : fpga_interconnect_record;
    signal bus_to_system_control   : fpga_interconnect_record;

begin
------------------------------------------------------------------------
    u_delay_timer : delay_timer
    generic map (count_up_to => 128e3)
    port map( system_clocks.core_clock,
    	  delay_timer_1ms_data_in,
    	  delay_timer_1ms_data_out);

----------------------------------------------------------------------
    system_main : process(system_clocks.core_clock) is

        alias onboard_adc : measurement_interface_data_output_group is component_interconnect_data_out.measurement_interface_data_out;

    begin

        if rising_edge(system_clocks.core_clock) then
            init_bus(bus_from_system_control);
            connect_read_only_data_to_address(bus_to_system_control , bus_from_system_control , system_control_test_address    , t_system_states'pos(main_state_machine.st_main_states));
            connect_read_only_data_to_address(bus_to_system_control , bus_from_system_control , system_control_dc_link_address , dc_link_measurement);

            get_dc_link(onboard_adc,dc_link_measurement);
            CASE main_state_machine.st_main_states is
                WHEN init =>

                    led1_color <= led_color_red; 
                    led2_color <= led_color_red;
                    led3_color <= led_color_red;
                WHEN wait_for_dc_link_to_charge=> 

                    led1_color <= led_color_yellow; 
                    led2_color <= led_color_yellow;
                    led3_color <= led_color_yellow;
                WHEN bypass_relay=> 

                    led1_color <= led_color_pink; 
                    led2_color <= led_color_pink;
                    led3_color <= led_color_pink;
                WHEN start_power_supplies =>

                    led1_color <= led_color_purple;
                    led2_color <= led_color_purple;
                    led3_color <= led_color_purple;
                WHEN system_running =>

                    led1_color <= led_color_blu; 
                    led2_color <= led_color_blu;
                    led3_color <= led_color_blu;
                WHEN others => -- do nothing
                
            end CASE; --main_state_machin.st_main_states

            -- here is main system_control
            create_system_control(main_state_machine,system_clocks.pll_lock, component_interconnect_data_in, 
                delay_timer_1ms_data_in,
                delay_timer_1ms_data_out,
                dc_link_measurement);

            if system_clocks.pll_lock = '0' then
                led1_color <= led_color_red; 
                led2_color <= led_color_red;
                led3_color <= led_color_red;
                main_state_machine.st_main_states <= init;
                disable_power_supplies(component_interconnect_data_in);
            end if;

        end if;
    end process system_main;

    system_control_FPGA_out.bypass_relay <= main_state_machine.bypass_relay_with_1;
------------------------------------------------------------------------
u_component_interconnect : entity work.component_interconnect
port map(
        system_clocks => system_clocks,

        component_interconnect_FPGA_in  => system_control_FPGA_in.component_interconnect_FPGA_in   ,
        component_interconnect_FPGA_out => system_control_FPGA_out.component_interconnect_FPGA_out ,

        component_interconnect_data_in  => component_interconnect_data_in  ,
        component_interconnect_data_out => component_interconnect_data_out ,

        bus_to_component_interconnect   => bus_from_system_control         ,
        bus_from_component_interconnect => bus_to_system_control 
    );
------------------------------------------------------------------------

end rtl;
