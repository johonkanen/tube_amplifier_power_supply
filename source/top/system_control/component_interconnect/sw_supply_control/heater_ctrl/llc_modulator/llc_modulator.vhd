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

    signal carrier: integer;
    signal deadtime : integer range 0 to 2**15-1;
    signal r1_deadtime : integer range 0 to 2**15-1;
    signal s_pulse : std_logic;
    signal s1_pulse : std_logic;
    signal period : integer;

    signal dly_cntr : integer range 0 to 2**15-1;

    signal dt_dly : integer;
    signal reset_carrier : integer;

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
        r1_deadtime <= deadtime;
        if rstn = '0' then
            st_startup <= rampup;
            dly_cntr <= 0;
            period <= 474; -- 290kHz initial frequency
            deadtime <= 461; -- 883/2-13 cycle initial pulse width
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
                        deadtime <= deadtime - 1;
                    end if;


                    if r1_deadtime = 64 then
                        st_startup <= ready;
                    else
                        st_startup <= rampup;
                    end if;


                WHEN ready =>

                    period <= llc_modulator_data_in.period;

                WHEN others =>
                    st_startup <= rampup;
                    dly_cntr <= 0;
                    period <= 474; -- 290kHz initial frequency
                    deadtime <= 461; -- 883/2-13 cycle initial pulse width
            end CASE;

        end if;
	end if;
    end process startup;

    freq_synth : process(llc_modulator_clocks.modulator_clock)

    begin
	if rising_edge(llc_modulator_clocks.modulator_clock) then
        if rstn = '0' then
            s_pulse <= '0';
            reset_carrier <= 474;
        else
            reset_carrier <= period;
            if carrier > reset_carrier then
               carrier <= 0;
               s_pulse <= NOT s_pulse;
            else
                carrier <= carrier + 1;
            end if;

        end if;
	end if;
    end process freq_synth;


    pri_gate_ctrl : process(llc_modulator_clocks.modulator_clock)
        variable sec_pwm_cntr : integer;
        type t_dt_states is (active_pulse,deadtime);
        variable st_dt_states : t_dt_states;
    begin
	if rising_edge(llc_modulator_clocks.modulator_clock) then
            s1_pulse <= s_pulse;
        if rstn = '0' then
            llc_modulator_FPGA_out.llc_gates <= (others => '0');
            dt_dly <= 0;
            st_dt_states := deadtime;
            start_dt_counter <= '0';
        else
            CASE st_dt_states is
                WHEN active_pulse =>
                    -- gate on
                    dt_dly <= 0;
                    llc_modulator_FPGA_out.llc_gates.pri_high <= s1_pulse;
                    llc_modulator_FPGA_out.llc_gates.pri_low <= not s1_pulse;

                    if sec_pwm_cntr > 614 then
                        llc_modulator_FPGA_out.llc_gates.sync1 <= '0';
                        llc_modulator_FPGA_out.llc_gates.sync2 <= '0';
                    else
                        sec_pwm_cntr := sec_pwm_cntr + 1;
                        llc_modulator_FPGA_out.llc_gates.sync1 <= s1_pulse;
                        llc_modulator_FPGA_out.llc_gates.sync2 <= not s1_pulse;
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
                    llc_modulator_FPGA_out.llc_gates <= (others => '0');
                    sec_pwm_cntr := (others => '0');
                WHEN others => 
                    llc_modulator_FPGA_out.llc_gates <= (others => '0');
                    sec_pwm_cntr := 0;
                    dt_dly <= 0;
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
            if dt_count < r1_deadtime AND start_dt_counter = '1' then
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
