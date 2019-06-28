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

	    ui12_carrier : in unsigned(11 downto 0);

-- uart rx for testing 
	    si_uart_ready_event	: in std_logic;
	    si16_uart_rx_data	: in std_logic_vector(15 downto 0);

	    si_tcmd_system_cmd : in tcmd_system_commands
	);
end pfc_control;

architecture behavioral of pfc_control is
  
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
    signal unstable_si_u12_pfc_duty : unsigned(11 downto 0); 
    signal stable_si_u12_pfc_duty : unsigned(11 downto 0); 
    signal r_si_rstn : std_logic;
    signal unstable_si_rstn : std_logic;
    signal stable_si_rstn : std_logic;
    signal r_si_uart_ready_event : std_logic;
    signal r_si16_uart_rx_data : std_logic_vector(15 downto 0);

begin 
 
    pfc_gate_control : pfc_modulator 
    port map(
	    modulator_clk => modulator_clk,
	    dsp_clk => core_clk,
	    si_rstn => r_si_rstn,

	    si_u12_pfc_duty =>  r_si_u12_pfc_duty,
	    si_u12_sym_carrier => ui12_carrier,

	    po2_pfc_pwm => po2_pfc_pwm
	);

    test_pfc_pwm : process(core_clk)
    begin
	if rising_edge(core_clk) then
        if si_rstn = '1' then
            if r_si_uart_ready_event = '1' then
                CASE r_si16_uart_rx_data(15 downto 12) is
                    WHEN c_uart_command =>
                    CASE r_si16_uart_rx_data(11 downto 0) is
                        WHEN c_pfc_start =>
                        r_si_rstn <= '1';
                        WHEN c_pfc_stop =>
                        r_si_rstn <= '0';
                        WHEN others =>
                        -- do nothing
                    end CASE;

                    WHEN c_pfc_duty =>
                        r_si_u12_pfc_duty <= unsigned(r_si16_uart_rx_data(11 downto 0)); 
                    WHEN others =>
                    -- do nothing
                end CASE;

            end if;
        else
            r_si_u12_pfc_duty <= (others => '0');
            r_si_rstn <= '0';
        end if;
            r_si_uart_ready_event <= si_uart_ready_event;
            r_si16_uart_rx_data <= si16_uart_rx_data;
	end if;
    end process test_pfc_pwm;
end behavioral;
