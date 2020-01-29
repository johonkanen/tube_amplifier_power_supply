library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package pfc_modulator_pkg is

    type pfc_modulator_clock_group is record
        modulator_clock : std_logic;
        core_clock : std_logic;
    end record;
    
    type pfc_modulator_FPGA_output_group is record
        ac1_switch : std_logic;
        ac2_switch : std_logic;
    end record;
    
    type pfc_modulator_data_input_group is record
        duty : integer;
        pfc_is_enabled : boolean;
        mains_voltage_measurement : integer;
        pfc_carrier : integer;
    end record;
    
    type pfc_modulator_data_output_group is record
        pfc_modulator_is_running : boolean;
    end record;
    
    component pfc_modulator is
        generic( g_carrier_max_value : integer);
        port (
            pfc_modulator_clocks : in pfc_modulator_clock_group;
            pfc_modulator_FPGA_out : out pfc_modulator_FPGA_output_group;
            pfc_modulator_data_in : in pfc_modulator_data_input_group;
            pfc_modulator_data_out : out pfc_modulator_data_output_group
        );
    end component pfc_modulator;
------------------------------------------------------------------------
    procedure set_duty ( duty : in integer;
        signal pfc_input : out pfc_modulator_data_input_group);
------------------------------------------------------------------------         
    procedure enable_pfc_modulator (
        signal pfc_input : out pfc_modulator_data_input_group);
------------------------------------------------------------------------         
    procedure disable_pfc_modulator (
        signal pfc_input : out pfc_modulator_data_input_group);
------------------------------------------------------------------------         
end package pfc_modulator_pkg;

package body pfc_modulator_pkg is
------------------------------------------------------------------------
    procedure set_duty ( duty : in integer;
        signal pfc_input : out pfc_modulator_data_input_group
    )
    is
    begin
        pfc_input.duty <= duty;
    end set_duty;
------------------------------------------------------------------------
    procedure enable_pfc_modulator ( 
        signal pfc_input : out pfc_modulator_data_input_group
    ) is
    begin
        pfc_input.pfc_is_enabled <= true;
    end enable_pfc_modulator;
------------------------------------------------------------------------
    procedure disable_pfc_modulator ( 
        signal pfc_input : out pfc_modulator_data_input_group
    ) is
    begin
        pfc_input.pfc_is_enabled <= false;
    end disable_pfc_modulator;
------------------------------------------------------------------------
end package body pfc_modulator_pkg;

