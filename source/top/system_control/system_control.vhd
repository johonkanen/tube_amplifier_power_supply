library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.system_clocks_pkg.all;
    use work.system_control_pkg.all;
    use work.component_interconnect_pkg.all;
    use work.led_driver_pkg.all;

library common_library;
    use common_library.timing_pkg.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;
    use onboard_adc_library.measurement_interface_pkg.all;
    use onboard_adc_library.psu_measurement_interface_pkg.all;

entity system_control is
    port (
        system_clocks : in system_clock_group;    

        system_control_FPGA_in : in system_control_FPGA_input_group;
        system_control_FPGA_out : out system_control_FPGA_output_group
    );
end entity system_control;

architecture rtl of system_control is

    signal start_dly : std_logic;
    signal delay_is_complete : boolean;
                                
    signal r_so_uart_ready_event : std_logic;
    signal r_so16_uart_rx_data : std_logic_vector(15 downto 0);

    signal zero_cross_event : std_logic;

    signal number_of_delays : integer;
    signal dc_link_measurement : integer;


    signal component_interconnect_data_in  : component_interconnect_data_input_group;
    signal component_interconnect_data_out : component_interconnect_data_output_group;

    alias led1_color : led_counters is component_interconnect_data_in.led1_color;
    alias led2_color : led_counters is component_interconnect_data_in.led2_color;
    alias led3_color : led_counters is component_interconnect_data_in.led3_color;

    signal delay_timer_data_in  : delay_timer_data_input_group;
    signal delay_timer_data_out : delay_timer_data_output_group;

begin
------------------------------------------------------------------------
    delay_is_complete <= delay_timer_data_out.delay_is_complete;
    delay_timer_data_in.start_delay <= true when start_dly = '1' 
                                       else false;
    delay_timer_data_in.number_of_counter_wraps <= number_of_delays;

    u_delay_timer : delay_timer
    generic map (count_up_to => 2560000)
    port map( system_clocks.core_clock,
    	  delay_timer_data_in,
    	  delay_timer_data_out);
----------------------------------------------------------------------
    system_main : process(system_clocks.core_clock) is
        type t_system_states is (init,
                        charge_dc_link,
                        bypass_relay, 
                        start_aux, 
                        start_pfc, 
                        start_heaters, 
                        start_dhb, 
                        system_running,
                        stop);
		variable st_main_states : t_system_states;

        alias onboard_adc : measurement_interface_data_output_group is component_interconnect_data_out.measurement_interface_data_out;

    begin

	if rising_edge(system_clocks.core_clock) then
        if system_clocks.pll_lock = '0' then
            led1_color <= led_color_red; 
            led2_color <= led_color_red;
            led3_color <= led_color_red;
            start_dly <= '0';
            number_of_delays <= 0;
            dc_link_measurement <= 0;
            st_main_states := init;
        else

            get_dc_link(onboard_adc,dc_link_measurement);

	    CASE st_main_states is
			WHEN init =>

                led1_color <= led_color_red; 
                led2_color <= led_color_red;
                led3_color <= led_color_red;

				number_of_delays <= 0;
				system_control_FPGA_out.bypass_relay <= '0';

				start_dly <= '0';

				if system_clocks.pll_lock = '1' then
				    st_main_states := charge_dc_link;
				else
				    st_main_states := init;
				end if;

			WHEN charge_dc_link=> 

                led1_color <= led_color_yellow; 
                led2_color <= led_color_yellow;
                led3_color <= led_color_yellow;


				number_of_delays <= 0;
				system_control_FPGA_out.bypass_relay <= '0';
				start_dly <= '1';

				-- wait until DC link above 100V
                st_main_states := charge_dc_link; 
                if dc_link_measurement > 4900 then
                        st_main_states := bypass_relay;
                end if;
			WHEN bypass_relay=> 

                led1_color <= led_color_pink; 
                led2_color <= led_color_pink;
                led3_color <= led_color_pink;

				-- r_si_tcmd_system_cmd <= bypass_relay;
				number_of_delays <= 6;
				system_control_FPGA_out.bypass_relay <= '0';

				if delay_is_complete then
				    st_main_states := start_aux;
				system_control_FPGA_out.bypass_relay <= '1';
				    start_dly <= '0';
				else
				    st_main_states := bypass_relay; 
				    start_dly <= '1';
				end if;

			WHEN start_aux =>

                led1_color <= led_color_purple; 
                led2_color <= led_color_purple;
                led3_color <= led_color_purple;

				number_of_delays <= 50;
				system_control_FPGA_out.bypass_relay <= '1';
				
				if delay_is_complete OR zero_cross_event = '1' then
				    st_main_states := system_running;
				    start_dly <= '0';
				else
				    st_main_states := start_aux; 
				    start_dly <= '1';
				end if;
				
			WHEN system_running =>

                led1_color <= led_color_blu; 
                led2_color <= led_color_blu;
                led3_color <= led_color_blu;

				start_dly <= '0';
				system_control_FPGA_out.bypass_relay <= '1';
				number_of_delays <= 0;
				st_main_states := system_running; 

			WHEN others=>
				start_dly <= '0';
				number_of_delays <= 0;
				st_main_states := init;
	    end CASE;
    end if;

	end if;
    end process system_main;
------------------------------------------------------------------------
u_component_interconnect : component_interconnect
port map(
        system_clocks,
        system_control_FPGA_in.component_interconnect_FPGA_in,
        system_control_FPGA_out.component_interconnect_FPGA_out,

        component_interconnect_data_in,
        component_interconnect_data_out
    );
------------------------------------------------------------------------

end rtl;
