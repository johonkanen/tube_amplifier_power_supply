library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;


package sin_cos16bit_pkg is

    type mpy_control_group is record
        mpy_a : std_logic_vector(17 downto 0);
        mpy_b : std_logic_vector(17 downto 0);
        s36_result : std_logic_vector(35 downto 0);
        start_mpy : boolean;
        mult_is_ready : boolean;
    end record;

    component sin_cos16bit is
    port (
        core_clk : in std_logic;
        rstn : in std_logic;

        si_start_sin_cos : in boolean;
        s16_angle : in signed(17 downto 0);

        mpy1_control : inout work.alu_routines_pkg.alu_control_signals;
        mpy2_control : inout work.alu_routines_pkg.alu_control_signals;

        so_sincos_busy : out std_logic;
        so_sincos_rdy : out std_logic;
        so18_sincos_out : out signed(17 downto 0)
    );
    end component;

    procedure idle_mpy (signal mpy : out mpy_control_group);

end package sin_cos16bit_pkg;

package body sin_cos16bit_pkg is

procedure idle_mpy
(
    signal mpy : out mpy_control_group
) is
begin
    mpy.mpy_a <= (others => '0');
    mpy.mpy_b <= (others => '0');
    mpy.start_mpy <= false;
end idle_mpy;

end package body;
