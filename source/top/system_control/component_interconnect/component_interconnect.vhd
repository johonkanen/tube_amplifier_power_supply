library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.component_interconnect_pkg.all;
    use work.sw_supply_ctrl_pkg.all;

entity component_interconnect is
    port (
        system_clocks : in work.vendor_specifics_pkg.system_clock_group;    

        component_interconnect_FPGA_in : in component_interconnect_FPGA_input_group;
        component_interconnect_FPGA_out : out component_interconnect_FPGA_output_group;

        component_interconnect_data_in : in component_interconnect_data_input_group;
        component_interconnect_data_out : out component_interconnect_data_output_group
    );
end entity component_interconnect;

architecture rtl of component_interconnect is

    signal sw_supply_control_clocks : sw_supply_control_clock_group;
    signal sw_supply_control_FPGA_out : sw_supply_control_FPGA_output_group;
    signal sw_supply_control_data_in : sw_supply_control_data_input_group;
    signal sw_supply_control_data_out : sw_supply_control_data_output_group;
begin

    u_sw_supply_control : sw_supply_control
        port map(
            sw_supply_control_clocks,   
            component_interconnect_FPGA_out.sw_supply_control_FPGA_out,
            sw_supply_control_data_in, 
            sw_supply_control_data_out 
        );

end rtl;
