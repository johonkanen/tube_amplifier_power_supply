library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package sincos_pkg is

    type sincos_clock_group is record
        alu_clock : std_logic;
        reset_n : std_logic;
    end record;
    
    type sincos_data_input_group is record
        angle_uint16_pirad : work.multiplier_pkg.int18;
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
------------------------------------------------------------------------
    function sincos_is_ready ( sincos_in : sincos_data_output_group)
        return boolean;
------------------------------------------------------------------------
    function get_sine ( sincos_out : sincos_data_output_group)
        return work.multiplier_pkg.int18;
------------------------------------------------------------------------
end package sincos_pkg;

package body sincos_pkg is
------------------------------------------------------------------------
    function sincos_is_ready
    (
        sincos_in : sincos_data_output_group
    )
    return boolean
    is
    begin
        return sincos_in.sincos_is_ready;

    end sincos_is_ready;
------------------------------------------------------------------------
    function get_sine
    (
        sincos_out : sincos_data_output_group
    )return work.multiplier_pkg.int18 is 
    begin
        return sincos_out.sine;
    end function get_sine;
------------------------------------------------------------------------
end package body sincos_pkg;
