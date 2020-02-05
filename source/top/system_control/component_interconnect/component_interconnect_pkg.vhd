library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;


library onboard_adc_library;
    use onboard_adc_library.measurement_interface_pkg;

package component_interconnect_pkg is

type component_interconnect_FPGA_input_group is record
    measurement_interface_FPGA_in : measurement_interface_pkg.measurement_interface_FPGA_input_group;
    pi_uart_rx_serial : std_logic;
end record;

type component_interconnect_FPGA_output_group is record
    measurement_interface_FPGA_out : measurement_interface_pkg.measurement_interface_FPGA_output_group;
    power_supply_control_FPGA_out : work.power_supply_control_pkg.power_supply_control_FPGA_output_group;
    po_uart_tx_serial : std_logic;
    po3_led1 : work.led_driver_pkg.rgb_led;
    po3_led2 : work.led_driver_pkg.rgb_led;
    po3_led3 : work.led_driver_pkg.rgb_led;
end record;

type component_interconnect_data_input_group is record
    clock : std_logic;
    led1_color : work.led_driver_pkg.led_counters;
    led2_color : work.led_driver_pkg.led_counters;
    led3_color : work.led_driver_pkg.led_counters;
end record;

type component_interconnect_data_output_group is record
    measurement_interface_data_out : measurement_interface_pkg.measurement_interface_data_output_group;
end record;

component component_interconnect is
    port (
        system_clocks : in work.system_clocks_pkg.system_clock_group;    

        component_interconnect_FPGA_in : in component_interconnect_FPGA_input_group;
        component_interconnect_FPGA_out : out component_interconnect_FPGA_output_group;

        component_interconnect_data_in : in component_interconnect_data_input_group;
        component_interconnect_data_out : out component_interconnect_data_output_group
    );
end component component_interconnect;
    
end package component_interconnect_pkg;
