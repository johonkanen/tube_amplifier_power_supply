library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package system_control_pkg is

    type system_control_clock_group is record
        clock : std_logic;
    end record;
    
    type system_control_FPGA_input_group is record
        clock : std_logic;
    end record;
    
    type system_control_FPGA_output_group is record
        clock : std_logic;
    end record;
    
    type system_control_data_input_group is record
        clock : std_logic;
    end record;
    
    type system_control_data_output_group is record
        clock : std_logic;
    end record;
    
    component system_control is
        port (
            system_control_clocks : in system_control_clock_group;
    
            system_control_FPGA_in : in system_control_FPGA_input_group;
            system_control_FPGA_out : out system_control_FPGA_output_group;
    
            system_control_data_in : in system_control_data_input_group;
            system_control_data_out : out system_control_data_output_group
        );
    end component system_control;
        

end package system_control_pkg;
