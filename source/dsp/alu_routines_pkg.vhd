library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package alu_routines_pkg is
 
    -- TODO move these to common datatypes package

    subtype int16 is integer range -2**15 to 2**15-1;
    subtype int18 is integer range -2**17 to 2**17-1;

    subtype uint16 is integer range 0 to 2**16-1;
    subtype uint18 is integer range 0 to 2**18-1;

    subtype sign36 is signed (35 downto 0);

    type alu_control_signals is record
        start_alu_mpy : std_logic;
        mult_a : std_logic_vector(17 downto 0);
        mult_b : std_logic_vector(17 downto 0);
        mult_result : std_logic_vector(35 downto 0);
        mult_is_ready : boolean;
    end record;

    procedure alu_mult
        (
            a : in integer;
            b : in integer;
            signal alu_control : inout alu_control_signals;
            variable result : out signed;
            variable increment_counter : inout integer
        );
    end; 


package body alu_routines_pkg is


    procedure alu_mult
    (
        a : in integer;
        b : in integer;
        signal alu_control : inout alu_control_signals;
        variable result : out signed;
        variable increment_counter : inout integer
    ) is
    begin
        alu_control.mult_a <= std_logic_vector(to_signed(a,18));
        alu_control.mult_b <= std_logic_vector(to_signed(b,18));
        result := (signed(alu_control.mult_result));
        if alu_control.mult_is_ready then
            increment_counter := increment_counter + 1;
            alu_control.start_alu_mpy <= '0';
        else
            alu_control.start_alu_mpy <= '1';
        end if;
    end alu_mult;

    procedure alu_mult
    (
        a : in signed;
        b : in integer;
        signal alu_control : inout alu_control_signals;
        variable result : out signed;
        variable increment_counter : inout integer
    ) is
    begin
        alu_control.mult_a <= std_logic_vector(a);
        alu_control.mult_b <= std_logic_vector(to_signed(b,18));
        result := (signed(alu_control.mult_result));
        if alu_control.mult_is_ready then
            increment_counter := increment_counter + 1;
            alu_control.start_alu_mpy <= '0';
        else
            alu_control.start_alu_mpy <= '1';
        end if;
    end alu_mult;

end package body;
