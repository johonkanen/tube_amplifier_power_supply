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
    use work.sw_supply_ctrl_pkg.all;


entity sw_supply_control is
    port (
        sw_supply_control_clocks : in sw_supply_control_clock_group;

        sw_supply_control_FPGA_out : out sw_supply_control_FPGA_output_group;

        sw_supply_control_data_in : in sw_supply_control_data_input_group;
        sw_supply_control_data_out : out sw_supply_control_data_output_group
    );
end entity sw_supply_control;

architecture behavioral of sw_supply_control is

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

    procedure pr_count_up_and_wrap
    (
       signal counter_value : inout unsigned(15 downto 0);
       signal wrap_value : in unsigned(15 downto 0)
    )
    is
    begin
        if counter_value >= wrap_value then
            counter_value <= (others => '0');
        else
            counter_value <= counter_value + 1;
        end if;
    end pr_count_up_and_wrap;

    signal si_tcmd_system_cmd : tcmd_system_commands;

begin

-- dhb_ctrl : dhb_control
--     port map(sw_supply_control_clocks.core_clock, sw_supply_control_clocks.modulator_clock, sw_supply_control_clocks.reset_n, po4_dhb_pwm, si_ada_ctrl, si_adb_ctrl, dhb_adc_control, so_std18_test_data, so_test_data_rdy, si_uart_ready_event, si16_uart_rx_data, si_tcmd_system_cmd);
--
-- heater_control : heater_ctrl 
--     port map( sw_supply_control_clocks.core_clock, sw_supply_control_clocks.modulator_clock, sw_supply_control_clocks.reset_n,  po4_ht_pwm, si_ada_ctrl, si_adb_ctrl, ht_adc_control, open, open, si_uart_ready_event, si16_uart_rx_data, si_tcmd_system_cmd);
--
-- pfc_control_ins : pfc_control
--     port map(sw_supply_control_clocks.core_clock, sw_supply_control_clocks.modulator_clock, sw_supply_control_clocks.reset_n, po2_pfc_pwm, si_ada_ctrl, si_adb_ctrl, open, open, u12_carrier, si_uart_ready_event, si16_uart_rx_data, si_tcmd_system_cmd);


    sym_carrier : process(sw_supply_control_clocks.modulator_clock)
        type t_carrier_states is (up, down);
        variable dir : t_carrier_states;
    begin
	if rising_edge(sw_supply_control_clocks.modulator_clock) then
	    -- carrier generation, 948*2 @ 256mhz = 135kHz
	    if sw_supply_control_clocks.reset_n = '0' then
		    u12_carrier <= (others=>'0');
            dir := up;
            r1_to_ada_triggers <= (others => '0');
            r_to_ada_triggers <= (others => '0');
            r1_to_adb_triggers <= (others => '0');
            r_to_adb_triggers <= (others => '0');
            sw_supply_control_data_out.ada_triggers <= (others => '0');
            sw_supply_control_data_out.adb_triggers <= (others => '0');
		else -- rstn = '1'
            r_to_ada_triggers <= r1_to_ada_triggers; 
            r_to_adb_triggers <= r1_to_adb_triggers; 
            sw_supply_control_data_out.ada_triggers <= r_to_ada_triggers OR r1_to_ada_triggers;
            sw_supply_control_data_out.adb_triggers <= r_to_adb_triggers OR r1_to_adb_triggers;
            CASE dir is
                WHEN up =>
                    u12_carrier <= u12_carrier + 1;
                    if u12_carrier >= 948 then
                        dir := down;
                    else
                        dir := up;
                    end if;

                    CASE to_integer(u12_carrier)  is
                        WHEN 6 => -- tested with oscilloscope, note old ad driver
                            r1_to_ada_triggers <= ch3;
                            r1_to_adb_triggers <= ch3;
                        WHEN 163 => 
                            r1_to_ada_triggers <= ch1;
                            r1_to_adb_triggers <= ch1;
                        WHEN 300 => 
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

                    CASE to_integer(u12_carrier)  is
                        WHEN 300 => 
                            r1_to_ada_triggers <= ch2;
                            r1_to_adb_triggers <= ch2;

                        WHEN 163 => 
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

    heater_ad_trigger : process(sw_supply_control_clocks.core_clock)
        variable heater_cntr : unsigned(11 downto 0);
    begin
        -- 200khz sampling for both, llc and dhb
        if rising_edge(sw_supply_control_clocks.core_clock) then
            if heater_cntr > 640 then
                heater_cntr := (others => '0');
                sw_supply_control_data_out.ext_ad1_start <= '1';
                sw_supply_control_data_out.ext_ad2_start <= '1';
            else
                heater_cntr := heater_cntr + 1;
                sw_supply_control_data_out.ext_ad1_start <= '0';
                sw_supply_control_data_out.ext_ad2_start <= '0';
            end if;

        end if;
    end process heater_ad_trigger;

end behavioral;
