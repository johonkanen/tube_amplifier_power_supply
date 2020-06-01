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
        reset_n : std_logic;
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

    type multiplier_input_array is array (integer range <>) of multiplier_data_input_group;
    type multiplier_output_array is array (integer range <>) of multiplier_data_output_group;
    
    component multiplier is
        port (
            multiplier_clocks : in multiplier_clock_group;
    
            multiplier_data_in : in multiplier_data_input_group;
            multiplier_data_out : out multiplier_data_output_group
        );
    end component multiplier;
------------------------------------------------------------------------
    procedure alu_mpy
    (
        mult_a : in int18;
        mult_b : in int18;
        signal alu_input : out multiplier_data_input_group;
        signal alu_out : in multiplier_data_output_group
    );
------------------------------------------------------------------------
    procedure enable_multiplier (
        signal multiplier_in : out multiplier_data_input_group);
------------------------------------------------------------------------
    procedure alu_mpy ( mult_a,mult_b : in int18;
        signal alu_input : out multiplier_data_input_group);
------------------------------------------------------------------------
    function get_result ( mpy_out : multiplier_data_output_group; radix : integer)
        return int18;
------------------------------------------------------------------------
    function multiplier_is_ready ( multiplier_in : multiplier_data_output_group)
        return boolean;
------------------------------------------------------------------------
    procedure increment ( variable counter : inout int18);
------------------------------------------------------------------------
    procedure init_multiplier ( signal multiplier_in : out multiplier_data_input_group);
------------------------------------------------------------------------
end package multiplier_pkg;
------------------------------------------------------------------------
    -- signal multiplier_clocks   : multiplier_clock_group;
    -- signal multiplier_data_in  : multiplier_data_input_group;
    -- signal multiplier_data_out :  multiplier_data_output_group;
------------------------------------------------------------------------
-- impure interface functions for multiplier-----
-- impure function "*" (left, right : int18) return sign36
-- is
-- begin
--     alu_mpy(left, right, result, multiplier_data_in, multiplier_data_out);
--     return result;
-- end "*";
------------------------------------------------------------------------
-- multiplier_clocks.dsp_clock <= simulator_clock;
-- u_multiplier : multiplier
--     port map(
--         multiplier_clocks, 
--         multiplier_data_in,
--         multiplier_data_out 
--     );
