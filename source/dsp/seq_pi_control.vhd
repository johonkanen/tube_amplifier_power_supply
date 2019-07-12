library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    use ieee.numeric_std.all;

library work;
    use work.vendor_specifics_pkg.all;

entity seq_pi_control is 
	generic(
				gen_pi_sat_high : integer; 
				gen_pi_sat_low : integer;
				gen_left_shift_p_gain : integer;
				gen_offset_sign18 : integer
			);
    port(
	    pi_clk : in std_logic;
        si_rstn : in std_logic;
	    
	    si_start : in std_logic;
	    so_pi_busy : out std_logic;
	    so_pi_out_rdy : out std_logic;

	    so_sign18_pi_out : out signed(17 downto 0);

	    si_sign18_ref : in signed(17 downto 0);
	    si_sign18_meas : in signed(17 downto 0);

	    si_sign18_p_gain : in signed(17 downto 0);
	    si_sign18_i_gain : in signed(17 downto 0)
	);
end seq_pi_control;


architecture rtl of seq_pi_control is

    type t_pi_ctrl_states is (idle, wait_mult, error_calc,out_calc,int_calc,done);
    
    component combi_mult_18x18 is 
    port (
    CLK : in std_logic;
    A : in std_logic_vector(17 downto 0);
    B : in std_logic_vector(17 downto 0);
    P : out std_logic_vector(35 downto 0)
    );
    end component;

    signal r_mult_ak : signed(17 downto 0);
    signal r_sign36_kp_mult_res : std_logic_vector(35 downto 0);

    signal r_mult_ai : signed(17 downto 0);
    signal r_sign36_ki_mult_res : std_logic_vector(35 downto 0);

    signal r_sign18_integrator : signed(17 downto 0);
begin

kp_mult : combi_mult_18x18
    PORT map
	    (
            pi_clk,
            std_logic_vector(r_mult_ak),
            std_logic_vector(si_sign18_p_gain),
            r_sign36_kp_mult_res
	    );

ki_mult : combi_mult_18x18
    PORT map
	    (
            pi_clk,
            std_logic_vector(r_mult_ai),
            std_logic_vector(si_sign18_i_gain),
            r_sign36_ki_mult_res
	    );

   PI_ctrl : process(pi_clk, si_sign18_ref, si_sign18_meas, r_sign36_kp_mult_res)
	variable ss_pi_states : t_pi_ctrl_states;
	variable v_sign21_integrator : signed(20 downto 0);
	variable v_so_sign18_pi_out : signed(17 downto 0);
	variable v_sign18_error : signed(17 downto 0);
	variable v_sign18_mult : signed(17 downto 0);
	variable v_pi_out : signed(17 downto 0);
	variable v_si_sign18_ref : signed(17 downto 0);
	variable v_si_sign18_meas : signed(17 downto 0);
	variable v_r_std36_kp_mult_res : std_logic_vector(35 downto 0);
	variable v_sign36_kp_mult_res : signed(35 downto 0);

    begin
	if rising_edge(pi_clk) then
        if si_rstn = '0' then
		    so_sign18_pi_out <= (others=>'0');
		    ss_pi_states := idle;
            so_pi_out_rdy <= '0'; 	
            so_pi_busy <= '0';
            /* v_so_sign18_pi_out := (others => '0'); */

        else
            CASE ss_pi_states is 
            WHEN idle =>
                so_pi_out_rdy <= '0'; 	
                
                if si_start = '1' then
                    ss_pi_states := wait_mult;
                    v_sign18_error := v_si_sign18_ref - v_si_sign18_meas + to_signed(gen_offset_sign18,18);
                    r_mult_ak <= v_sign18_error;
                    r_mult_ai <= v_sign18_error;
                    so_pi_busy <= '1';
                else
                    ss_pi_states := idle;
                    so_pi_busy <= '0';
                end if;
            WHEN wait_mult => 
                so_pi_busy <= '1';
                ss_pi_states := error_calc;
                so_pi_out_rdy <= '0'; 	

            WHEN error_calc =>

                v_sign36_kp_mult_res := shift_left(signed(v_r_std36_kp_mult_res),gen_left_shift_p_gain);	
                v_so_sign18_pi_out := v_sign36_kp_mult_res(32 downto 15) + r_sign18_integrator;

               
                so_pi_busy <= '1';
                so_pi_out_rdy <= '0'; 	
                ss_pi_states := done;

            WHEN done =>
                if v_so_sign18_pi_out > to_signed(gen_pi_sat_high ,18) then
                    so_sign18_pi_out <=  to_signed(gen_pi_sat_high ,18);
                    r_sign18_integrator <= to_signed(gen_pi_sat_high,18) - signed(v_sign36_kp_mult_res(32 downto 15));

                elsif v_so_sign18_pi_out < to_signed(gen_pi_sat_low ,18) then
                    so_sign18_pi_out <=  to_signed(gen_pi_sat_low ,18);
                    r_sign18_integrator <= to_signed(gen_pi_sat_low ,18) - signed(v_sign36_kp_mult_res(32 downto 15));

                else
                    so_sign18_pi_out <=v_so_sign18_pi_out;
                    r_sign18_integrator <= r_sign18_integrator + signed(r_sign36_ki_mult_res(32 downto 15));
                end if;	
                so_pi_out_rdy <= '1'; 	
                so_pi_busy <= '1';
                ss_pi_states := idle;

            WHEN others =>
                ss_pi_states := idle;
            end CASE;
        end if;
	end if;
		v_si_sign18_ref := si_sign18_ref;
		v_si_sign18_meas := si_sign18_meas;
		v_r_std36_kp_mult_res := r_sign36_kp_mult_res;
	end process PI_ctrl;
end rtl;
