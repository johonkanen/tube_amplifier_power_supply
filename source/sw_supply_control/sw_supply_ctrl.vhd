library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
	use work.sys_ctrl_pkg.all;
	use work.ad_bus_pkg.all;
    use work.onboard_ad_ctrl_pkg.all;
	use work.dhb_pkg.all;
    use work.llc_pkg.all;
    use work.pfc_pkg.all;

entity sw_supply_ctrl is
    port(
	    core_clk : in std_logic;
	    modulator_clk : in std_logic;
	    modulator_clk2 : in std_logic;
        si_rstn : in std_logic;

-- PFC pwm
	    po2_pfc_pwm : out bridgeless_pfc_pwm;

-- heater pwm
        po4_ht_pwm : out hb_llc_pwm;

-- DBH pwm
        po4_dhb_pwm : out dhb_pwm;

-- onboard ad data in
        si_ada_ctrl : in rec_onboard_ad_ctrl_signals;
        si_adb_ctrl : in rec_onboard_ad_ctrl_signals;
-- ext ad converter data, in ad bus clock domain
        ht_adc_control : in rec_ext_ad_ctrl;
        dhb_adc_control : in rec_ext_ad_ctrl;
-- ad trigger signals
	    to_ada_triggers : out t_ad_triggers;
	    to_adb_triggers : out t_ad_triggers;
-- ext ad trigger signals, clocked in modulator_clk2 domain    
	    so_ext_ad1_start : out std_logic;
	    so_ext_ad2_start : out std_logic;
-- test data out 
	    so_std18_test_data : out std_logic_vector(17 downto 0);
        so_test_data_rdy : out std_logic;
-- uart rx for testing 
	    si_uart_ready_event	: in std_logic;
	    si16_uart_rx_data	: in std_logic_vector(15 downto 0);
-- system command signals from main state machine
	    si_tcmd_system_cmd : in tcmd_system_commands
	);
end sw_supply_ctrl;


architecture behavioral of sw_supply_ctrl is

component pfc_control is
    port(
	    core_clk : in std_logic;
	    modulator_clk : in std_logic;
        si_rstn : in std_logic;

-- PFC pwm
	    po2_pfc_pwm : out bridgeless_pfc_pwm;

	    si_ada_ctrl : in rec_onboard_ad_ctrl_signals;
	    si_adb_ctrl : in rec_onboard_ad_ctrl_signals;

	    so_std18_test_data : out std_logic_vector(17 downto 0);
        so_test_data_rdy : out std_logic;

	    ui12_carrier : in unsigned(11 downto 0);

-- uart rx for testing 
	    si_uart_ready_event	: in std_logic;
	    si16_uart_rx_data	: in std_logic_vector(15 downto 0);

	    si_tcmd_system_cmd : in tcmd_system_commands
	);
end component;

component dhb_control is
    port(
	    core_clk : in std_logic;
	    modulator_clk : in std_logic;
        si_rstn : in std_logic;
-- dhb pwm
        po4_dhb_pwm : out dhb_pwm;

-- onboard ad buses
	    si_ada_ctrl : in rec_onboard_ad_ctrl_signals;
	    si_adb_ctrl : in rec_onboard_ad_ctrl_signals;

-- ext ad converter data, in ad bus clock domain
        dhb_adc_control : in rec_ext_ad_ctrl;
	    so_std18_test_data : out std_logic_vector(17 downto 0);
        so_test_data_rdy : out std_logic;

-- uart rx for testing 
	    si_uart_ready_event	: in std_logic;
	    si16_uart_rx_data	: in std_logic_vector(15 downto 0);

	    si_tcmd_system_cmd : in tcmd_system_commands
	);
end component;

component heater_ctrl is
    port(
	    core_clk : in std_logic;
	    modulator_clk : in std_logic;
        si_rstn : in std_logic;
-- heater pwm
        po4_ht_pwm : out hb_llc_pwm;
-- onboard ad buses
	    si_ada_ctrl : in rec_onboard_ad_ctrl_signals;
	    si_adb_ctrl : in rec_onboard_ad_ctrl_signals;
-- ext ad converter data, in ad bus clock domain
        ht_adc_control : in rec_ext_ad_ctrl;
	    so_std18_test_data : out std_logic_vector(17 downto 0);
        so_test_data_rdy : out std_logic;
-- uart rx for testing 
	    si_uart_ready_event	: in std_logic;
	    si16_uart_rx_data	: in std_logic_vector(15 downto 0);

	    si_tcmd_system_cmd : in tcmd_system_commands
	);
end component;

    signal u12_carrier : unsigned(11 downto 0);
	signal r_to_ada_triggers : t_ad_triggers;
	signal r1_to_ada_triggers : t_ad_triggers;
	signal r_to_adb_triggers : t_ad_triggers;
	signal r1_to_adb_triggers : t_ad_triggers;

    signal r_si_u12_pfc_duty : unsigned(11 downto 0); 
    signal r_si16_uart_rx_data : std_logic_vector(15 downto 0);

    signal r_si16_ext_ad1_data : std_logic_vector(15 downto 0);
    signal r_si16_ext_ad2_data : std_logic_vector(15 downto 0);
begin

dhb_ctrl : dhb_control
    port map(core_clk, modulator_clk, si_rstn, po4_dhb_pwm, si_ada_ctrl, si_adb_ctrl, dhb_adc_control, so_std18_test_data, so_test_data_rdy, si_uart_ready_event, si16_uart_rx_data, si_tcmd_system_cmd);

heater_control : heater_ctrl 
    port map( core_clk, modulator_clk, si_rstn,  po4_ht_pwm, si_ada_ctrl, si_adb_ctrl, ht_adc_control, open, open, si_uart_ready_event, si16_uart_rx_data, si_tcmd_system_cmd);

pfc_control_ins : pfc_control
    port map(core_clk, modulator_clk, si_rstn, po2_pfc_pwm, si_ada_ctrl, si_adb_ctrl, open, open, u12_carrier, si_uart_ready_event, si16_uart_rx_data, si_tcmd_system_cmd);


    sym_carrier : process(modulator_clk)
        type t_carrier_states is (up, down);
        variable dir : t_carrier_states;
    begin
	if rising_edge(modulator_clk) then
	    -- carrier generation, 948*2 @ 256mhz = 135kHz
	    if si_rstn = '0' then
		    u12_carrier <= (others=>'0');
            dir := up;
            r1_to_ada_triggers <= (others => '0');
            r_to_ada_triggers <= (others => '0');
            r1_to_adb_triggers <= (others => '0');
            r_to_adb_triggers <= (others => '0');
            to_ada_triggers <= (others => '0');
            to_adb_triggers <= (others => '0');
		else -- rstn = '1'
            r_to_ada_triggers <= r1_to_ada_triggers; 
            r_to_adb_triggers <= r1_to_adb_triggers; 
            to_ada_triggers <= r_to_ada_triggers OR r1_to_ada_triggers;
            to_adb_triggers <= r_to_adb_triggers OR r1_to_adb_triggers;
            CASE dir is
                WHEN up =>
                    u12_carrier <= u12_carrier + 1;
                    if u12_carrier >= 948 then
                        dir := down;
                    else
                        dir := up;
                    end if;

                    CASE u12_carrier  is
                        WHEN 12d"6" => -- tested with oscilloscope, note old ad driver
                            r1_to_ada_triggers <= ch3;
                            r1_to_adb_triggers <= ch3;
                        WHEN 12d"163" => 
                            r1_to_ada_triggers <= ch1;
                            r1_to_adb_triggers <= ch1;
                        WHEN 12d"300" => 
                            r1_to_ada_triggers <= ch6;
                            r1_to_adb_triggers <= ch6;
                        WHEN others => 
                            r1_to_ada_triggers <= (others => '0');
                            r1_to_adb_triggers <= (others => '0');
                    end CASE;

                WHEN down =>
                    u12_carrier <= u12_carrier - 1;
                    if u12_carrier = 1 then
                        dir := up;
                    else
                        dir := down;
                    end if;

                    CASE u12_carrier  is
                        WHEN 12d"300" => 
                            r1_to_ada_triggers <= ch2;
                            r1_to_adb_triggers <= ch2;

                        WHEN 12d"163" => 
                            r1_to_ada_triggers <= ch2;
                            r1_to_adb_triggers <= ch4;

                        WHEN others => 
                            r1_to_ada_triggers <= (others => '0');
                            r1_to_adb_triggers <= (others => '0');
                    end CASE;
			WHEN others =>
			    dir := up;
		    end CASE;
	    end if;
	end if;
    end process sym_carrier;

    heater_ad_trigger : process(core_clk)
        variable heater_cntr : unsigned(11 downto 0);
    begin
        -- 200khz sampling for both, llc and dhb
        if rising_edge(core_clk) then
            if heater_cntr > 640 then
                heater_cntr := 12d"0";
                so_ext_ad1_start <= '1';
                so_ext_ad2_start <= '1';
            else
                heater_cntr := heater_cntr + 1;
                so_ext_ad1_start <= '0';
                so_ext_ad2_start <= '0';
            end if;

        end if;
    end process heater_ad_trigger;

end behavioral;
