library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
	use work.sys_ctrl_pkg.all;
	use work.ad_bus_pkg.all;
    use work.onboard_ad_ctrl_pkg.all;
    use work.llc_pkg.all;
    use work.tubepsu_commands_pkg.all;

entity heater_ctrl is
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
end heater_ctrl;

architecture behavioral of heater_ctrl is

component freq_modulator is
    port(
	    modulator_clk : in std_logic;
	    dsp_clk : in std_logic;
	    rstn : in std_logic;

	    piu12_per_ctrl : in unsigned(11 downto 0);
-- heater pwm
        po4_ht_pwm : out hb_llc_pwm
	);
end component;

component seq_pi_control is 
	generic(
				gen_pi_sat_high : integer; 
				gen_pi_sat_low : integer;
				gen_left_shift_p_gain : integer;
				gen_offset_sign18 : integer
			);
    port(
	    pi_clk : in std_logic;
        si_rstn : in std_logic;
	    
	    si_start : in std_logic;
	    so_pi_busy : out std_logic;
	    so_pi_out_rdy : out std_logic;

	    so_sign18_pi_out : out signed(17 downto 0);

	    si_sign18_ref : in signed(17 downto 0);
	    si_sign18_meas : in signed(17 downto 0);

	    si_sign18_p_gain : in signed(17 downto 0);
	    si_sign18_i_gain : in signed(17 downto 0)
	);
end component;
 
signal r_si_rstn : std_logic;
signal voltage_ctrl_rdy : std_logic;
signal r_piu12_per_ctrl  : unsigned(11 downto 0); 
signal r_so_sign18_pi_out : signed(17 downto 0);
signal r_si_sign18_meas : signed(17 downto 0);

begin

heater_voltage_control : seq_pi_control
	generic map(1700,948,0,0)
port map(core_clk, r_si_rstn, ht_adc_control.ad_rdy_trigger,so_test_data_rdy, voltage_ctrl_rdy, r_so_sign18_pi_out, 18d"13945", r_si_sign18_meas, 18d"1500", 18d"50");

so_std18_test_data <= std_logic_vector(r_so_sign18_pi_out);
r_si_sign18_meas <= resize(signed(ht_adc_control.std16_ad_bus),18);

llc_modulator : freq_modulator
    port map(modulator_clk, modulator_clk, r_si_rstn, r_piu12_per_ctrl, po4_ht_pwm);

/* r_piu12_per_ctrl  <= unsigned(r_so_sign18_pi_out(17 downto 6)); */

test_heater_pwm : process(core_clk)
    begin
	if rising_edge(core_clk) then
        if si_rstn = '0' then
            r_si_rstn <= '0';
            -- start frequency is 270kHz
            r_piu12_per_ctrl <= 12d"474";
        else
            if si_uart_ready_event = '1' then
            CASE si16_uart_rx_data(15 downto 12) is
                WHEN x"0" =>
                CASE si16_uart_rx_data(11 downto 0) is
                    WHEN c_llc_start =>
                    r_si_rstn <= '1';
                    WHEN c_llc_stop =>
                    r_si_rstn <= '0';
                    WHEN others =>
                    -- do nothing
                end CASE;

                WHEN c_llc_freq =>
                r_piu12_per_ctrl  <= unsigned(si16_uart_rx_data(11 downto 0)); 
                WHEN others =>
                -- do nothing
            end CASE;
        end if;

	    end if;
	end if;
    end process test_heater_pwm;



end behavioral;
