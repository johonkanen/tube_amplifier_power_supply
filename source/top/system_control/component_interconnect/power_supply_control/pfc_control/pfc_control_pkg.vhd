library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.measurement_interface_pkg.measurement_interface_data_output_group;

package pfc_control_pkg is
------------------------------------------------------------------------
    type t_pfc_states is (disabled, ramping_up, running);
------------------------------------------------------------------------

    type pfc_control_clock_group is record
        core_clock : std_logic;
        modulator_clock : std_logic;
        pll_lock : std_logic;
    end record;
    
    type pfc_control_FPGA_output_group is record
        pfc_modulator_FPGA_out : work.pfc_modulator_pkg.pfc_modulator_FPGA_output_group;
    end record;
    
    type pfc_control_data_input_group is record
        enable_pfc : boolean;
        measurement_interface_data_out : measurement_interface_data_output_group;
        pfc_carrier : integer;
    end record;
    
    type pfc_control_data_output_group is record
        pfc_state_is : t_pfc_states;
    end record;

    component pfc_control is
        generic ( g_carrier_max_value : integer); 
        port (
            pfc_control_clocks : in pfc_control_clock_group;
            pfc_control_FPGA_out : out pfc_control_FPGA_output_group;
            pfc_control_data_in : in pfc_control_data_input_group;
            pfc_control_data_out : out pfc_control_data_output_group
        );
    end component pfc_control;
------------------------------------------------------------------------
    procedure disable_pfc (signal pfc_control_input : out pfc_control_data_input_group);
------------------------------------------------------------------------
    procedure enable_pfc (signal pfc_control_input : out pfc_control_data_input_group);
------------------------------------------------------------------------

end package pfc_control_pkg;

package body pfc_control_pkg is
------------------------------------------------------------------------
    procedure disable_pfc
    (
        signal pfc_control_input : out pfc_control_data_input_group
    ) is
    begin
        pfc_control_input.enable_pfc <= false;
    end disable_pfc;
------------------------------------------------------------------------
    procedure enable_pfc
    (
        signal pfc_control_input : out pfc_control_data_input_group
    ) is
    begin
        pfc_control_input.enable_pfc <= true;
    end enable_pfc;
------------------------------------------------------------------------
end package body pfc_control_pkg;
