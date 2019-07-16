library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
	use work.sys_ctrl_pkg.all;
	use work.ad_bus_pkg.all;
    use work.onboard_ad_ctrl_pkg.all;
    use work.dhb_pkg.all;
    use work.tubepsu_commands_pkg.all;
    
entity dhb_control is
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
end dhb_control;


architecture rtl of dhb_control is

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
    
	signal jihuu : rec_dhb_input;
    signal r_so_sign18_pi_out : signed(17 downto 0);
    signal r_si_sign18_meas : signed(17 downto 0);
    signal voltage_ctrl_rdy : std_logic;
    signal s18_dhb_reference : signed(17 downto 0); 

begin

dhb_voltage_control : seq_pi_control
	generic map(80,-80,0,0)
port map(core_clk, jihuu.rstn, dhb_adc_control.ad_rdy_trigger,so_test_data_rdy, voltage_ctrl_rdy, r_so_sign18_pi_out, s18_dhb_reference, r_si_sign18_meas, 18d"15000", 18d"2200");

so_std18_test_data <= std_logic_vector(r_so_sign18_pi_out);

r_si_sign18_meas <= resize(signed(dhb_adc_control.std16_ad_bus),18);
jihuu.u12_dhb_half_period <= 12d"472";

dhb_modulator : phase_modulator
generic map(8d"56")
port map(modulator_clk, jihuu, po4_dhb_pwm);

jihuu.s16_phase <= (resize(r_so_sign18_pi_out,16));

ramp_reference : process(core_clk)
    
begin
    if rising_edge(core_clk) then
        if jihuu.rstn = '0' then
            -- reset state
            s18_dhb_reference <= (others => '0');
        else
            -- dhb reference, 4960 = 199.9V
            if s18_dhb_reference <= 18d"4960" then
                s18_dhb_reference <= s18_dhb_reference + 1;
            end if;

        end if; -- rstn
    end if; --rising_edge
end process ramp_reference;	

test_dhb : process(core_clk)
    begin
	if rising_edge(core_clk) then
        if si_rstn = '0' then
            jihuu.rstn <= '0';
            /* jihuu.s16_phase <= (others => '0'); */
        else
	    if si_uart_ready_event = '1' then
            CASE si16_uart_rx_data(15 downto 12) is
                WHEN x"0" =>
                CASE si16_uart_rx_data(11 downto 0) is
                    WHEN 12d"30" =>
                    jihuu.rstn <= '1';
                    WHEN 12d"31" =>
                    jihuu.rstn <= '0';
                    WHEN others =>
                    -- do nothing
                end CASE;

                WHEN x"3" =>
                    /* jihuu.s16_phase <= resize(signed(si16_uart_rx_data(11 downto 0)),16); */ 
                WHEN others =>
                -- do nothing
            end CASE;
        end if;

	    end if;
	end if;
    end process test_dhb;


end rtl;

