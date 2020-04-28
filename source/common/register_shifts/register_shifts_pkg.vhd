library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package register_shifts_pkg is

------------------------------------------------------------------------
    procedure shift_register ( signal data_vector : inout std_logic_vector;
        input_data : std_logic);
------------------------------------------------------------------------

end package register_shifts_pkg;

package body register_shifts_pkg is
------------------------------------------------------------------------
    procedure shift_register
    (
        signal data_vector : inout std_logic_vector;
        input_data : std_logic
    ) is
    begin

        data_vector <= data_vector(data_vector'left-1 downto 0) & input_data;
        
    end shift_register;
------------------------------------------------------------------------
end package body register_shifts_pkg;
