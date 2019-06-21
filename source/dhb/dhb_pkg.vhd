library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	
package dhb_pkg is

    type dhb_pwm is record
        pri_high : std_logic;
        pri_low : std_logic;
        sec_high : std_logic;
        sec_low : std_logic;
    end record;

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
            po4_dhb_pwm : out dhb_pwm
		);
	end component;

end dhb_pkg;
