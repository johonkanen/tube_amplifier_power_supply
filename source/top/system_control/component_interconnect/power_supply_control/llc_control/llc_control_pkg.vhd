library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package llc_control_pkg is

    type llc_control_clock_group is record
        core_clock : std_logic;
        modulator_clock : std_logic;
        pll_lock : std_logic;
    end record;
    
    type llc_control_FPGA_output_group is record
        llc_modulator_FPGA_out : work.llc_modulator_pkg.llc_modulator_FPGA_output_group;
    end record;
    
    type llc_control_data_input_group is record
        clock : std_logic;
    end record;
    
    type llc_control_data_output_group is record
        clock : std_logic;
    end record;
    
    component llc_control is
        port (
            llc_control_clocks : in llc_control_clock_group;
            llc_control_FPGA_out : out llc_control_FPGA_output_group;
            llc_control_data_in : in llc_control_data_input_group;
            llc_control_data_out : out llc_control_data_output_group
        );
    end component llc_control;
        

end package llc_control_pkg;
