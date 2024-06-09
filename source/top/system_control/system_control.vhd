
architecture rtl of system_control is

    signal zero_cross_event : std_logic := '0';

    signal dc_link_measurement : integer;

    signal component_interconnect_data_in  : component_interconnect_data_input_group;
    signal component_interconnect_data_out : component_interconnect_data_output_group;

    alias led1_color : led_counters is component_interconnect_data_in.led1_color;
    alias led2_color : led_counters is component_interconnect_data_in.led2_color;
    alias led3_color : led_counters is component_interconnect_data_in.led3_color;

    signal delay_timer_1ms_data_in  : delay_timer_data_input_group;
    signal delay_timer_1ms_data_out : delay_timer_data_output_group;

    type t_system_states is (init,
                    charge_dc_link,
                    bypass_relay, 
                    start_power_supplies, 
                    start_heaters, 
                    start_dhb, 
                    system_running,
                    stop);
    signal st_main_states : t_system_states := init;

    signal bus_from_system_control         : fpga_interconnect_record;
    signal bus_to_system_control : fpga_interconnect_record;

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
        connect_read_only_data_to_address(bus_to_system_control , bus_from_system_control , system_control_test_address    , 12345);
        connect_read_only_data_to_address(bus_to_system_control , bus_from_system_control , system_control_dc_link_address , dc_link_measurement);

        if system_clocks.pll_lock = '0' then
            led1_color <= led_color_red; 
            led2_color <= led_color_red;
            led3_color <= led_color_red;
            dc_link_measurement <= 0;
            st_main_states <= init;
            disable_power_supplies(component_interconnect_data_in);
        else

            get_dc_link(onboard_adc,dc_link_measurement);
            
            CASE st_main_states is
                WHEN init =>

                    led1_color <= led_color_red; 
                    led2_color <= led_color_red;
                    led3_color <= led_color_red;

                    system_control_FPGA_out.bypass_relay <= '0';
                    disable_power_supplies(component_interconnect_data_in);

                    st_main_states <= init;
                    if system_clocks.pll_lock = '1' then
                        st_main_states <= charge_dc_link;
                    end if;

                WHEN charge_dc_link=> 

                    led1_color <= led_color_yellow; 
                    led2_color <= led_color_yellow;
                    led3_color <= led_color_yellow;

                    system_control_FPGA_out.bypass_relay <= '0';
                    disable_power_supplies(component_interconnect_data_in);

                    -- wait until DC link above 80V
                    st_main_states <= charge_dc_link; 
                    if dc_link_measurement > 4000 then
                            st_main_states <= bypass_relay;
                    end if;
                WHEN bypass_relay=> 

                    led1_color <= led_color_pink; 
                    led2_color <= led_color_pink;
                    led3_color <= led_color_pink;

                    system_control_FPGA_out.bypass_relay <= '0';
                    disable_power_supplies(component_interconnect_data_in);

                    request_delay(delay_timer_1ms_data_in,delay_timer_1ms_data_out,60);

                    st_main_states <= bypass_relay; 
                    if timer_is_ready(delay_timer_1ms_data_out) then
                        st_main_states <= start_power_supplies;
                    end if;

                WHEN start_power_supplies =>

                    led1_color <= led_color_purple;
                    led2_color <= led_color_purple;
                    led3_color <= led_color_purple;

                    system_control_FPGA_out.bypass_relay <= '1';
                    enable_power_supplies(component_interconnect_data_in);

                    -- TODO, add signal for indicating PFC running
                    request_delay(delay_timer_1ms_data_in,delay_timer_1ms_data_out,800);
                    component_interconnect_data_in.power_supplies_are_enabled <= true;

                    
                    st_main_states <= start_power_supplies; 
                    if timer_is_ready(delay_timer_1ms_data_out) OR zero_cross_event = '1' then
                        st_main_states <= system_running;
                        init_timer(delay_timer_1ms_data_in);
                    end if;
                    
                WHEN system_running =>

                    led1_color <= led_color_blu; 
                    led2_color <= led_color_blu;
                    led3_color <= led_color_blu;

                    system_control_FPGA_out.bypass_relay <= '1';
                    request_delay(delay_timer_1ms_data_in,delay_timer_1ms_data_out,800);
                    enable_power_supplies(component_interconnect_data_in);

                    st_main_states <= system_running; 
                    if timer_is_ready(delay_timer_1ms_data_out) then
                        -- st_main_states := start_power_supplies; 
                    end if;

                WHEN others=>
                    st_main_states <= init;
            end CASE;
        end if;

	end if;
    end process system_main;
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
