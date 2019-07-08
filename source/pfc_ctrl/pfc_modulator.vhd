library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
	use work.sys_ctrl_pkg.all;
	use work.ad_bus_pkg.all;
	use work.pfc_pkg.all;

entity pfc_modulator is
    port(
	    modulator_clk : in std_logic;
	    dsp_clk : in std_logic;
	    si_rstn : in std_logic;

	    si_u12_pfc_duty : in unsigned(11 downto 0);
	    si_u12_sym_carrier : in unsigned(11 downto 0);

	    po2_pfc_pwm : out bridgeless_pfc_pwm
	);
end pfc_modulator;


architecture rtl of pfc_modulator is
    signal safe_si_u12_pfc_duty : unsigned(11 downto 0);

begin

    pfc_pwm : process(modulator_clk)
    
    begin
        if rising_edge(modulator_clk) then
            if si_rstn = '0' then
                po2_pfc_pwm.ac1 <= '0';
                po2_pfc_pwm.ac2 <= '0';
            else
                if si_u12_pfc_duty < 12d"200" then
                    safe_si_u12_pfc_duty <= si_u12_pfc_duty;
                else
                    safe_si_u12_pfc_duty <= safe_si_u12_pfc_duty;
                end if;

                if si_u12_sym_carrier < safe_si_u12_pfc_duty then
                    po2_pfc_pwm.ac1 <= '1';
                    po2_pfc_pwm.ac2 <= '1';
                else 
                    po2_pfc_pwm.ac1 <= '0';
                    po2_pfc_pwm.ac2 <= '0';
                end if;
            end if;
        end if;
    end process pfc_pwm;

end rtl;
