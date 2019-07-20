library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.alu16bit_pkg.all;

package rad4_inv16bit_pkg is

component rad4_inv16bit is
    port (
        core_clk : in std_logic;
        rstn : in std_logic;

        si_start_div : in std_logic;
        data_to_invert : in signed(17 downto 0);

        si36_mpy1_result : in std_logic_vector(35 downto 0); 
        si36_mpy2_result : in std_logic_vector(35 downto 0); 
        si_mult_rdy : in std_logic;

        so18_div_mpy1_a : out std_logic_vector(17 downto 0); 
        so18_div_mpy1_b : out std_logic_vector(17 downto 0); 

        so18_div_mpy2_a : out std_logic_vector(17 downto 0); 
        so18_div_mpy2_b : out std_logic_vector(17 downto 0); 

        so_div_start_mpy : out std_logic; 

        so_div_busy : out std_logic;
        so_div_rdy : out std_logic;
        so18_div_out : out std_logic_vector(17 downto 0)
    );
end component;

end package;
