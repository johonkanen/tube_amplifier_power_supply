library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package alu16bit_pkg is

   type t_alu_commands is (add,sub,a_mpy_b,a_div_b,sqrt_a);

   component alu16bit is
        port (
            core_clk : in std_logic;
            rstn : in std_logic;

            si_start_alu : in std_logic;
            alu_command : in t_alu_commands;
            data1 : in signed(17 downto 0);
            data2 : in signed(17 downto 0);

            so_alu_busy : out std_logic;
            so_alu_rdy : out std_logic;
            so18_alu_data : out signed(17 downto 0)
        );
   end component alu16bit;

end package;
