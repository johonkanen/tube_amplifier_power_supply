

package body multiplier_pkg is
------------------------------------------------------------------------
    procedure enable_multiplier
    (
        signal multiplier_in : out multiplier_data_input_group
    ) is
    begin
        multiplier_in.multiplication_is_requested <= false;
    end enable_multiplier;
------------------------------------------------------------------------
    procedure init_multiplier
    (
        signal multiplier_in : out multiplier_data_input_group
    ) is
    begin
        multiplier_in.mult_a <= 0;
        multiplier_in.mult_b <= 0;
        multiplier_in.multiplication_is_requested <= false;
    end init_multiplier;
------------------------------------------------------------------------
    procedure alu_mpy
    (
        mult_a,mult_b : in int18;
        signal alu_input : out multiplier_data_input_group
    ) is
    begin
        alu_input.mult_a <= mult_a;
        alu_input.mult_b <= mult_b;
        alu_input.multiplication_is_requested <= true;
    end alu_mpy;
------------------------------------------------------------------------
    procedure alu_mpy
    (
        mult_a : in int18;
        mult_b : in int18;
        signal alu_input : out multiplier_data_input_group;
        signal alu_out : in multiplier_data_output_group
    ) is
    begin
        alu_input.mult_a <= mult_a;
        alu_input.mult_b <= mult_b;

        alu_input.multiplication_is_requested <= true;
        if alu_out.multiplier_is_ready then
            alu_input.multiplication_is_requested <= false;
        end if;
    end alu_mpy;
------------------------------------------------------------------------
    function multiplier_is_ready
    (
        multiplier_in : multiplier_data_output_group
    )
    return boolean
    is
    begin
        return multiplier_in.multiplier_is_ready;
    end multiplier_is_ready;
------------------------------------------------------------------------
    procedure increment ( variable counter : inout int18) is
    begin
        counter := counter + 1;
    end increment;
------------------------------------------------------------------------
    function "+" ( left : integer; right : std_logic)
    return integer
    is
    begin
        if right = '1' then
            return left + 1;
        else
            return left + 0;
        end if;
    end "+";
------------------------------------------------------------------------
    function get_result
    (
        mpy_out : multiplier_data_output_group;
        radix : integer
    )
    return int18
    is
    begin
        return to_integer(mpy_out.multiplier_result(radix + 17 downto radix)) 
                        + mpy_out.multiplier_result(radix -1);
    end get_result;
------------------------------------------------------------------------
end package body multiplier_pkg;
