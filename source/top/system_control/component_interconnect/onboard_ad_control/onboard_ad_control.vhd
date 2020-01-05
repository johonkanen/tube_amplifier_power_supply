library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.onboard_ad_control_pkg.all;

entity onboard_ad_control is
    port (
        onboard_ad_control_clocks : in onboard_ad_control_clock_group;

        onboard_ad_control_FPGA_in : in onboard_ad_control_FPGA_input_group;
        onboard_ad_control_FPGA_out : out onboard_ad_control_FPGA_output_group;

        onboard_ad_control_data_in : in onboard_ad_control_data_input_group;
        onboard_ad_control_data_out : out onboard_ad_control_data_output_group
    );
end entity onboard_ad_control;

