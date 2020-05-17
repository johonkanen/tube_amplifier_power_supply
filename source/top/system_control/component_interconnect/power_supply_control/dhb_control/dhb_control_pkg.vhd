library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.measurement_interface_pkg.measurement_interface_data_output_group;

package dhb_control_pkg is

    type dhb_control_clock_group is record
        core_clock : std_logic;
        modulator_clock : std_logic;
        pll_lock : std_logic;
    end record;
    
    type dhb_control_FPGA_output_group is record
        phase_modulator_FPGA_out : work.phase_modulator_pkg.phase_modulator_FPGA_output_group;
    end record;
    
    type dhb_control_data_input_group is record
        measurement_interface_data_out : measurement_interface_data_output_group;
        enable_dhb : boolean;
        dhb_carrier : integer;
    end record;
    
    type dhb_control_data_output_group is record
        dhb_is_ready : boolean;
    end record;
    
    component dhb_control is
        generic (
            g_carrier_max_value : integer 
        );
        port (
            dhb_control_clocks   : in dhb_control_clock_group;
            dhb_control_FPGA_out : out dhb_control_FPGA_output_group;
            dhb_control_data_in  : in dhb_control_data_input_group;
            dhb_control_data_out : out dhb_control_data_output_group
        );
    end component dhb_control;

------------------------------------------------------------------------         
    procedure disable_dhb (signal dhb_control_input : out dhb_control_data_input_group);
------------------------------------------------------------------------
    procedure enable_dhb (signal dhb_control_input : out dhb_control_data_input_group);
------------------------------------------------------------------------
    function dhb_is_ready ( dhb_control_output : dhb_control_data_output_group)
        return boolean;
------------------------------------------------------------------------

end package dhb_control_pkg;

package body dhb_control_pkg is
------------------------------------------------------------------------
    procedure disable_dhb
    (
        signal dhb_control_input : out dhb_control_data_input_group
    ) is
    begin
        dhb_control_input.enable_dhb <= false;
    end disable_dhb;
------------------------------------------------------------------------
    procedure enable_dhb
    (
        signal dhb_control_input : out dhb_control_data_input_group
    ) is
    begin
        dhb_control_input.enable_dhb <= true;
    end enable_dhb;
------------------------------------------------------------------------
    function dhb_is_ready
    (
        dhb_control_output : dhb_control_data_output_group
    )
    return boolean
    is
    begin
        return dhb_control_output.dhb_is_ready;
    end dhb_is_ready;
------------------------------------------------------------------------
end package body dhb_control_pkg;
