
package body component_interconnect_pkg is

------------------------------------------------------------------------
    procedure enable_power_supplies
    (
        signal self : out component_interconnect_data_input_group
    ) is
    begin
        self.power_supplies_are_enabled <= true;
    end enable_power_supplies;
------------------------------------------------------------------------
    procedure disable_power_supplies
    (
        signal self : out component_interconnect_data_input_group
    ) is
    begin
        self.power_supplies_are_enabled <= false;
    end disable_power_supplies;
------------------------------------------------------------------------
end package body component_interconnect_pkg;
