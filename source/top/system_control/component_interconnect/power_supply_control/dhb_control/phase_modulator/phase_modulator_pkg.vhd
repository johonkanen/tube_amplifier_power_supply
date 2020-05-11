library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package phase_modulator_pkg is

    type half_bridge is record
        high_gate : std_logic;
        low_gate : std_logic;
    end record;

    type phase_modulator_clock_group is record
        modulator_clock : std_logic;
        core_clock : std_logic;
    end record;
    
    type phase_modulator_FPGA_output_group is record
        primary : half_bridge;
        secondary : half_bridge;
    end record;
    
    type phase_modulator_data_input_group is record
        carrier : integer;
        phase : integer range -2**10 to 2**10-1;
        dhb_is_enabled : std_logic;
        tg_load_phase : std_logic;
        tg_load_deadtime : std_logic;
        deadtime : integer range 0 to 2**12-1;
    end record;
    
    type phase_modulator_data_output_group is record
        dhb_modulator_clock : std_logic;
        core_clock : std_logic;
    end record;
    
    component phase_modulator is
        generic( g_carrier_max_value : integer);
        port (
            phase_modulator_clocks : in phase_modulator_clock_group;
            phase_modulator_FPGA_out : out phase_modulator_FPGA_output_group;
            phase_modulator_data_in : in phase_modulator_data_input_group;
            phase_modulator_data_out : out phase_modulator_data_output_group
        );
    end component phase_modulator;

------------------------------------------------------------------------
    procedure set_phase ( signal dhb_input : inout phase_modulator_data_input_group;
        phase : in integer);
------------------------------------------------------------------------         
    procedure enable_dhb_modulator (
        signal dhb_input : inout phase_modulator_data_input_group);
------------------------------------------------------------------------         
    procedure disable_dhb_modulator (
        signal dhb_input : out phase_modulator_data_input_group);
------------------------------------------------------------------------         
    procedure trigger ( signal trig : inout std_logic);
------------------------------------------------------------------------         
    procedure set_deadtime ( 
        signal dhb_input : inout phase_modulator_data_input_group;
        deadtime : in integer);
------------------------------------------------------------------------         

end package phase_modulator_pkg;

package body phase_modulator_pkg is
------------------------------------------------------------------------
    procedure trigger
    (
       signal trig : inout std_logic
    ) is
    begin
        trig <= not trig;
    end trigger;
------------------------------------------------------------------------
    procedure set_phase ( 
        signal dhb_input : inout phase_modulator_data_input_group;
        phase : in integer
    )
    is
    begin
        dhb_input.phase <= phase;
        dhb_input.tg_load_phase <= not dhb_input.tg_load_phase;
    end set_phase;
------------------------------------------------------------------------
    procedure enable_dhb_modulator ( 
        signal dhb_input : inout phase_modulator_data_input_group
    ) is
    begin
        dhb_input.dhb_is_enabled <= '1';
    end enable_dhb_modulator;
------------------------------------------------------------------------
    procedure disable_dhb_modulator ( 
        signal dhb_input : out phase_modulator_data_input_group
    ) is
    begin
        dhb_input.dhb_is_enabled <= '0';
    end disable_dhb_modulator;
------------------------------------------------------------------------
    procedure set_deadtime ( 
        signal dhb_input : inout phase_modulator_data_input_group;
        deadtime : in integer
    )
    is
    begin
        dhb_input.deadtime <= deadtime;
        dhb_input.tg_load_deadtime <= not dhb_input.tg_load_deadtime;
    end set_deadtime;
------------------------------------------------------------------------
end package body phase_modulator_pkg;

