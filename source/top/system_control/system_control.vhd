library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.system_control_pkg.all;
    use work.led_driver_pkg.all;

entity system_control is
    port (
        system_clocks : in work.vendor_specifics_pkg.system_clock_group;    

        system_control_FPGA_in : in system_control_FPGA_input_group;
        system_control_FPGA_out : out system_control_FPGA_output_group;

        system_control_data_in : in system_control_data_input_group;
        system_control_data_out : out system_control_data_output_group
    );
end entity system_control;

architecture rtl of system_control is

signal start_dly : std_logic;
signal delay_is_complete : boolean;
							
signal r_so_uart_ready_event : std_logic;
signal r_so16_uart_rx_data : std_logic_vector(15 downto 0);

signal zero_cross_event : std_logic;

signal u10_dly_cnt : unsigned(9 downto 0);

signal led1_color : led_counters;
signal led2_color : led_counters;
signal led3_color : led_counters;


-- signal r_so_ada_ctrl : rec_onboard_ad_ctrl_signals;
-- signal r_so_adb_ctrl : rec_onboard_ad_ctrl_signals;

begin

    delay_20ms : process(system_clocks.core_clock)
        variable u22_init_dly_cnt : integer; 
        variable v_u10_dly_cnt : integer;
    begin
	if rising_edge(system_clocks.core_clock) then

        delay_is_complete <= false;
	    if start_dly = '1' then
            u22_init_dly_cnt := u22_init_dly_cnt +1;

			if u22_init_dly_cnt = 2560000 then
				u22_init_dly_cnt := 0;
				v_u10_dly_cnt := v_u10_dly_cnt + 1;

				if v_u10_dly_cnt = u10_dly_cnt then
				    delay_is_complete <= true;
				end if;

			end if;
	    else
			v_u10_dly_cnt := 0;
			u22_init_dly_cnt := 0;
	    end if;
	end if;
    end process delay_20ms;

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

    begin

	if rising_edge(system_clocks.core_clock) then
        if si_pll_lock = '0' then
            led1_color <= led_color_red; 
            led2_color <= led_color_red;
            led3_color <= led_color_red;
            r_si_tcmd_system_cmd <= init;
            start_dly <= '0';
            u10_dly_cnt <= (others => '0');
            st_main_states := init;
        else

	    CASE st_main_states is
			WHEN init =>

                led1_color <= led_color_red; 
                led2_color <= led_color_red;
                led3_color <= led_color_red;

				u10_dly_cnt <= (others => '0');
				po_bypass_relay <= '0';

				start_dly <= '0';
				r_si_tcmd_system_cmd <= init;

				if si_pll_lock = '1' then
				    st_main_states := charge_dc_link;
				else
				    st_main_states := init;
				end if;

			WHEN charge_dc_link=> 

                led1_color <= led_color_yellow; 
                led2_color <= led_color_yellow;
                led3_color <= led_color_yellow;


				u10_dly_cnt <= (others => '0');
				po_bypass_relay <= '0';
				r_si_tcmd_system_cmd <= charge_dc_link;
				start_dly <= '0';
				-- wait until DC link above 100V

                    if r_so_adb_ctrl.std3_ad_address= 4 AND r_so_adb_ctrl.ad_rdy_trigger = '1' then
                        if unsigned(r_so_adb_ctrl.std16_ad_bus) > 4936 then
                            st_main_states := bypass_relay;
                        else
                            st_main_states := charge_dc_link; 
                        end if;
                    end if;

			WHEN bypass_relay=> 

                led1_color <= led_color_pink; 
                led2_color <= led_color_pink;
                led3_color <= led_color_pink;

				r_si_tcmd_system_cmd <= bypass_relay;
				u10_dly_cnt <= to_unsigned(6,10);
				po_bypass_relay <= '0';

				if delay_is_complete then
				    st_main_states := start_aux;
				    start_dly <= '0';
				else
				    st_main_states := bypass_relay; 
				    start_dly <= '1';
				end if;

			WHEN start_aux =>

                led1_color <= led_color_purple; 
                led2_color <= led_color_purple;
                led3_color <= led_color_purple;

				u10_dly_cnt <= to_unsigned(50,10);
				po_bypass_relay <= '0';
				
				if delay_is_complete OR zero_cross_event = '1' then
				    st_main_states := system_running;
				    start_dly <= '0';
				else
				    st_main_states := start_aux; 
				    start_dly <= '1';
				end if;
				
                if r_so_adb_ctrl.ad_rdy_trigger = '1' then
                    if  r_so_adb_ctrl.std3_ad_address = 2 then -- if bypass released at 0V, vac meas = 2088
                        if unsigned(r_so_adb_ctrl.std16_ad_bus) > 16504 AND unsigned(r_so_adb_ctrl.std16_ad_bus) < 16904 then
                            zero_cross_event <= '1';
                        else
                            zero_cross_event <= '0';
                        end if;
                    end if;
                end if;
				r_si_tcmd_system_cmd <= start_aux;


			WHEN system_running =>

                led1_color <= led_color_blu; 
                led2_color <= led_color_blu;
                led3_color <= led_color_blu;

				start_dly <= '0';
				po_bypass_relay <= '1';
				u10_dly_cnt <= (others => '0');
				st_main_states := system_running; 

			WHEN others=>
				start_dly <= '0';
				u10_dly_cnt <= (others => '0');
				st_main_states := init;
	    end CASE;
    end if;

	end if;
    end process system_main;

burn_leds : led_driver
port map(system_clocks.core_clock, po3_led1, po3_led2, po3_led3, led1_color, led2_color, led3_color);


end rtl;
