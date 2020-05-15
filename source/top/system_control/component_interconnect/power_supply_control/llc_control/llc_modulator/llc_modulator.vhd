library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library common_library;
    use common_library.register_shifts_pkg.all;

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

    subtype uint12 is integer range 0 to 2**12-1;

    signal carrier: uint12;
    signal r_carrier: uint12;
    signal deadtime : uint12;
    signal r1_deadtime : uint12;
    signal s_pulse : std_logic;
    signal s1_pulse : std_logic;
    signal period : uint12;

    signal dly_cntr : uint12;

    signal dt_dly : uint12;

    type t_startup_states is (init, rampup, ready);
    signal st_startup : t_startup_states; 

    signal reset_dly_cntr : std_logic;
    signal dt_counter_ready : std_logic;

    signal tg_load_period : std_logic_vector(2 downto 0);
    signal dt_count : uint12;
    signal dt_count_down_from : uint12;


begin
------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------
    pri_gate_ctrl : process(llc_modulator_clocks.modulator_clock)
        variable sec_pwm_cntr : uint12;
        type t_dt_states is (active_pulse,deadtime);
        variable st_dt_states : t_dt_states;
    begin
	if rising_edge(llc_modulator_clocks.modulator_clock) then
        if not llc_modulator_data_in.llc_is_enabled then
            llc_modulator_FPGA_out.llc_gates <= (others => '0');
            dt_dly <= 0;
            st_dt_states := deadtime;
            s1_pulse <= s_pulse;

            s_pulse <= '0';
            dt_count_down_from <= 474-28;
            carrier <= 0;
            period <= 474;

        else

            shift_register(tg_load_period, llc_modulator_data_in.tg_trigger_llc_period);
            if tg_load_period(2) /= tg_load_period(1) then
                period <= llc_modulator_data_in.period;
                dt_count_down_from <= llc_modulator_data_in.deadtime;
            end if;

            carrier <= carrier + 1;
            if carrier > period then
               carrier <= 0;
               s_pulse <= NOT s_pulse;
            end if;

            s1_pulse <= s_pulse;

            CASE st_dt_states is
                WHEN active_pulse =>
                    -- gate on
                    dt_dly <= 0;
                    llc_modulator_FPGA_out.llc_gates.pri_high <= s1_pulse;
                    llc_modulator_FPGA_out.llc_gates.pri_low <= not s1_pulse;

                    if sec_pwm_cntr > 614 and sec_pwm_cntr < 10 then
                        llc_modulator_FPGA_out.llc_gates.sync1 <= '0';
                        llc_modulator_FPGA_out.llc_gates.sync2 <= '0';
                    else
                        sec_pwm_cntr := sec_pwm_cntr + 1;
                        llc_modulator_FPGA_out.llc_gates.sync1 <= s1_pulse;
                        llc_modulator_FPGA_out.llc_gates.sync2 <= not s1_pulse;
                    end if;

                    if s1_pulse /= s_pulse then
                        st_dt_states := deadtime;
                        dt_count <= dt_count_down_from;
                    end if;

                WHEN deadtime => 

                    if dt_count > 0 then
                        dt_count <= dt_count - 1;
                        st_dt_states := deadtime;
                    else
                        st_dt_states := active_pulse;
                    end if;


                    llc_modulator_FPGA_out.llc_gates <= (others => '0');
                    sec_pwm_cntr := 0;

            end CASE;
        end if;
	end if;
    end process pri_gate_ctrl;
------------------------------------------------------------------------------------------
end rtl;
