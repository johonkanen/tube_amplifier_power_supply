library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package llc_modulator_pkg is

    type hb_llc_pwm is record
        pri_high : std_logic;
        pri_low : std_logic;
        sync1 : std_logic;
        sync2 : std_logic;
    end record;

    type llc_modulator_clock_group is record
        modulator_clock : std_logic;
        core_clock : std_logic;
    end record;
    
    type llc_modulator_FPGA_output_group is record
        llc_gates : hb_llc_pwm;
    end record;
    
    type llc_modulator_data_input_group is record
        period : integer;
        clock : std_logic;
        reset_n : std_logic;
    end record;
    
    type llc_modulator_data_output_group is record
        clock : std_logic;
    end record;
    
    component llc_modulator is
        port (
            llc_modulator_clocks : in llc_modulator_clock_group;
    
            -- llc_modulator_FPGA_in : in llc_modulator_FPGA_input_group;
            llc_modulator_FPGA_out : out llc_modulator_FPGA_output_group;
    
            llc_modulator_data_in : in llc_modulator_data_input_group;
            llc_modulator_data_out : out llc_modulator_data_output_group
        );
    end component llc_modulator;
        
end package llc_modulator_pkg;
