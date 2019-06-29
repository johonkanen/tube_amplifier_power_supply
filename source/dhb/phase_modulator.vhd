library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
	use work.dhb_pkg.all;

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

	signal s13_dhb_counter : signed(15 downto 0);
    signal s_pri_pulse : std_logic;
    signal s_sec_pulse : std_logic;
	signal u12_phase_delay : unsigned(15 downto 0) := (others => '0');
    signal u12_pri_carrier : unsigned(15 downto 0);
    signal u12_sec_carrier : unsigned(15 downto 0);
    signal u16_master_carrier : unsigned(15 downto 0);
    signal u12_phase : unsigned(15 downto 0);
    signal s16_pri_phase : unsigned(15 downto 0);
    signal s16_sec_phase : unsigned(15 downto 0);

begin

carrier_gen : process(modulator_clk)
    
begin
    if rising_edge(modulator_clk) then
        if ri_dhb_ctrl.rstn = '0' then
            u12_pri_carrier <= (others => '0'); 
            u12_sec_carrier <= (others => '0'); 
            u16_master_carrier <= (others => '0');
            s16_pri_phase <= (others => '0');
            s16_sec_phase <= (others => '0');
        else

            if ri_dhb_ctrl.s16_phase > 189 then
                s16_pri_phase <= ri_dhb_ctrl.s16_phase - 189;
                s16_sec_phase <= (others => '0');
            else
                s16_pri_phase <= (others => '0');
                s16_sec_phase <= ri_dhb_ctrl.s16_phase;
            end if;

            if u16_master_carrier > 16d"1896" then
                u16_master_carrier <= (others => '0');
            else
                u16_master_carrier<= u16_master_carrier+ 1;
            end if;

            if u12_pri_carrier > 16d"1896" OR u16_master_carrier = s16_pri_phase then
                u12_pri_carrier <= (others => '0');
            else
                u12_pri_carrier <= u12_pri_carrier + 1;
            end if;

            if u12_sec_carrier > 16d"1896" OR u16_master_carrier = s16_sec_phase then
                u12_sec_carrier <= (others => '0');
            else
                u12_sec_carrier <= u12_sec_carrier + 1;
            end if;

            if u12_pri_carrier > 16d"947" then
                s_pri_pulse <= '0';
            else
                s_pri_pulse <= '1';
            end if;
            
            if u12_sec_carrier > 16d"947" then
                s_sec_pulse <= '0';
            else
                s_sec_pulse <= '1';
            end if;
        end if;
    end if; --rising_edge
end process carrier_gen;	

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
                    po4_dhb_pwm.pri_high <= '0';
                    po4_dhb_pwm.pri_low <= '1';
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
                    po4_dhb_pwm.pri_high <= '1';
                    po4_dhb_pwm.pri_low <= '0';
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
					po4_dhb_pwm.sec_high <= '0';
					po4_dhb_pwm.sec_low <= '1';
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
					po4_dhb_pwm.sec_high <= '1';
					po4_dhb_pwm.sec_low <= '0';
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
