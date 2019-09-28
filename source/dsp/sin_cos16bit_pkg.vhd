library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package sin_cos16bit_pkg is
    component sin_cos16bit is
    port (
        core_clk : in std_logic;
        rstn : in std_logic;

        si_start_sin_cos : in std_logic;
        s16_angle : in signed(17 downto 0);

        si36_mpy1_result : in std_logic_vector(35 downto 0); 
        si36_mpy2_result : in std_logic_vector(35 downto 0); 
        si_mult_rdy : in std_logic;

        so18_sincos_mpy1_a : out std_logic_vector(17 downto 0); 
        so18_sincos_mpy1_b : out std_logic_vector(17 downto 0); 

        so18_sincos_mpy2_a : out std_logic_vector(17 downto 0); 
        so18_sincos_mpy2_b : out std_logic_vector(17 downto 0); 

        so_sincos_start_mpy : out std_logic; 

        so_sincos_busy : out std_logic;
        so_sincos_rdy : out std_logic;
        so18_sincos_out : out signed(17 downto 0)
    );
    end component;

end package;
