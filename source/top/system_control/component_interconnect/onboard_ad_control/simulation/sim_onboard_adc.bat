rem simulate onboard_adc.vhd
ghdl -a --ieee=synopsys --work=onboard_adc_library ../../../../..//top/system_control/component_interconnect/onboard_ad_control/onboard_ad_control_pkg.vhd
ghdl -a --ieee=synopsys --work=onboard_adc_library ../../../../..//top/system_control/component_interconnect/onboard_ad_control/onboard_ad_control_internal_pkg.vhd
ghdl -a --ieee=synopsys ..\..\..\..\..\cyclone_10lp\cl10_adc_wrapper.vhd
ghdl -a --ieee=synopsys ..\..\ext_ad\ext_ad_spi3w.vhd
ghdl -a --ieee=synopsys tb_onboard_adc.vhd
ghdl -e --ieee=synopsys tb_onboard_adc
ghdl -r --ieee=synopsys tb_onboard_adc --vcd=tb_onboard_adc.vcd


IF %1 EQU 1 start "" gtkwave tb_onboard_adc.vcd
