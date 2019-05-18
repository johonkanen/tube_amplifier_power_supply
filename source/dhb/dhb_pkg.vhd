library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	
package dhb_pkg is

	type rec_dhb_input is record
		s16_phase : unsigned(15 downto 0);
		u12_dhb_half_period : unsigned(11 downto 0);
		rstn : std_logic;
	end record;

	component phase_modulator is
		generic(
		-- 223ns deadtime as default
				g_u8_deadtime : unsigned(7 downto 0)
			);
		port(
			modulator_clk : in std_logic;
			ri_dhb_ctrl : in rec_dhb_input;
			po2_dhb_pri_pwm : out std_logic_vector(1 downto 0);
			po2_dhb_sec_pwm : out std_logic_vector(1 downto 0)
		);
	end component;

	constant pos_pulse : std_logic_vector(1 downto 0) := "10";
	constant neg_pulse : std_logic_vector(1 downto 0) := "01";
	constant zero_pulse : std_logic_vector(1 downto 0) := "00";
end dhb_pkg;
