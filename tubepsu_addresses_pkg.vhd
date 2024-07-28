library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package tubepsu_addresses_pkg is

    constant system_control_test_address    : natural := 101;
    constant system_control_dc_link_address : natural := 102;
    constant interconnect_test_address      : natural := 100;

    constant reference_voltage_address : natural := 11;
    constant load_current_address      : natural := 1;
    constant input_voltage_address     : natural := 2;
    constant boost_current_address     : natural := 4;
    constant boost_voltage_address     : natural := 5;
    constant boost_control_enable      : natural := 6;
    constant sincos_address            : natural := 25;

    constant vhdl2019_interface_test_address     : natural := 5513;

end package tubepsu_addresses_pkg;
