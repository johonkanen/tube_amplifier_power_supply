library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package tubepsu_commands_pkg is

    constant c_uart_command : std_logic_vector(3 downto 0) := 4d"0";

    constant c_pfc_start : std_logic_vector(11 downto 0) := 12d"10";
    constant c_pfc_stop : std_logic_vector(11 downto 0) := 12d"11";
    constant c_pfc_duty : std_logic_vector(3 downto 0) := 4d"1";

    constant c_llc_start : std_logic_vector(11 downto 0) := 12d"20";
    constant c_llc_stop : std_logic_vector(11 downto 0) := 12d"21";
    constant c_llc_freq : std_logic_vector(3 downto 0) := 4d"2";

    constant c_dhb_start : std_logic_vector(11 downto 0) := 12d"30";
    constant c_dhb_stop : std_logic_vector(11 downto 0) := 12d"31";
    constant c_dhb_duty : std_logic_vector(3 downto 0) := 4d"3";


end tubepsu_commands_pkg;
