library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package heater_control_pkg is

    type heater_control_clock_group is record
        clock : std_logic;
    end record;
    
    type heater_control_FPGA_input_group is record
        clock : std_logic;
    end record;
    
    type heater_control_FPGA_output_group is record
        clock : std_logic;
    end record;
    
    type heater_control_data_input_group is record
        clock : std_logic;
    end record;
    
    type heater_control_data_output_group is record
        clock : std_logic;
    end record;
    
    component heater_control is
        port (
            heater_control_clocks : in heater_control_clock_group;
    
            heater_control_FPGA_in : in heater_control_FPGA_input_group;
            heater_control_FPGA_out : out heater_control_FPGA_output_group;
    
            heater_control_data_in : in heater_control_data_input_group;
            heater_control_data_out : out heater_control_data_output_group
        );
    end component heater_control;
        

end package heater_control_pkg;
