
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
	use work.sys_ctrl_pkg.all;
	use work.ad_bus_pkg.all;

entity dc_link_ctrl is
    port(
	    core_clk : in std_logic;
	    modulator_clk : in std_logic;

    -- pfc pwm
	    po2_pfc_pwm : out std_logic_vector(1 downto 0);

	    si_std16_ada_bus : in std_logic_vector(16 downto 0);
	    si_std16_adb_bus : in std_logic_vector(16 downto 0);

	    so_std18_test_data : out std_logic_vector(17 downto 0);

	    ui12_carrier : in unsigned(11 downto 0);

	    si_tcmd_system_cmd : in tcmd_system_commands
	);
    end dc_link_ctrl;

architecture behavioral of dc_link_ctrl is
    
component seq_pi_control is 
	generic(
		    gen_pi_sat_high : integer; 
		    gen_pi_sat_low : integer;
		    gen_left_shift_p_gain : integer;
		    gen_offset_sign18 : integer
		);
    port(
	    pi_clk : in std_logic;
	    
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

signal carrier : unsigned(11 downto 0);
signal route_test_pwm : std_logic;
signal r_si_sign18_meas : signed(17 downto 0);
signal r_start_pi : std_logic;
signal r_so_pi_busy : std_logic;
signal r_so_sign18_pi_out : signed(17 downto 0);
signal r_so_pi_out_rdy : std_logic;

begin

voltage_ctrl : seq_pi_control
    generic map(
		    gen_pi_sat_high =>189,
		    gen_pi_sat_low => 10,
		    gen_offset_sign18 => 0,
		    gen_left_shift_p_gain => 0
		)
    port map(
	    pi_clk => core_clk,

	    
	    si_start => r_start_pi,
	    so_pi_busy => r_so_pi_busy,
	    so_pi_out_rdy => r_so_pi_out_rdy,

	    so_sign18_pi_out =>r_so_sign18_pi_out,

	    si_sign18_ref => 18d"4443", --150v reference
	    si_sign18_meas =>r_si_sign18_meas,

	    si_sign18_p_gain => 18d"25",
	    si_sign18_i_gain => 18d"5"
	);
    process(core_clk)
	variable jee : unsigned(17 downto 0);

    begin
	if rising_edge(modulator_clk) then
	    if r_so_pi_out_rdy = '1' then
		 jee := unsigned(r_so_sign18_pi_out);
		 so_std18_test_data(15 downto 0) <= std_logic_vector(jee(15 downto 0));
		 so_std18_test_data(17 downto 16) <= 2d"2";
	     else
		 so_std18_test_data <= (others=> '0');
	     end if;

	end if;
    end process;


    start_ctrl : process(modulator_clk) is
	type t_start_States is (idle, start_pi,pi_busy);
	variable start_states : t_start_states;


    begin
	if rising_edge(modulator_clk) then
	    CASE start_states is 
		    WHEN idle => 
			if si_std16_adb_bus(16 downto 14) = 3d"4" then  
				r_si_sign18_meas <= signed(shift_left(resize(unsigned(si_std16_adb_bus(13 downto 0)),18),4));
				r_start_pi <= '0';
				start_states := start_pi;
			else
				start_states := idle;
				r_start_pi <= '0';
			end if;
		    WHEN start_pi =>
			if r_so_pi_busy = '0' then
				r_start_pi <= '1';
				start_states := pi_busy;
			else
				start_states := start_pi;
				r_start_pi <= '0';
			end if;
		    WHEN pi_busy =>
			if r_so_pi_busy = '1' then
				r_start_pi <= '0';
				start_states := idle;
			else
				start_states := pi_busy;
				r_start_pi <= '1';
			end if;
		    WHEN others => 
			start_states := idle;
			r_start_pi <= '0';
	    end CASE;
	end if;

    end process start_ctrl;


test_pwm : process(modulator_clk)
	variable v_pwm : std_logic;
    begin
	if rising_edge(modulator_clk) then

	    if ui12_carrier <= unsigned(r_so_sign18_pi_out(11 downto 0)) then
		    v_pwm := '1';
	    else
		    v_pwm := '0';
	    end if;

	end if;
	route_test_pwm <= v_pwm;
end process test_pwm;

po2_pfc_pwm <= 2d"0";

end behavioral;
