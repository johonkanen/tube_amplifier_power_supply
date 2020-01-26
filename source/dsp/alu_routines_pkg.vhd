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
        start_alu_mpy : boolean;
        mult_a : std_logic_vector(17 downto 0);
        mult_b : std_logic_vector(17 downto 0);
        mult_result : std_logic_vector(35 downto 0);
        mult_is_ready : boolean;
    end record;

    procedure idle_mpy(signal a : out alu_control_signals);

    procedure alu_mult
        (
            a : in integer;
            b : in integer;
            signal alu_control : inout alu_control_signals;
            variable result : out signed;
            variable increment_counter : inout integer
        );

    procedure alu_mult
        (
            a : in signed;
            b : in integer;
            signal alu_control : inout alu_control_signals;
            variable result : out signed;
            variable increment_counter : inout integer
        );

    function std_to_bool
    (
        logic_in : std_logic
    )
    return boolean;

end alu_routines_pkg; 

package body alu_routines_pkg is

    procedure idle_mpy(signal a : out alu_control_signals) is
    begin
        a.mult_a <= (others => '0');
        a.mult_b <= (others => '0');
        a.start_alu_mpy <= false;
    end procedure;


    function std_to_bool
    (
        logic_in : std_logic
    )
    return boolean
    is
    begin
        if logic_in = '1' then
           return true;
        else
          return false;
        end if; 
    end std_to_bool;

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
            alu_control.start_alu_mpy <= false;
        else
            alu_control.start_alu_mpy <= true;
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
            alu_control.start_alu_mpy <= false;
        else
            alu_control.start_alu_mpy <= true;
        end if;
    end alu_mult;

end package body;
