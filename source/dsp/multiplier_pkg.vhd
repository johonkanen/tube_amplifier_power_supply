library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package multiplier_pkg is

    subtype int18 is integer range -2**17 to 2**17-1;
    subtype sign18 is signed(17 downto 0);
    subtype sign36 is signed(35 downto 0);

    type sign_array is array (integer range <>) of sign18;
    type result_array is array (integer range <>) of sign36;

    type multiplier_clock_group is record
        dsp_clock : std_logic;
    end record;
    
    type multiplier_data_input_group is record
        mult_a : int18;
        mult_b : int18;
        multiplication_is_requested : boolean;
    end record;
    
    type multiplier_data_output_group is record
        multiplier_result : sign36;
        multiplier_is_ready : boolean;
    end record;
    
    component multiplier is
        port (
            multiplier_clocks : in multiplier_clock_group;
    
            multiplier_data_in : in multiplier_data_input_group;
            multiplier_data_out : out multiplier_data_output_group
        );
    end component multiplier;
        

end package multiplier_pkg;
