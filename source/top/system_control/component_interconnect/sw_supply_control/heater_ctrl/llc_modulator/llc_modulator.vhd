library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.llc_modulator_pkg.all;

entity llc_modulator is
    port (
        llc_modulator_clocks : in llc_modulator_clock_group;

        llc_modulator_FPGA_out : out llc_modulator_FPGA_output_group;

        llc_modulator_data_in : in llc_modulator_data_input_group;
        llc_modulator_data_out : out llc_modulator_data_output_group
    );
end entity llc_modulator;

architecture rtl of llc_modulator is

    signal u12_carrier: unsigned(11 downto 0);
    signal u12_deadtime : integer range 0 to 2**15-1;
    signal r1_u12_deadtime : integer range 0 to 2**15-1;
    signal s_pulse : std_logic;
    signal s1_pulse : std_logic;
    signal u12_period : unsigned(11 downto 0);

    signal dly_cntr : integer range 0 to 2**15-1;

    signal u12_dt_dly : unsigned(11 downto 0);
    signal u12_reset_carrier : unsigned(11 downto 0);

    type t_startup_states is (init, rampup, ready);
    signal st_startup : t_startup_states; 

    signal reset_dly_cntr : std_logic;
    signal r_po4_ht_pwm : hb_llc_pwm;
    signal dt_counter_ready : std_logic;
    signal start_dt_counter : std_logic;



begin
startup : process(llc_modulator_clocks.modulator_clock)

    begin
	if rising_edge(llc_modulator_clocks.modulator_clock) then
        r1_u12_deadtime <= u12_deadtime;
        if rstn = '0' then
            st_startup <= rampup;
            dly_cntr <= 0;
            u12_period <= to_unsigned(474,12); -- 290kHz initial frequency
            u12_deadtime <= 461; -- 883/2-13 cycle initial pulse width
        else
            CASE st_startup is
                WHEN rampup => 
                    -- ramp pulse from 100ns to normal by incrementing deadime
                    dly_cntr <= dly_cntr + 1;
                    if dly_cntr = to_unsigned(350,14) then 
                        reset_dly_cntr <= '1';
                    else
                        reset_dly_cntr <= '0';
                    end if;

                    if reset_dly_cntr = '1' then
                        dly_cntr <= 0;
                        u12_deadtime <= u12_deadtime - 1;
                    end if;


                    if r1_u12_deadtime = 64 then
                        st_startup <= ready;
                    else
                        st_startup <= rampup;
                    end if;


                WHEN ready =>

                    u12_period <= piu12_per_ctrl;

                WHEN others =>
                    st_startup <= rampup;
                    dly_cntr <= 0;
                    u12_period <= to_unsigned(474,12); -- 290kHz initial frequency
                    u12_deadtime <= 461; -- 883/2-13 cycle initial pulse width
            end CASE;

        end if;
	end if;
    end process startup;

    freq_synth : process(llc_modulator_clocks.modulator_clock)

    begin
	if rising_edge(llc_modulator_clocks.modulator_clock) then
        if rstn = '0' then
            s_pulse <= '0';
            u12_reset_carrier <= to_unsigned(474,12);
        else
            u12_reset_carrier <= u12_period;
            if u12_carrier > u12_reset_carrier then
               u12_carrier <= (others => '0');
               s_pulse <= NOT s_pulse;
            else
                u12_carrier <= u12_carrier + 1;
            end if;

        end if;
	end if;
    end process freq_synth;


    pri_gate_ctrl : process(llc_modulator_clocks.modulator_clock)
        variable sec_pwm_cntr : unsigned(11 downto 0);
        type t_dt_states is (active_pulse,deadtime);
        variable st_dt_states : t_dt_states;
    begin
	if rising_edge(llc_modulator_clocks.modulator_clock) then
            s1_pulse <= s_pulse;
        if rstn = '0' then
            r_po4_ht_pwm <= (others => '0');
            po4_ht_pwm <= (others => '0');
            sec_pwm_cntr := (others => '0');
            u12_dt_dly <= (others => '0');
            st_dt_states := deadtime;
            start_dt_counter <= '0';
        else
            po4_ht_pwm <= r_po4_ht_pwm;
            CASE st_dt_states is
                WHEN active_pulse =>
                    -- gate on
                    u12_dt_dly <= (others => '0');
                    r_po4_ht_pwm.pri_high <= s1_pulse;
                    r_po4_ht_pwm.pri_low <= not s1_pulse;

                    if sec_pwm_cntr > to_unsigned(614,12) then
                        r_po4_ht_pwm.sync1 <= '0';
                        r_po4_ht_pwm.sync2 <= '0';
                    else
                        sec_pwm_cntr := sec_pwm_cntr + 1;
                        r_po4_ht_pwm.sync1 <= s1_pulse;
                        r_po4_ht_pwm.sync2 <= not s1_pulse;
                    end if;

                    if s1_pulse = s_pulse then
                        st_dt_states := active_pulse;
                        start_dt_counter <= '0';
                    else
                        st_dt_states := deadtime;
                        start_dt_counter <= '1';
                    end if;
                WHEN deadtime => 
                    if dt_counter_ready = '1' then
                        st_dt_states := active_pulse;
                        start_dt_counter <= '0';
                    else
                        st_dt_states := deadtime;
                        start_dt_counter <= '1';
                    end if;
                    r_po4_ht_pwm <= (others => '0');
                    sec_pwm_cntr := (others => '0');
                WHEN others => 
                    r_po4_ht_pwm <= (others => '0');
                    po4_ht_pwm <= (others => '0');
                    sec_pwm_cntr := (others => '0');
                    u12_dt_dly <= (others => '0');
                    st_dt_states := active_pulse;
            end CASE;
        end if;
	end if;
    end process pri_gate_ctrl;

deadtime_counter : process(llc_modulator_clocks.modulator_clock)
    variable dt_count : integer range 0 to 2**15-1;
begin
    if rising_edge(llc_modulator_clocks.modulator_clock) then
        if rstn = '0' then
        -- reset state
            dt_count := 0;
            dt_counter_ready <= '0';
        else
            if dt_count < r1_u12_deadtime AND start_dt_counter = '1' then
                dt_count := dt_count + 1;
                dt_counter_ready <= '0';
            else
                dt_count := 0;
                dt_counter_ready <= '1';
            end if;
        end if; -- rstn
    end if; --rising_edge
end process deadtime_counter;	



end rtl;
