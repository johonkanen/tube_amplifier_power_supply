library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package sincos_pkg is

    type sincos_clock_group is record
        alu_clock : std_logic;
        reset_n : std_logic;
    end record;
    
    type sincos_data_input_group is record
        angle_pirad : work.multiplier_pkg.int18;
        sincos_is_requested : boolean;
        -- multiplier_data_out : work.multiplier_pkg.multiplier_data_output_group;
    end record;
    
    type sincos_data_output_group is record
        sincos_is_ready : boolean;
        sincos_is_busy : boolean;

        sine : work.multiplier_pkg.int18;
        cosine : work.multiplier_pkg.int18;
        -- multiplier_data_in  : work.multiplier_pkg.multiplier_data_input_group;
    end record;
    
    component sincos is
        port (
            sincos_clocks : in sincos_clock_group;
            sincos_data_in : in sincos_data_input_group;
            sincos_data_out : out sincos_data_output_group
        );
    end component sincos;
        

end package sincos_pkg;
