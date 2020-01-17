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
    
    component multiplier is
        port (
            multiplier_clocks : in multiplier_clock_group;
    
            multiplier_data_in : in multiplier_data_input_group;
            multiplier_data_out : out multiplier_data_output_group
        );
    end component multiplier;
--------------------------------------------------
    procedure alu_mpy
    (
        mult_a : in int18;
        mult_b : in int18;
        variable result : out sign36;
        signal alu_input : out multiplier_data_input_group;
        signal alu_out : in multiplier_data_output_group;
        variable process_counter : inout integer
    );
--------------------------------------------------
end package multiplier_pkg;
------------------------------------------------------------------------
package body multiplier_pkg is

    procedure alu_mpy
    (
        mult_a : in int18;
        mult_b : in int18;
        variable result : out sign36;
        signal alu_input : out multiplier_data_input_group;
        signal alu_out : in multiplier_data_output_group;
        variable process_counter : inout integer
    ) is
    begin
        alu_input.mult_a <= mult_a;
        alu_input.mult_b <= mult_b;

        result := alu_out.multiplier_result;
        alu_input.multiplication_is_requested <= true;
        if alu_out.multiplier_is_ready then
            process_counter := process_counter + 1;
            alu_input.multiplication_is_requested <= false;
        end if;
    end alu_mpy;
end package body multiplier_pkg;
