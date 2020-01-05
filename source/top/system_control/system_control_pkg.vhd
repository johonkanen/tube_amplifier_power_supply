library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package system_control_pkg is
    
    type system_control_FPGA_input_group is record
    component_interconnect_FPGA_in : work.component_interconnect_pkg.component_interconnect_FPGA_input_group;
    end record;
    
    type system_control_FPGA_output_group is record
        component_interconnect_FPGA_out : work.component_interconnect_pkg.component_interconnect_FPGA_output_group;
    end record;
    
    type system_control_data_input_group is record
        component_interconnect_data_in : work.component_interconnect_pkg.component_interconnect_data_input_group;
    end record;
    
    type system_control_data_output_group is record
        component_interconnect_data_out : work.component_interconnect_pkg.component_interconnect_data_output_group;
    end record;
    
    component system_control is
        port(
            system_clocks : in work.vendor_specifics_pkg.system_clock_group;    

            system_control_FPGA_in : in system_control_FPGA_input_group;
            system_control_FPGA_out : out system_control_FPGA_output_group;
    
            system_control_data_in : in system_control_data_input_group;
            system_control_data_out : out system_control_data_output_group
        );
    end component system_control;
        

end package system_control_pkg;
