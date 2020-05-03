library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.system_control_pkg.all;
    use work.component_interconnect_pkg.all;

package system_control_internal_pkg is
------------------------------------------------------------------------
    procedure enable_power_supplies (
        signal component_control_input : out component_interconnect_data_input_group);
------------------------------------------------------------------------
    procedure disable_power_supplies (
        signal component_control_input : out component_interconnect_data_input_group);
------------------------------------------------------------------------
end package system_control_internal_pkg;

package body system_control_internal_pkg is
------------------------------------------------------------------------
    procedure enable_power_supplies
    (
        signal component_control_input : out component_interconnect_data_input_group
    ) is
    begin
        component_control_input.power_supplies_are_enabled <= true;
    end enable_power_supplies;
------------------------------------------------------------------------
    procedure disable_power_supplies
    (
        signal component_control_input : out component_interconnect_data_input_group
    ) is
    begin
        component_control_input.power_supplies_are_enabled <= false;
    end disable_power_supplies;
------------------------------------------------------------------------
end package body system_control_internal_pkg;
