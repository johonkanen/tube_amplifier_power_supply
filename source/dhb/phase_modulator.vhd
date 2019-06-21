library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
	use work.dhb_pkg.all;
	use work.top_pkg.all;

entity phase_modulator is
	generic(
	-- 223ns deadtime as default
			g_u8_deadtime : unsigned(7 downto 0)
		);
    port(
	    modulator_clk : in std_logic;

		ri_dhb_ctrl : in rec_dhb_input;
        
        po4_dhb_pwm : out dhb_pwm

	);
end phase_modulator;

architecture rtl of phase_modulator is

	signal s13_dhb_counter : signed(11 downto 0);
    signal s_pri_pulse : std_logic;
    signal s_sec_pulse : std_logic;
	signal u12_phase_delay : unsigned(11 downto 0) := (others => '0');

begin

freq_generation : process(modulator_clk)
	type t_freq_counter_states is (up, down);
	variable st_freq_counter_states : t_freq_counter_states;
	type t_count_dir is (up,down);
	variable st_count_dir : t_count_dir;
	
begin
	if rising_edge(modulator_clk) then
		if ri_dhb_ctrl.rstn = '0' then
			--do nothing
			s13_dhb_counter <= signed(ri_dhb_ctrl.u12_dhb_half_period);
			st_count_dir := up;
		else
			CASE st_count_dir is 
				WHEN up =>
					s13_dhb_counter <= s13_dhb_counter + 1;
					if s13_dhb_counter < signed(ri_dhb_ctrl.u12_dhb_half_period) then
						st_count_dir := up;
					else
						st_count_dir := down;
					end if;
				WHEN down =>
					s13_dhb_counter <= s13_dhb_counter - 1;
					if s13_dhb_counter <= -signed(ri_dhb_ctrl.u12_dhb_half_period) then
						st_count_dir := up;
					else
						st_count_dir := down;
					end if;
			END CASE;
		end if;
	end if; --rising_edge
end process freq_generation;	

pri_pulse_generation : process(modulator_clk)
begin
	if rising_edge(modulator_clk) then
		if ri_dhb_ctrl.rstn = '0' then
			s_pri_pulse <= '0';
		else
			if s13_dhb_counter < 12d"0" then
				s_pri_pulse <= '1';
			else
				s_pri_pulse <= '0';
			end if;
		end if; --ri_dhb_ctrl.rstn = '0'
	end if; --rising_edge
end process pri_pulse_generation;	

sec_pulse_generation : process(modulator_clk)
begin
	if rising_edge(modulator_clk) then
		CASE s_sec_pulse is 
			WHEN '1' =>
				if s_pri_pulse = '0' then
					u12_phase_delay <= u12_phase_delay + 1;
				else
					u12_phase_delay <= (others => '0');
				end if;
				if u12_phase_delay = ri_dhb_ctrl.s16_phase(11 downto 0) AND u12_phase_delay < 12d"32" then
					s_sec_pulse <= '0';
				else
					s_sec_pulse <= '1';
				end if;
			WHEN '0' =>
				if s_pri_pulse = '1' then
					u12_phase_delay <= u12_phase_delay + 1;
				else
					u12_phase_delay <= (others => '0');
				end if;

                if u12_phase_delay = ri_dhb_ctrl.s16_phase(11 downto 0) AND u12_phase_delay < 12d"32" then
					s_sec_pulse <= '1';
				else
					s_sec_pulse <= '0';
				end if;
			WHEN others =>
				s_sec_pulse <= '1';
		END CASE;
	end if; --rising_edge
end process sec_pulse_generation;	

pri_dt_generation : process(modulator_clk)
	type t_dt_states is (pos,dt1,neg,dt2);
	variable st_dt_states : t_dt_states;
	variable dt_counter : unsigned(7 downto 0);
begin
	if rising_edge(modulator_clk) then
		if ri_dhb_ctrl.rstn = '0' then
			st_dt_states := pos;
            po4_dhb_pwm.pri_high <= '0';
            po4_dhb_pwm.pri_low <= '0';
		else
			CASE st_dt_states is 
				WHEN pos=> 
					dt_counter := (others => '0');
                    po4_dhb_pwm.pri_high <= '1';
                    po4_dhb_pwm.pri_low <= '0';
					if s_pri_pulse = '0' then
						st_dt_states := dt1;
					else
						st_dt_states := pos;
					end if;
				WHEN dt1 =>
                    po4_dhb_pwm.pri_high <= '0';
                    po4_dhb_pwm.pri_low <= '0';
					if dt_counter = g_u8_deadtime then
						st_dt_states := neg;
					else 
						st_dt_states := dt1;
						dt_counter := dt_counter + 1;
					end if;
				WHEN neg=>
                    po4_dhb_pwm.pri_high <= '0';
                    po4_dhb_pwm.pri_low <= '1';
					dt_counter := (others => '0');
					if s_pri_pulse = '1' then
						st_dt_states := dt2;
					else
						st_dt_states := neg;
					end if;
				WHEN dt2 =>
                    po4_dhb_pwm.pri_high <= '0';
                    po4_dhb_pwm.pri_low <= '0';
					dt_counter := dt_counter + 1;
					if dt_counter = g_u8_deadtime then
						st_dt_states := pos;
					else 
						st_dt_states := dt2;
					end if;
			END CASE;
		end if;
	end if; --rising_edge
end process pri_dt_generation;	

sec_dt_generation : process(modulator_clk)
	type t_dt_states is (pos,dt1,neg,dt2);
	variable st_dt_states : t_dt_states;
	variable dt_counter : unsigned(7 downto 0);
begin
	if rising_edge(modulator_clk) then
		if ri_dhb_ctrl.rstn = '0' then
			st_dt_states := pos;
            po4_dhb_pwm.sec_high <= '0';
            po4_dhb_pwm.sec_low <= '0';
		else
			CASE st_dt_states is 
				WHEN pos=> 
					dt_counter := (others => '0');
					po4_dhb_pwm.sec_high <= '1';
					po4_dhb_pwm.sec_low <= '0';
					if s_sec_pulse = '0' then
						st_dt_states := dt1;
					else
						st_dt_states := pos;
					end if;
				WHEN dt1 =>
					po4_dhb_pwm.sec_high <= '0';
					po4_dhb_pwm.sec_low <= '0';
					if dt_counter = g_u8_deadtime then
						st_dt_states := neg;
					else 
						st_dt_states := dt1;
						dt_counter := dt_counter + 1;
					end if;
				WHEN neg=>
					po4_dhb_pwm.sec_high <= '0';
					po4_dhb_pwm.sec_low <= '1';
					dt_counter := (others => '0');
					if s_sec_pulse = '1' then
						st_dt_states := dt2;
					else
						st_dt_states := neg;
					end if;
				WHEN dt2 =>
					po4_dhb_pwm.sec_high <= '0';
					po4_dhb_pwm.sec_low <= '0';
					dt_counter := dt_counter + 1;
					if dt_counter = g_u8_deadtime then
						st_dt_states := pos;
					else 
						st_dt_states := dt2;
					end if;
			END CASE;
		end if;
	end if; --rising_edge
end process sec_dt_generation;	

end rtl;
