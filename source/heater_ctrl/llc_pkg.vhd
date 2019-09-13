library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package llc_pkg is
    
    type hb_llc_pwm is record
        pri_high : std_logic;
        pri_low : std_logic;
        sync1 : std_logic;
        sync2 : std_logic;
    end record;

    component freq_modulator is
        port(
            modulator_clk : in std_logic;
            dsp_clk : in std_logic;
            rstn : in std_logic;

            so_startup_ready : out std_logic;
            piu12_per_ctrl : in unsigned(11 downto 0);
            po4_ht_pwm : out hb_llc_pwm

        );
    end component;
end llc_pkg;
