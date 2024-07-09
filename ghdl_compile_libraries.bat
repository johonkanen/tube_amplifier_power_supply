ECHO off

call ./source/fpga_communication/ghdl_compile_fpga_communication.bat ./source/fpga_communication/
set source=source/
call ./source/hVHDL_microprogram_processor/ghdl_compile.bat ./source/hVHDL_microprogram_processor/
set source=source/

ghdl -a --ieee=synopsys --std=08 tubepsu_addresses_pkg.vhd

ghdl -a --ieee=synopsys --std=08 %source%/top/system_clocks_pkg.vhd
ghdl -a --ieee=synopsys --std=08 %source%/../spartan_7/s7_source/s7_specifics.vhd
ghdl -a --ieee=synopsys --std=08 %source%/../spartan_7/s7_source/s7_pll_wrapper.vhd

rem ghdl -a --ieee=synopsys --std=08 %source%/cyclone_10lp/cl10_specifics.vhd

ghdl -a --ieee=synopsys --std=08 %source%/dsp/multiplier/multiplier_pkg.vhd

ghdl -a --ieee=synopsys --std=08 %source%/dsp/feedback_control/feedback_control_pkg.vhd
ghdl -a --ieee=synopsys --std=08 %source%/dsp/feedback_control/feedback_control.vhd

ghdl -a --ieee=synopsys --std=08 %source%/dsp/sincos/sincos_pkg.vhd
ghdl -a --ieee=synopsys --std=08 %source%/dsp/sincos/sincos.vhd

ghdl -a --ieee=synopsys --std=08 --work=common_library %source%/common/timing/delay_timer_pkg.vhd
ghdl -a --ieee=synopsys --std=08 --work=common_library %source%/common/typesdefs/typedefs_pkg.vhd
ghdl -a --ieee=synopsys --std=08 --work=common_library %source%/common/register_shifts/register_shifts_pkg.vhd

ghdl -a --ieee=synopsys --std=08 --work=onboard_adc_library %source%/top/system_control/component_interconnect/measurement_interface/onboard_ad_control/onboard_ad_control_pkg.vhd
ghdl -a --ieee=synopsys --std=08 --work=onboard_adc_library %source%/top/system_control/component_interconnect/measurement_interface/onboard_ad_control/onboard_ad_control_internal_pkg.vhd
ghdl -a --ieee=synopsys --std=08 --work=onboard_adc_library %source%/top/system_control/component_interconnect/measurement_interface/measurement_interface_pkg.vhd
ghdl -a --ieee=synopsys --std=08 --work=onboard_adc_library %source%/top/system_control/component_interconnect/measurement_interface/psu_measurement_interface_pkg.vhd

ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/component_interconnect/external_adc_driver/max_11115_pkg.vhd
rem
ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/component_interconnect/power_supply_control/pfc_control/pfc_modulator/pfc_modulator_pkg.vhd
ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/component_interconnect/power_supply_control/pfc_control/arch_pfc_current_control.vhd
ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/component_interconnect/power_supply_control/pfc_control/arch_pfc_voltage_control.vhd
ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/component_interconnect/power_supply_control/pfc_control/pfc_control_pkg.vhd

ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/component_interconnect/power_supply_control/llc_control/llc_modulator/llc_modulator_pkg.vhd
ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/component_interconnect/power_supply_control/llc_control/llc_control_pkg.vhd
ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/component_interconnect/power_supply_control/llc_control/arch_llc_pi_control.vhd
ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/component_interconnect/power_supply_control/llc_control/llc_control_internal_pkg.vhd

ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/deadtime_pkg.vhd
ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/phase_modulator_pkg.vhd
ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/component_interconnect/power_supply_control/dhb_control/dhb_control_pkg.vhd
ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/component_interconnect/power_supply_control/power_supply_control_pkg.vhd
rem
ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/led_driver/led_driver_pkg.vhd
rem
ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/component_interconnect/component_interconnect_pkg.vhd
ghdl -a --ieee=synopsys --std=08 %source%/top/system_control/system_control_pkg.vhd

ghdl -a --ieee=synopsys --std=08 %source%/hVHDL_dynamic_model_verification_library/simulator_utilities/write_pkg.vhd
ghdl -a --ieee=synopsys --std=08 hil_simulation/supply_model/pfc_model_pkg.vhd
ghdl -a --ieee=synopsys --std=08 hil_simulation/supply_model/boost_model_pkg.vhd

rem ghdl -a --ieee=synopsys --std=08 %source%/ecp5/ecp5_pll_wrapper.vhd
rem ghdl -a --ieee=synopsys --std=08 %source%/spartan_7/s7_specifics.vhd
rem ghdl -a --ieee=synopsys --std=08 %source%/spartan_7/s7_adc_wrapper.vhd
