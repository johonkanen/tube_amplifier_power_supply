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
