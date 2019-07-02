LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 

library work;
	use work.dhb_pkg.all;

ENTITY tb_phase_modulator  IS 
END ; 
 
ARCHITECTURE testi OF tb_phase_modulator IS

	signal jihuu : rec_dhb_input;
	signal modulator_clk : std_logic; 
	signal po2_DHB_pri_pwm : std_logic_vector(1 downto 0);
	signal po2_DHB_sec_pwm : std_logic_vector(1 downto 0);
	signal si_rst_n : std_logic; 
	signal jee_testi : std_logic;

    signal ri_dhb_ctrl : rec_dhb_input;
    signal po4_dhb_pwm : dhb_pwm;

	component phase_modulator is
		generic(
		-- 223ns deadtime as default
				g_u8_deadtime : unsigned(7 downto 0)
			);
		port(
			modulator_clk : in std_logic;
			ri_dhb_ctrl : in rec_dhb_input;
            po4_dhb_pwm : out dhb_pwm
		);
	end component;
begin

DUT : phase_modulator
generic map(to_unsigned(57,8))
		port map(
            modulator_clk,
            ri_dhb_ctrl,
            po4_dhb_pwm);

ri_dhb_ctrl.s16_phase <= 16d"120";
ri_dhb_ctrl.u12_dhb_half_period <= 12d"948";
ri_dhb_ctrl.rstn <= si_rst_n;

po2_DHB_pri_pwm <= po4_dhb_pwm.pri_high & po4_dhb_pwm.pri_low;
po2_DHB_sec_pwm <= po4_dhb_pwm.sec_high & po4_dhb_pwm.sec_low;

-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 1 us, Period = 4 ns
  Process
	Begin
	 modulator_clk  <= '0'  ;
	wait for 3.962 ns ;
-- 3.962 ns, single loop till start period.
	for Z in 1 to 2500
	loop
	    modulator_clk  <= '1'  ;
	   wait for 3.962 ns ;
	    modulator_clk  <= '0'  ;
	   wait for 3.962 ns ;
-- 98 ns, repeat pattern in loop.
	end  loop;
	 modulator_clk  <= '1'  ;
	wait for 3.962 ns ;
-- dumped values till 100 ns
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  Process
	Begin
		si_rst_n<= '0'  ;
		wait for 100 ns ;
		si_rst_n<= '1'  ;
	wait;
 End Process;


END;
