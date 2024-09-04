library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package component_interconnect_pkg is

    type component_interconnect_data_input_group is record
        power_supplies_are_enabled : boolean;
    end record;

------------------------------------------------------------------------
    procedure enable_power_supplies (
        signal self : in component_interconnect_data_input_group);
------------------------------------------------------------------------
    procedure disable_power_supplies (
        signal self : in component_interconnect_data_input_group);
------------------------------------------------------------------------
end package component_interconnect_pkg;

----------------------------------

package body component_interconnect_pkg is

------------------------------------------------------------------------
    procedure enable_power_supplies
    (
        signal self : in component_interconnect_data_input_group
    ) is
    begin
        
    end enable_power_supplies;
------------------------------------------------------------------------
    procedure disable_power_supplies
    (
        signal self : in component_interconnect_data_input_group
    ) is
    begin
        
    end disable_power_supplies;
------------------------------------------------------------------------
end package body component_interconnect_pkg;
