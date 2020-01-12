library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package power_supply_control_pkg is

    type power_supply_control_clock_group is record
        core_clock : std_logic;
        modulator_clock : std_logic;
    end record;
    
    type power_supply_control_FPGA_output_group is record
        clock : std_logic;
    end record;
    
    type power_supply_control_data_input_group is record
        clock : std_logic;
    end record;
    
    type power_supply_control_data_output_group is record
        clock : std_logic;
    end record;
    
    component power_supply_control is
        port (
            power_supply_control_clocks : in power_supply_control_clock_group;
    
            power_supply_control_FPGA_out : out power_supply_control_FPGA_output_group;
    
            power_supply_control_data_in : in power_supply_control_data_input_group;
            power_supply_control_data_out : out power_supply_control_data_output_group
        );
    end component power_supply_control;
        
end package power_supply_control_pkg;
