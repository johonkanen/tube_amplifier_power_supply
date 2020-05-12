library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.llc_control_pkg.all;

package llc_control_internal_pkg is
--------------------------------------------------
    function llc_converter_is_enabled ( llc_input : llc_control_data_input_group)
        return boolean;
--------------------------------------------------
end package llc_control_internal_pkg;

package body llc_control_internal_pkg is
--------------------------------------------------
    function llc_converter_is_enabled
    (
        llc_input : llc_control_data_input_group
    )
    return boolean
    is
    begin
        return llc_input.enable_llc;
    end llc_converter_is_enabled;
--------------------------------------------------
end package body llc_control_internal_pkg;
