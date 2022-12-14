ECHO off
set source=source/

ghdl -a --ieee=synopsys %source%/top/system_clocks_pkg.vhd
ghdl -a --ieee=synopsys %source%/../cyclone_10/source_cl10/cl10_pll_wrapper.vhd
ghdl -a --ieee=synopsys %source%/../cyclone_10/source_cl10/cl10_fifo_control_pkg.vhd
ghdl -a --ieee=synopsys %source%/../cyclone_10/source_cl10/ram_control_pkg.vhd

rem ghdl -a --ieee=synopsys %source%/cyclone_10lp/cl10_specifics.vhd

ghdl -a --ieee=synopsys %source%/dsp/multiplier/multiplier_pkg.vhd

ghdl -a --ieee=synopsys %source%/dsp/feedback_control/feedback_control_pkg.vhd
ghdl -a --ieee=synopsys %source%/dsp/feedback_control/feedback_control.vhd

ghdl -a --ieee=synopsys %source%/dsp/sincos/sincos_pkg.vhd
ghdl -a --ieee=synopsys %source%/dsp/sincos/sincos.vhd

ghdl -a --ieee=synopsys --work=common_library %source%/common/timing/timing_pkg.vhd
ghdl -a --ieee=synopsys --work=common_library %source%/common/typesdefs/typedefs_pkg.vhd
ghdl -a --ieee=synopsys --work=common_library %source%/common/register_shifts/register_shifts_pkg.vhd

ghdl -a --ieee=synopsys --work=onboard_adc_library %source%/top/system_control/component_interconnect/measurement_interface/onboard_ad_control/onboard_ad_control_pkg.vhd
ghdl -a --ieee=synopsys --work=onboard_adc_library %source%/top/system_control/component_interconnect/measurement_interface/onboard_ad_control/onboard_ad_control_internal_pkg.vhd
ghdl -a --ieee=synopsys --work=onboard_adc_library %source%/top/system_control/component_interconnect/measurement_interface/measurement_interface_pkg.vhd
ghdl -a --ieee=synopsys --work=onboard_adc_library %source%/top/system_control/component_interconnect/measurement_interface/psu_measurement_interface_pkg.vhd

ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/external_adc_driver/max_11115_pkg.vhd
rem
ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/power_supply_control/pfc_control/pfc_modulator/pfc_modulator_pkg.vhd
ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/power_supply_control/pfc_control/arch_pfc_current_control.vhd
ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/power_supply_control/pfc_control/arch_pfc_voltage_control.vhd
ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/power_supply_control/pfc_control/pfc_control_pkg.vhd

ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/power_supply_control/llc_control/llc_modulator/llc_modulator_pkg.vhd
ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/power_supply_control/llc_control/llc_control_pkg.vhd
ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/power_supply_control/llc_control/arch_llc_pi_control.vhd
ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/power_supply_control/llc_control/llc_control_internal_pkg.vhd

ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/deadtime_pkg.vhd
ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/phase_modulator_pkg.vhd
ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/power_supply_control/dhb_control/dhb_control_pkg.vhd
ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/power_supply_control/power_supply_control_pkg.vhd
ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/uart/uart_pkg.vhd
rem
ghdl -a --ieee=synopsys %source%/top/system_control/led_driver/led_driver_pkg.vhd
rem
ghdl -a --ieee=synopsys %source%/top/system_control/component_interconnect/component_interconnect_pkg.vhd
ghdl -a --ieee=synopsys %source%/top/system_control/system_control_pkg.vhd
ghdl -a --ieee=synopsys %source%/top/system_control/system_control_internal_pkg.vhd
rem
rem ghdl -a --ieee=synopsys %source%/ecp5/ecp5_pll_wrapper.vhd
rem ghdl -a --ieee=synopsys %source%/spartan_7/s7_specifics.vhd
rem ghdl -a --ieee=synopsys %source%/spartan_7/s7_adc_wrapper.vhd
