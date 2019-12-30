library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package sys_ctrl_pkg is

type tcmd_system_commands is (init,
				charge_dc_link,
				bypass_relay, 
				start_aux, 
				start_pfc, 
				start_heaters, 
				start_dhb, 
				stop);

signal r_si_tcmd_system_cmd : tcmd_system_commands;

type t_rx_commands is (idle,
		       init,
		       start,
		       test1,
		       test2,
		       test3,
		       stop);

signal r_so_tcmd_rx_cmd : t_rx_commands;

constant c_std12_start : std_logic_vector(11 downto 0) := x"666";
constant c_std12_stop : std_logic_vector(11 downto 0) := x"999";
constant c_std12_stream_ada0 : std_logic_vector(11 downto 0) := x"000";
constant c_std12_stream_ada1 : std_logic_vector(11 downto 0) := x"001";
constant c_std12_stream_ada2 : std_logic_vector(11 downto 0) := x"002";
constant c_std12_stream_ada3 : std_logic_vector(11 downto 0) := x"003";
constant c_std12_stream_ada4 : std_logic_vector(11 downto 0) := x"004";
constant c_std12_stream_ada5 : std_logic_vector(11 downto 0) := x"005";
constant c_std12_stream_ada6 : std_logic_vector(11 downto 0) := x"006";

constant c_std12_stream_adb0 : std_logic_vector(11 downto 0) := x"007";
constant c_std12_stream_adb1 : std_logic_vector(11 downto 0) := x"008";
constant c_std12_stream_adb2 : std_logic_vector(11 downto 0) := x"009";
constant c_std12_stream_adb3 : std_logic_vector(11 downto 0) := x"00A";
constant c_std12_stream_adb4 : std_logic_vector(11 downto 0) := x"00B";
constant c_std12_stream_adb5 : std_logic_vector(11 downto 0) := x"00C";
constant c_std12_stream_adb6 : std_logic_vector(11 downto 0) := x"00D";


alias aka_cstd12_x1_voltage : std_logic_vector(11 downto 0) is c_std12_stream_adb0;
alias aka_cstd12_output_voltage : std_logic_vector(11 downto 0) is c_std12_stream_adb1;
alias aka_cstd12_dclink_voltage : std_logic_vector(11 downto 0) is c_std12_stream_adb3;
alias aka_cstd12_current_meas : std_logic_vector(11 downto 0) is c_std12_stream_ada5;

	type dhb_input is record
		si_rst_n : std_logic;
		si_s16_phase : signed(15 downto 0);
		si_u12_dhb_half_period : unsigned(12 downto 0);
		si_load_phase : std_logic;
	end record;
end sys_ctrl_pkg;
