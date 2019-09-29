library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package sin_cos16bit_pkg is

    type mpy_control_group is record
        mpy1_a : std_logic_vector(17 downto 0);
        mpy1_b : std_logic_vector(17 downto 0);
        si36_mpy1_result : std_logic_vector(35 downto 0);
        start_mpy : std_logic;
        mult_is_ready : boolean;
    end record;

    component sin_cos16bit is
    port (
        core_clk : in std_logic;
        rstn : in std_logic;

        si_start_sin_cos : in boolean;
        s16_angle : in signed(17 downto 0);

        mpy1_control : inout mpy_control_group;
        mpy2_control : inout mpy_control_group;

        so_sincos_busy : out std_logic;
        so_sincos_rdy : out std_logic;
        so18_sincos_out : out signed(17 downto 0)
    );
    end component;


end package;
