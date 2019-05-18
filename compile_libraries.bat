ghdl -a --std=08 --ieee=synopsys source/ext_ad/ad_bus_pkg.vhd 
ghdl -a --std=08 --ieee=synopsys source/system_control/sys_ctrl_pkg.vhd
ghdl -a --std=08 --ieee=synopsys --work=dhb_lib source/dhb/dhb_pkg.vhd
ghdl -a --std=08 --ieee=synopsys --work=onboard_ad_ctrl_lib source/onboard_ad_control/onboard_ad_ctrl_pkg.vhd
