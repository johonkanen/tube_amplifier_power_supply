library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package pfc_modulator_pkg is

    type pfc_modulator_clock_group is record
        modulator_clock : std_logic;
        core_clock : std_logic;
    end record;
    
    type pfc_modulator_FPGA_output_group is record
        ac1_switch : std_logic;
        ac2_switch : std_logic;
    end record;
    
    type pfc_modulator_data_input_group is record
        duty : integer;
        pfc_is_running : boolean;
    end record;
    
    type pfc_modulator_data_output_group is record
        pfc_modulator_is_running : boolean;
    end record;
    
    component pfc_modulator is
        port (
            pfc_modulator_clocks : in pfc_modulator_clock_group;
    
            pfc_modulator_FPGA_out : out pfc_modulator_FPGA_output_group;
    
            pfc_modulator_data_in : in pfc_modulator_data_input_group;
            pfc_modulator_data_out : out pfc_modulator_data_output_group
        );
    end component pfc_modulator;
        

end package pfc_modulator_pkg;
