library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package component_interconnect_pkg is

type component_interconnect_FPGA_input_group is record
    clock : std_logic;
end record;

type component_interconnect_FPGA_output_group is record
    dummy : std_logic;
    -- sw_supply_control_FPGA_out : work.sw_supply_ctrl_pkg.sw_supply_control_FPGA_output_group;
end record;

type component_interconnect_data_input_group is record
    clock : std_logic;
end record;

type component_interconnect_data_output_group is record
    clock : std_logic;
end record;

component component_interconnect is
    port (
        system_clocks : in work.vendor_specifics_pkg.system_clock_group;    

        component_interconnect_FPGA_in : in component_interconnect_FPGA_input_group;
        component_interconnect_FPGA_out : out component_interconnect_FPGA_output_group;

        component_interconnect_data_in : in component_interconnect_data_input_group;
        component_interconnect_data_out : out component_interconnect_data_output_group
    );
end component component_interconnect;
    
end package component_interconnect_pkg;
