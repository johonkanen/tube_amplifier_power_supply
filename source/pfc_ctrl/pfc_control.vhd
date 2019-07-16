library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
	use work.sys_ctrl_pkg.all;
	use work.ad_bus_pkg.all;
	use work.pfc_pkg.all;
	use work.tubepsu_commands_pkg.all;
    use work.onboard_ad_ctrl_pkg.all;

entity pfc_control is
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
end pfc_control;

architecture behavioral of pfc_control is
  
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

    component pfc_modulator is
    port(
	    modulator_clk : in std_logic;
	    dsp_clk : in std_logic;
	    si_rstn : in std_logic;

	    si_u12_pfc_duty : in unsigned(11 downto 0);
	    si_u12_sym_carrier : in unsigned(11 downto 0);

	    po2_pfc_pwm : out bridgeless_pfc_pwm
	);
    end component; 
    signal r_si_u12_pfc_duty : unsigned(11 downto 0); 
    signal pfc_ctrl_rstn : std_logic;
    signal r_si_uart_ready_event : std_logic;
    signal r_si16_uart_rx_data : std_logic_vector(15 downto 0);
    signal start_voltage_ctrl : std_logic; 
    signal voltage_ctrl_rdy : std_logic; 
    signal s18_voltage_pi_out : signed(17 downto 0);
    signal s18_voltage_measurement : signed(17 downto 0); 
    signal s18_pfc_reference : signed(17 downto 0); 

begin 

start_pfc_voltage_ctrl: process(core_clk,si_adb_ctrl)
begin
    if rising_edge(core_clk) then
        if si_adb_ctrl.std3_ad_address = 3d"4" then
            start_voltage_ctrl <= si_adb_ctrl.ad_rdy_trigger;
            s18_voltage_measurement <= resize(signed(si_adb_ctrl.std16_ad_bus),18);
        else
            start_voltage_ctrl <= '0';
        end if;
    end if;
end process;	

DC_link_rampup : process(core_clk)
    variable u12_rampup_cntr : unsigned(11 downto 0);
begin
    if rising_edge(core_clk) then
        if  pfc_ctrl_rstn = '0' then
        -- reset state, set initial dc link reference to peak ac voltage
           s18_pfc_reference <= s18_voltage_measurement; 
           u12_rampup_cntr := (others => '0');
        else
            if u12_rampup_cntr < 128 then
                u12_rampup_cntr := u12_rampup_cntr + 1;
            else
                u12_rampup_cntr := (others => '0');
            end if;

            if s18_pfc_reference < 18d"5000" then
                if u12_rampup_cntr = 12d"0" then
                    s18_pfc_reference <= s18_pfc_reference + 1;
                end if;
            end if;
        end if; -- rstn
    end if; --rising_edge
end process DC_link_rampup;	



pfc_voltage_control : seq_pi_control
	generic map(200,10,0,0)
port map(core_clk, pfc_ctrl_rstn, start_voltage_ctrl,open, voltage_ctrl_rdy, s18_voltage_pi_out, s18_pfc_reference, s18_voltage_measurement, 18d"1500", 18d"50");

/* r_si_u12_pfc_duty <= unsigned(s18_voltage_pi_out(11 downto 0)); */
so_std18_test_data <= std_logic_vector(s18_voltage_pi_out);
so_test_data_rdy <= voltage_ctrl_rdy;

    pfc_gate_control : pfc_modulator 
    port map(
	    modulator_clk => modulator_clk,
	    dsp_clk => core_clk,
	    si_rstn => pfc_ctrl_rstn,

	    si_u12_pfc_duty =>  r_si_u12_pfc_duty,
	    si_u12_sym_carrier => ui12_carrier,

	    po2_pfc_pwm => po2_pfc_pwm
	);


    test_pfc_pwm : process(core_clk)
    begin
	if rising_edge(core_clk) then
        if si_rstn = '0' then
            pfc_ctrl_rstn <= '0';
            /* r_si_u12_pfc_duty <= (others => '0'); */
            r_si_uart_ready_event <= '0';
            r_si16_uart_rx_data <= (others => '0');
        else
            r_si_uart_ready_event <= si_uart_ready_event;
            r_si16_uart_rx_data <= si16_uart_rx_data;

            if r_si_uart_ready_event = '1' then
                CASE r_si16_uart_rx_data(15 downto 12) is
                    WHEN c_uart_command =>
                        CASE r_si16_uart_rx_data(11 downto 0) is
                            WHEN c_pfc_start =>
                                pfc_ctrl_rstn <= '1';
                            WHEN c_pfc_stop =>
                                pfc_ctrl_rstn <= '0';
                            WHEN others =>
                                -- do nothing
                        end CASE;
                    WHEN c_pfc_duty =>
                        r_si_u12_pfc_duty <= unsigned(r_si16_uart_rx_data(11 downto 0)); 
                    WHEN others =>
                    -- do nothing
                end CASE;
            end if;
        end if;
	end if;
    end process test_pfc_pwm;
end behavioral;
