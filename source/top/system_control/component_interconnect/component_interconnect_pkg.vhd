library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package component_interconnect_pkg is
type component_interconnect_clock_group is record
    clock : std_logic;
end record;

type component_interconnect_FPGA_input_group is record
    clock : std_logic;
end record;

type component_interconnect_FPGA_output_group is record
-- heater pwm
        po4_ht_pwm : work.llc_pkg.hb_llc_pwm;
-- DBH pwm
        po4_dhb_pwm : work.dhb_pkg.dhb_pwm;
-- PFC pwm
	    po2_pfc_pwm : work.pfc_pkg.bridgeless_pfc_pwm;

	    po_uart_tx : std_logic;
end record;

type component_interconnect_data_input_group is record
    clock : std_logic;
end record;

type component_interconnect_data_output_group is record
    clock : std_logic;
end record;

component component_interconnect is
    port (
        component_interconnect_clocks : in component_interconnect_clock_group;

        component_interconnect_FPGA_in : in component_interconnect_FPGA_input_group;
        component_interconnect_FPGA_out : out component_interconnect_FPGA_output_group;

        component_interconnect_data_in : in component_interconnect_data_input_group;
        component_interconnect_data_out : out component_interconnect_data_output_group
    );
end component component_interconnect;
    
end package component_interconnect_pkg;
