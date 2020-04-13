library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.measurement_interface_pkg.measurement_interface_data_output_group;
    use onboard_adc_library.measurement_interface_pkg.measurement_interface_data_input_group;

package llc_control_pkg is

    type t_llc_control_states is (disabled, charging, running);

    type llc_control_clock_group is record
        core_clock : std_logic;
        modulator_clock : std_logic;
        pll_lock : std_logic;
    end record;
    
    type llc_control_FPGA_output_group is record
        llc_modulator_FPGA_out : work.llc_modulator_pkg.llc_modulator_FPGA_output_group;
    end record;
    
    type llc_control_data_input_group is record
        enable_llc : boolean;
        measurement_interface_data_out : measurement_interface_data_output_group;
    end record;
    
    type llc_control_data_output_group is record
        st_llc_control_states : t_llc_control_states;
        measurement_interface_data_in : measurement_interface_data_input_group;
        llc_is_ready : boolean;
    end record;
    
    component llc_control is
        port (
            llc_control_clocks : in llc_control_clock_group;
            llc_control_FPGA_out : out llc_control_FPGA_output_group;
            llc_control_data_in : in llc_control_data_input_group;
            llc_control_data_out : out llc_control_data_output_group
        );
    end component llc_control;
------------------------------------------------------------------------         
    procedure disable_llc (signal llc_control_input : out llc_control_data_input_group);
------------------------------------------------------------------------
    procedure enable_llc (signal llc_control_input : out llc_control_data_input_group);
------------------------------------------------------------------------

end package llc_control_pkg;

package body llc_control_pkg is
------------------------------------------------------------------------
    procedure disable_llc
    (
        signal llc_control_input : out llc_control_data_input_group
    ) is
    begin
        llc_control_input.enable_llc <= false;
    end disable_llc;
------------------------------------------------------------------------
    procedure enable_llc
    (
        signal llc_control_input : out llc_control_data_input_group
    ) is
    begin
        llc_control_input.enable_llc <= true;
    end enable_llc;
------------------------------------------------------------------------
    function llc_is_ready
    (
        llc_control_output : llc_control_data_output_group
    )
    return boolean
    is
    begin
        return llc_control_output.llc_is_ready;
    end llc_is_ready;
------------------------------------------------------------------------
end package body llc_control_pkg;
