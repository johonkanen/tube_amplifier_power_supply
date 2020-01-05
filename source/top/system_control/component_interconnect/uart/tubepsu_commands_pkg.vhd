library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package tubepsu_commands_pkg is

    constant c_uart_command : std_logic_vector(3 downto 0) := x"0";

    constant c_pfc_start : std_logic_vector(11 downto 0) := x"00A";
    constant c_pfc_stop : std_logic_vector(11 downto 0) := x"00B";
    constant c_pfc_duty : std_logic_vector(3 downto 0) := x"1";

    constant c_llc_start : std_logic_vector(11 downto 0) := x"014";
    constant c_llc_stop : std_logic_vector(11 downto 0) := x"015";
    constant c_llc_freq : std_logic_vector(3 downto 0) := x"2";

    constant c_dhb_start : std_logic_vector(11 downto 0) := x"01E";
    constant c_dhb_stop : std_logic_vector(11 downto 0) := x"01F";
    constant c_dhb_duty : std_logic_vector(3 downto 0) := x"3";


end tubepsu_commands_pkg;
