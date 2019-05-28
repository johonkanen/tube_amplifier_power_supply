library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
	use work.sys_ctrl_pkg.all;
    use work.onboard_ad_ctrl_pkg.all;
    use work.led_driver_pkg.all;


entity system_control is
    port(
	    core_clk : in std_logic;
	    modulator_clk : in std_logic;
	    modulator_clk2 : in std_logic;
    

	    si_pll_lock : in std_logic;
	    
-- relay bypass
	    po_bypass_relay : out std_logic;	

-- aux pwm
	    po_aux_pwm : out std_logic;

-- PFC pwm
	    po2_pfc_pwm : out std_logic_vector(1 downto 0);

-- heater pwm
	    po2_ht_pri_pwm : out std_logic_vector(1 downto 0);
	    po2_ht_sec_pwm : out std_logic_vector(1 downto 0);

-- DBH pwm
	    po2_DHB_pri_pwm : out std_logic_vector(1 downto 0);
	    po2_DHB_sec_pwm : out std_logic_vector(1 downto 0);
			
-- uart rx and tx
	    pi_uart_rx : in std_logic;
	    po_uart_tx : out std_logic;

-- ad converter A signals
	    po_ada_cs : out std_logic;
	    po_ada_clk : out std_logic;
	    pi_ada_sdata : in std_logic;
	    po3_ada_muxsel : out std_logic_vector(2 downto 0);

-- ad converter B signals
	    po_adb_cs : out std_logic;
	    po_adb_clk : out std_logic;
	    pi_adb_sdata : in std_logic;
	    po3_adb_muxsel : out std_logic_vector(2 downto 0);

-- ext ad converter 1 signals
	    po_ext_ad1_cs : out std_logic;
	    po_ext_ad1_clk : out std_logic;
	    pi_ext_ad1_sdata : in std_logic;

-- ext ad converter 2 signals
	    po_ext_ad2_cs : out std_logic;
	    po_ext_ad2_clk : out std_logic;
	    pi_ext_ad2_sdata : in std_logic;

-- rgb status leds driver signals, active low
	    po3_led1 : out std_logic_vector(2 downto 0);
	    po3_led2 : out std_logic_vector(2 downto 0);
	    po3_led3 : out std_logic_vector(2 downto 0)
         );
end system_control;

architecture rtl of system_control is

component data_control is
    port(
	    core_clk : in std_logic;
	    modulator_clk : in std_logic;
	    modulator_clk2 : in std_logic;
	    si_pll_lock : in std_logic;

-- aux pwm
	    po_aux_pwm : out std_logic;

-- PFC pwm
	    po2_pfc_pwm : out std_logic_vector(1 downto 0);

-- heater pwm
	    po2_ht_pri_pwm : out std_logic_vector(1 downto 0);
	    po2_ht_sec_pwm : out std_logic_vector(1 downto 0);

-- DBH pwm
	    po2_DHB_pri_pwm : out std_logic_vector(1 downto 0);
	    po2_DHB_sec_pwm : out std_logic_vector(1 downto 0);
			
-- uart rx and tx
	    pi_uart_rx : in std_logic;
	    po_uart_tx : out std_logic;

-- ad converter A signals
	    po_ada_cs : out std_logic;
	    po_ada_clk : out std_logic;
	    pi_ada_sdata : in std_logic;
	    po3_ada_muxsel : out std_logic_vector(2 downto 0);

-- ad converter B signals
	    po_adb_cs : out std_logic;
	    po_adb_clk : out std_logic;
	    pi_adb_sdata : in std_logic;
	    po3_adb_muxsel : out std_logic_vector(2 downto 0);

-- ext ad converter 1 signals
	    po_ext_ad1_cs : out std_logic;
	    po_ext_ad1_clk : out std_logic;
	    pi_ext_ad1_sdata : in std_logic;

-- ext ad converter 2 signals
	    po_ext_ad2_cs : out std_logic;
	    po_ext_ad2_clk : out std_logic;
	    pi_ext_ad2_sdata : in std_logic;
	    

        so_ada_ctrl : out rec_onboard_ad_ctrl_signals;
        so_adb_ctrl : out rec_onboard_ad_ctrl_signals;
	    
	    so_uart_ready_event	: out std_logic;
	    so16_uart_rx_data	: out std_logic_vector(15 downto 0);

	    si_tcmd_system_cmd : in tcmd_system_commands

);
end component;

signal start_dly : std_logic;
signal dly_complete : std_logic;
							
signal r_so_uart_ready_event : std_logic;
signal r_so16_uart_rx_data : std_logic_vector(15 downto 0);

signal zero_cross_event : std_logic;

signal u10_dly_cnt : unsigned(9 downto 0);

signal led1_color : led_counters;
signal led2_color : led_counters;
signal led3_color : led_counters;


signal r_so_ada_ctrl : rec_onboard_ad_ctrl_signals;
signal r_so_adb_ctrl : rec_onboard_ad_ctrl_signals;

begin

burn_leds : led_driver
port map(core_clk, po3_led1, po3_led2, po3_led3, led1_color, led2_color, led3_color);

system_data_control : data_control
    port map(
	    core_clk =>  core_clk,
	    modulator_clk => modulator_clk,
	    modulator_clk2 => modulator_clk2,
	    si_pll_lock =>si_pll_lock,
-- aux pwm
	    po_aux_pwm => po_aux_pwm,

-- PFC pwm
	    po2_pfc_pwm => po2_pfc_pwm,

-- heater pwm
	    po2_ht_pri_pwm => po2_ht_pri_pwm,
	    po2_ht_sec_pwm => po2_ht_sec_pwm,

-- DBH pwm
	    po2_DHB_pri_pwm => po2_DHB_pri_pwm,
	    po2_DHB_sec_pwm => po2_DHB_sec_pwm,
			
-- uart rx and tx
	    pi_uart_rx => pi_uart_rx,
	    po_uart_tx => po_uart_tx,

-- ad converter A signals
	    po_ada_cs => po_ada_cs,
	    po_ada_clk => po_ada_clk,
	    pi_ada_sdata => pi_ada_sdata,
	    po3_ada_muxsel => po3_ada_muxsel, 

-- ad converter B signals
	    po_adb_cs => po_adb_cs,
	    po_adb_clk => po_adb_clk,
	    pi_adb_sdata => pi_adb_sdata,
	    po3_adb_muxsel => po3_adb_muxsel,

-- ext ad converter 1 signals
	    po_ext_ad1_cs => po_ext_ad1_cs,
	    po_ext_ad1_clk => po_ext_ad1_clk,
	    pi_ext_ad1_sdata => pi_ext_ad1_sdata,

-- ext ad converter 2 signals
	    po_ext_ad2_cs => po_ext_ad2_cs,
	    po_ext_ad2_clk => po_ext_ad2_clk,
	    pi_ext_ad2_sdata => pi_ext_ad2_sdata,



        so_ada_ctrl => r_so_ada_ctrl,
        so_adb_ctrl => r_so_adb_ctrl,

	    so_uart_ready_event	=> r_so_uart_ready_event,
	    so16_uart_rx_data => r_so16_uart_rx_data,
	    
	    si_tcmd_system_cmd => r_si_tcmd_system_cmd
	);

    delay_20ms : process(core_clk)
	variable u22_init_dly_cnt : unsigned(21 downto 0);
	variable v_u10_dly_cnt : unsigned(21 downto 0);
    begin
	if rising_edge(core_clk) then
	    if start_dly = '1' then
			if u22_init_dly_cnt = 22d"2560000" then
				u22_init_dly_cnt := (others=>'0');
				v_u10_dly_cnt := v_u10_dly_cnt + 1;

				if v_u10_dly_cnt = u10_dly_cnt then
				    dly_complete <= '1';
				else
				    dly_complete <= '0';
				end if;
			else
				u22_init_dly_cnt := u22_init_dly_cnt +1;
				dly_complete <= '0';
			end if;
	    else
			v_u10_dly_cnt := (others=>'0');
			u22_init_dly_cnt := (others=>'0');
			dly_complete <= '0';
	    end if;
	end if;
    end process delay_20ms;


    system_main : process(core_clk) is

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
		variable u21_init_dly_cnt : unsigned(20 downto 0);

    begin

	if rising_edge(core_clk) then
        if si_pll_lock = '1' then
	    CASE st_main_states is
			WHEN init =>

                led1_color <= led_color_red; 
                led2_color <= led_color_red;
                led3_color <= led_color_red;

				u10_dly_cnt <= 10d"0";


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


				u10_dly_cnt <= 10d"0";
				po_bypass_relay <= '0';
				r_si_tcmd_system_cmd <= charge_dc_link;
				start_dly <= '0';
				-- wait until DC link above 100V

                if r_so_adb_ctrl.ad_rdy_trigger = '1' then
                    if r_so_adb_ctrl.std3_ad_address= 3d"5" then
                        if r_so_adb_ctrl.std16_ad_bus > 16d"2400" then
                            st_main_states := bypass_relay;
                        else
                            st_main_states := charge_dc_link; 
                        end if;
                    end if;
                end if;

			WHEN bypass_relay=> 

                led1_color <= led_color_pink; 
                led2_color <= led_color_pink;
                led3_color <= led_color_pink;


				r_si_tcmd_system_cmd <= bypass_relay;
				u10_dly_cnt <= 10d"3";
				po_bypass_relay <= '0';

				if dly_complete = '1' then
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

				u10_dly_cnt <= 10d"50";
				po_bypass_relay <= '0';
				
				if dly_complete = '1' OR  zero_cross_event = '1' then
				    st_main_states := system_running;
				    start_dly <= '0';
				else
				    st_main_states := start_aux; 
				    start_dly <= '1';
				end if;
				
                if r_so_adb_ctrl.ad_rdy_trigger = '1' then
                    if  r_so_adb_ctrl.std3_ad_address= 3d"2" then -- if bypass released at 0V, vac meas = 2088
                        if r_so_adb_ctrl.std16_ad_bus > 16d"2063" AND r_so_adb_ctrl.std16_ad_bus < 16d"2113" then
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
				u10_dly_cnt <= 10d"0";
				st_main_states := system_running; 

			WHEN others=>
				start_dly <= '0';
				u10_dly_cnt <= 10d"0";
				st_main_states := init;
	    end CASE;
    else
            r_si_tcmd_system_cmd <= init;
            start_dly <= '0';
            u10_dly_cnt <= 10d"0";
            st_main_states := init;
    end if;

	end if;
    end process system_main;


end rtl;
