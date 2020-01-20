library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package phase_modulator_pkg is

    type half_bridge is record
        high_gate : std_logic;
        low_gate : std_logic;
    end record;

    type phase_modulator_clock_group is record
        modulator_clock : std_logic;
        core_clock : std_logic;
    end record;
    
    type phase_modulator_FPGA_output_group is record
        primary : half_bridge;
        secondary : half_bridge;
    end record;
    
    type phase_modulator_data_input_group is record
        phase : std_logic;
        dhb_is_enabled : boolean;
    end record;
    
    type phase_modulator_data_output_group is record
        clock : std_logic;
    end record;
    
    component phase_modulator is
        port (
            phase_modulator_clocks : in phase_modulator_clock_group;
            phase_modulator_FPGA_out : out phase_modulator_FPGA_output_group;
            phase_modulator_data_in : in phase_modulator_data_input_group;
            phase_modulator_data_out : out phase_modulator_data_output_group
        );
    end component phase_modulator;
        

end package phase_modulator_pkg;
