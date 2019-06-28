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
	    si16_ext_ad1_data : in std_logic_vector(15 downto 0);
	    so_std18_test_data : out std_logic_vector(17 downto 0);

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
 
signal r_si_rstn : std_logic;
signal r_piu12_per_ctrl  : unsigned(11 downto 0); 

begin

llc_modulator : freq_modulator
    port map(modulator_clk, modulator_clk, r_si_rstn, r_piu12_per_ctrl, po4_ht_pwm);


test_heater_pwm : process(core_clk)
    begin
	if rising_edge(core_clk) then
        if si_rstn = '0' then
            r_si_rstn <= '0';
            -- start frequency is 270kHz
            r_piu12_per_ctrl <= 12d"948";
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
