ghdl -a --ieee=synopsys source/cyclone_10lp/cl10_specifics.vhd

ghdl -a --ieee=synopsys source/dsp/alu_routines_pkg.vhd
ghdl -a --ieee=synopsys source/dsp/rad4_inv16bit_pkg.vhd
ghdl -a --ieee=synopsys source/dsp/sin_cos16bit_pkg.vhd
ghdl -a --ieee=synopsys source/dsp/alu16bit_pkg.vhd


ghdl -a --ieee=synopsys source/top/system_control/component_interconnect/sw_supply_control/heater_ctrl/llc_modulator/llc_modulator_pkg.vhd
ghdl -a --ieee=synopsys source/top/system_control/component_interconnect/sw_supply_control/heater_ctrl/llc_pkg.vhd
ghdl -a --ieee=synopsys source/top/system_control/component_interconnect/sw_supply_control/dhb/dhb_pkg.vhd
ghdl -a --ieee=synopsys source/top/system_control/component_interconnect/sw_supply_control/pfc_ctrl/pfc_pkg.vhd

ghdl -a --ieee=synopsys source/top/system_control/component_interconnect/onboard_ad_control/ad_mux_control_pkg.vhd
ghdl -a --ieee=synopsys source/top/system_control/component_interconnect/onboard_ad_control/onboard_ad_control_pkg.vhd
ghdl -a --ieee=synopsys source/top/system_control/component_interconnect/onboard_ad_control/onboard_ad_control_internal_pkg.vhd
ghdl -a --ieee=synopsys source/top/system_control/component_interconnect/ext_ad/ad_bus_pkg.vhd

ghdl -a --ieee=synopsys source/top/system_control/component_interconnect/sw_supply_control/sw_supply_ctrl_pkg.vhd
ghdl -a --ieee=synopsys source/top/system_control/component_interconnect/uart/uart_pkg.vhd

ghdl -a --ieee=synopsys source/top/system_control/led_driver/led_driver_pkg.vhd

ghdl -a --ieee=synopsys source/top/system_control/component_interconnect/component_interconnect_pkg.vhd
ghdl -a --ieee=synopsys source/top/system_control/system_control_pkg.vhd

rem ghdl -a --ieee=synopsys source/ecp5/ecp5_pll_wrapper.vhd
rem ghdl -a --ieee=synopsys source/spartan_7/s7_specifics.vhd
rem ghdl -a --ieee=synopsys source/spartan_7/s7_adc_wrapper.vhd
