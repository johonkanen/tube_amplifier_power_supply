library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    use ieee.numeric_std.all;

library work;
	use work.sys_ctrl_pkg.all;

entity pi_ctrl_pipelined is 
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
end pi_ctrl_pipelined;


architecture rtl of pi_ctrl_pipelined is

    type t_pi_ctrl_states is (init,
				idle,
				pi_out,
				integrate,
				int_calc,
				sat_max,
				sat_min,
				done);
    
    component sign_18x18_mult_dsp IS
    PORT
	(
	    dataa		: IN STD_LOGIC_VECTOR (17 DOWNTO 0);
	    datab		: IN STD_LOGIC_VECTOR (17 DOWNTO 0);
	    result		: OUT STD_LOGIC_VECTOR (35 DOWNTO 0)
	);
    END component;

    signal r_sign18_mult_a : signed(17 downto 0);
    signal r_sign18_mult_b : signed(17 downto 0);
    signal hw_multiplier_output : signed(35 downto 0);

    signal r_sign18_integrator : signed(17 downto 0);
    signal r_so_sign18_pi_out : signed(17 downto 0);

    signal s_sign18_multiplier : signed(17 downto 0);

begin

   PI_ctrl : process(pi_clk)
	variable ss_pi_states : t_pi_ctrl_states;
	variable v_sign21_integrator : signed(20 downto 0);
	variable v_so_sign18_pi_out : signed(17 downto 0);
	variable v_sign18_error : signed(17 downto 0);
	variable v_sign18_mult : signed(17 downto 0);
	variable v_pi_out : signed(17 downto 0);
	variable v_si_sign18_ref : signed(17 downto 0);
	variable v_si_sign18_meas : signed(17 downto 0);
	variable v_sign36_mult_res : signed(35 downto 0);
	variable v_sign36_kp_mult_res : signed(35 downto 0);

    begin
	if rising_edge(pi_clk) then
	    CASE ss_pi_states is 
		WHEN init =>
		    so_sign18_pi_out <= (others=>'0');
		    ss_pi_states := idle;
		WHEN idle =>
		    so_pi_busy <= '0';
		    so_pi_out_rdy <= '0'; 	
		    
		    if si_start = '1' then
				ss_pi_states := pi_out;
				v_sign18_error := v_si_sign18_ref - v_si_sign18_meas + to_signed(gen_offset_sign18,18);
				hw_multiplier_output <= v_sign18_error * si_sign18_p_gain;
		    else
				ss_pi_states := idle;
		    end if;

		WHEN pi_out =>
		    -- route multiplier gains to integrator
		    hw_multiplier_output <= v_sign18_error * si_sign18_i_gain;

		    v_sign36_mult_res := shift_left(signed(hw_multiplier_output),gen_left_shift_p_gain);	
		    v_so_sign18_pi_out := v_sign36_mult_res(34 downto 17) + r_sign18_integrator;


		    if v_so_sign18_pi_out > to_signed(gen_pi_sat_high ,18) then
				r_so_sign18_pi_out <=  to_signed(gen_pi_sat_high ,18);
				ss_pi_states := sat_max;

		    elsif v_so_sign18_pi_out < to_signed(gen_pi_sat_low ,18) then
				r_so_sign18_pi_out <=  to_signed(gen_pi_sat_low ,18);
				ss_pi_states := sat_min;

		    else
				r_so_sign18_pi_out <= v_so_sign18_pi_out;
				ss_pi_states := integrate;
		    end if;	
		    so_pi_busy <= '1';
		    so_pi_out_rdy <= '1'; 	
		WHEN sat_max => 
		    r_sign18_integrator <= to_signed(gen_pi_sat_high,18) - signed(hw_multiplier_output(34 downto 17));
		    ss_pi_states := idle;
		    so_pi_busy <= '1';

		WHEN sat_min => 
		    r_sign18_integrator <= to_signed(gen_pi_sat_low ,18) - signed(hw_multiplier_output(34 downto 17));
		    ss_pi_states := idle;
		    so_pi_busy <= '1';

		WHEN integrate => 
		    r_sign18_integrator <= r_sign18_integrator + signed(hw_multiplier_output(34 downto 17));
		    ss_pi_states := idle;
		    so_pi_busy <= '1';

		WHEN others =>
		    ss_pi_states := init;
	    end CASE;
	end if;
		v_si_sign18_ref := si_sign18_ref;
		v_si_sign18_meas := si_sign18_meas;
		so_sign18_pi_out <= r_so_sign18_pi_out;

	end process PI_ctrl;
end rtl;

