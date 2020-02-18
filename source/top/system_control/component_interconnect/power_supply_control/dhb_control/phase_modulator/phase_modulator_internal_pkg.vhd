library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package phase_modulator_internal_pkg is

    type t_voltage is (high, low);

    type dhb_modulator_clocked_signals is record
        primary_voltage : t_voltage;
        secondary_voltage : t_voltage;
    end record;

------------------------------------------------------------------------
    procedure set_primary_bridge_voltage ( signal dhb : out dhb_modulator_clocked_signals;
        voltage_state : t_voltage);
------------------------------------------------------------------------
    procedure set_secondary_bridge_voltage ( signal dhb : out dhb_modulator_clocked_signals;
        voltage_state : t_voltage);
------------------------------------------------------------------------
end package phase_modulator_internal_pkg;


package body phase_modulator_internal_pkg is
------------------------------------------------------------------------
    procedure set_primary_bridge_voltage
    (
        signal dhb : out dhb_modulator_clocked_signals;
        voltage_state : t_voltage
    ) is
    begin
        dhb.primary_voltage <= voltage_state;
    end set_primary_bridge_voltage;
------------------------------------------------------------------------
    procedure set_secondary_bridge_voltage
    (
        signal dhb : out dhb_modulator_clocked_signals;
        voltage_state : t_voltage
    ) is
    begin
        dhb.secondary_voltage <= voltage_state;
    end set_secondary_bridge_voltage;
------------------------------------------------------------------------

end package body phase_modulator_internal_pkg;
