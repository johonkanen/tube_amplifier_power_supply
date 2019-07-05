library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
	use work.sys_ctrl_pkg.all;
	use work.ad_bus_pkg.all;
	use work.llc_pkg.all;

-- pi out function in matlab simulation 853+1422+y*1422; y = [-1, 1]

-- 1422 => 180kHz, 
-- 853 => 300kHz
-- pi out = [0, 569]
-- freq function 853+piout
-- during startup, 300kHz, duty .10-> .50 10ms slide,
-- 569 clk period, 284 clk for .5 duty -> 9014 delay per clk
entity freq_modulator is
    port(
	    modulator_clk : in std_logic;
	    dsp_clk : in std_logic;
	    rstn : in std_logic;

	    piu12_per_ctrl : in unsigned(11 downto 0);
        po4_ht_pwm : out hb_llc_pwm

	);
end freq_modulator;

architecture rtl of freq_modulator is


    signal u12_carrier: unsigned(11 downto 0);
    signal u12_deadtime : unsigned(11 downto 0);
    signal r1_u12_deadtime : unsigned(11 downto 0);
    signal s_pulse : std_logic;
    signal s1_pulse : std_logic;
    signal u12_period : unsigned(11 downto 0);

    signal r_po2_ht_pri_pwm : std_logic_vector(1 downto 0);
    signal r_po2_ht_sec_pwm : std_logic_vector(1 downto 0);
    signal dly_cntr : unsigned(13 downto 0);
    signal reg_u12_carrier : unsigned(11 downto 0);
    signal u12_car_per_2 : unsigned(11 downto 0);

    signal u12_dt_dly : unsigned(11 downto 0);
    signal jipijee : unsigned(11 downto 0);
    type st_deadtime is (zero, pos,dt1,neg,dt2);
    signal dt_states : st_deadtime;

    type t_startup_states is (init, rampup, ready);
    signal st_startup : t_startup_states; 

    signal reset_dly_cntr : std_logic;
begin

    startup : process(modulator_clk)

    begin
	if rising_edge(modulator_clk) then
        r1_u12_deadtime <= u12_deadtime;
        if rstn = '0' then
            st_startup <= rampup;
            dly_cntr <= 14d"0";
            u12_period <= 12d"948"; -- 290kHz initial frequency
            u12_deadtime <= 12d"461"; -- 883/2-13 cycle initial pulse width
        else
            CASE st_startup is
                WHEN rampup => 
                    -- ramp pulse from 100ns to normal by incrementing deadime
                    dly_cntr <= dly_cntr + 1;
                    if dly_cntr = 14d"350" then 
                        reset_dly_cntr <= '1';
                    else
                        reset_dly_cntr <= '0';
                    end if;

                    if reset_dly_cntr = '1' then
                        dly_cntr <= 14d"0";
                        u12_deadtime <= u12_deadtime - 1;
                    end if;


                    if r1_u12_deadtime = 64 then
                        st_startup <= ready;
                    else
                        st_startup <= rampup;
                    end if;


                WHEN ready =>

                    u12_period <= piu12_per_ctrl;

                    if rstn = '0' then
                        st_startup <= init;
                    else
                        st_startup <= ready;
                    end if;

                WHEN others =>
                    st_startup <= rampup;
                    dly_cntr <= 14d"0";
                    u12_period <= 12d"948"; -- 290kHz initial frequency
                    u12_deadtime <= 12d"461"; -- 883/2-13 cycle initial pulse width
            end CASE;

        end if;
	end if;
    end process startup;

    freq_synth : process(modulator_clk)

    begin
	if rising_edge(modulator_clk) then
	    if u12_carrier > jipijee then
			u12_carrier <= 12d"0";
	    else
			u12_carrier <= u12_carrier + 1;
	    end if;

	    if u12_carrier = 12d"0" then
			 jipijee <= u12_period;
	    end if;
	end if;
    end process freq_synth;


    pulse_ctrl : process(modulator_clk)
    begin
        if rising_edge(modulator_clk) then

            if reg_u12_carrier > u12_car_per_2 then
                s_pulse <= '1';
            else
                s_pulse <= '0';	
            end if;
                reg_u12_carrier <= u12_carrier;
                u12_car_per_2 <= shift_right(u12_period,1);
        end if;
    end process pulse_ctrl;

    pri_gate_ctrl : process(modulator_clk)
        variable sec_pwm_cntr : unsigned(11 downto 0);
        type t_dt_states is (active_pulse,deadtime);
        variable st_dt_states : t_dt_states;
    begin
	if rising_edge(modulator_clk) then
            s1_pulse <= s_pulse;
        if rstn = '0' then
            po4_ht_pwm <= (others => '0');
            sec_pwm_cntr := (others => '0');
            u12_dt_dly <= 12d"0";
        else
            CASE st_dt_states is
                WHEN active_pulse =>
                    -- gate on
                     u12_dt_dly <= 12d"0";
                    po4_ht_pwm.pri_high <= s_pulse;
                    po4_ht_pwm.pri_low <= not s_pulse;

                    if sec_pwm_cntr > 12d"614" then
                        po4_ht_pwm.sync1 <= '0';
                        po4_ht_pwm.sync2 <= '0';
                    else
                        sec_pwm_cntr := sec_pwm_cntr + 1;
                        po4_ht_pwm.sync1 <= s_pulse;
                        po4_ht_pwm.sync2 <= not s_pulse;
                    end if;

                    if s1_pulse = s_pulse then
                        st_dt_states := active_pulse;
                    else
                        st_dt_states := deadtime;
                    end if;
                WHEN deadtime => 
                    po4_ht_pwm <= (others => '0');
                    sec_pwm_cntr := (others => '0');
                    if u12_dt_dly < r1_u12_deadtime then
                        u12_dt_dly <= u12_dt_dly + 1;
                        dt_states <= dt1;
                    else
                        u12_dt_dly <= 12d"0";
                        dt_states <= neg;
                    end if;
                WHEN others => 
                    po4_ht_pwm <= (others => '0');
                    sec_pwm_cntr := (others => '0');
                    u12_dt_dly <= 12d"0";
                    dt_states <= pos;
            end CASE;
        end if;
	end if;
    end process pri_gate_ctrl;
    

end rtl;
