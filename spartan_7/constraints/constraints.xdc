create_clock -period 31.250 [get_ports xclk32mhz]
set_input_jitter [get_clocks -of_objects [get_ports xclk32mhz]] 0.313

# User Generated IO constraints

set_property IOSTANDARD LVCMOS33 [get_ports {po3_ada_muxsel[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po3_ada_muxsel[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po3_ada_muxsel[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po3_adb_muxsel[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po3_adb_muxsel[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po3_adb_muxsel[0]}]
set_property DRIVE 4 [get_ports {po3_ada_muxsel[2]}]
set_property DRIVE 4 [get_ports {po3_ada_muxsel[1]}]
set_property DRIVE 4 [get_ports {po3_ada_muxsel[0]}]
set_property DRIVE 4 [get_ports {po3_adb_muxsel[2]}]
set_property DRIVE 4 [get_ports {po3_adb_muxsel[1]}]
set_property DRIVE 4 [get_ports {po3_adb_muxsel[0]}]

# User Generated physical constraints

set_property PACKAGE_PIN H11 [get_ports xclk32mhz]

# User Generated IO constraints

set_property IOSTANDARD LVCMOS33 [get_ports pi_ada_sdata]
set_property IOSTANDARD LVCMOS33 [get_ports pi_adb_sdata]
set_property IOSTANDARD LVCMOS33 [get_ports pi_ext_ad1_sdata]
set_property IOSTANDARD LVCMOS33 [get_ports pi_ext_ad2_sdata]
set_property IOSTANDARD LVCMOS33 [get_ports pi_uart_rx]
set_property IOSTANDARD LVCMOS33 [get_ports po_ada_clk]
set_property IOSTANDARD LVCMOS33 [get_ports po_ada_cs]
set_property IOSTANDARD LVCMOS33 [get_ports po_adb_clk]
set_property IOSTANDARD LVCMOS33 [get_ports po_adb_cs]
set_property IOSTANDARD LVCMOS33 [get_ports po_bypass_relay]
set_property IOSTANDARD LVCMOS33 [get_ports po_ext_ad1_clk]
set_property IOSTANDARD LVCMOS33 [get_ports po_ext_ad1_cs]
set_property IOSTANDARD LVCMOS33 [get_ports po_ext_ad2_clk]
set_property IOSTANDARD LVCMOS33 [get_ports po_ext_ad2_cs]
set_property IOSTANDARD LVCMOS33 [get_ports po_uart_tx]
set_property IOSTANDARD LVCMOS33 [get_ports xclk32mhz]

# User Generated physical constraints

set_property PACKAGE_PIN A13 [get_ports po_ada_clk]
set_property PACKAGE_PIN B14 [get_ports po_ada_cs]
set_property PACKAGE_PIN D14 [get_ports po_adb_clk]
set_property PACKAGE_PIN E13 [get_ports po_adb_cs]
set_property PACKAGE_PIN C14 [get_ports pi_ada_sdata]
set_property PACKAGE_PIN F13 [get_ports pi_adb_sdata]
set_property PACKAGE_PIN B6 [get_ports {po3_adb_muxsel[0]}]
set_property PACKAGE_PIN A5 [get_ports {po3_adb_muxsel[1]}]
set_property PACKAGE_PIN B5 [get_ports {po3_adb_muxsel[2]}]
set_property PACKAGE_PIN B13 [get_ports {po3_ada_muxsel[0]}]
set_property PACKAGE_PIN A12 [get_ports {po3_ada_muxsel[1]}]
set_property PACKAGE_PIN A10 [get_ports {po3_ada_muxsel[2]}]
set_property PACKAGE_PIN H1 [get_ports po_bypass_relay]
set_property PACKAGE_PIN D2 [get_ports po_uart_tx]
set_property PACKAGE_PIN E2 [get_ports pi_uart_rx]
set_property PACKAGE_PIN P2 [get_ports po_ext_ad1_cs]
set_property PACKAGE_PIN L2 [get_ports pi_ext_ad1_sdata]
set_property PACKAGE_PIN J1 [get_ports po_ext_ad1_clk]
set_property PACKAGE_PIN L1 [get_ports po_ext_ad2_clk]
set_property PACKAGE_PIN M3 [get_ports po_ext_ad2_cs]
set_property PACKAGE_PIN J2 [get_ports pi_ext_ad2_sdata]




# User Generated physical constraints





# User Generated physical constraints





# User Generated IO constraints

set_property IOSTANDARD LVCMOS33 [get_ports {po4_ht_pwm[sync1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po4_ht_pwm[sync2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po4_ht_pwm[pri_low]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po4_ht_pwm[pri_high]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po4_dhb_pwm[sec_low]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po4_dhb_pwm[sec_high]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po4_dhb_pwm[pri_low]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po4_dhb_pwm[pri_high]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po3_led3[red]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po3_led3[green]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po3_led3[blue]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po3_led2[red]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po3_led2[green]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po3_led2[blue]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po3_led1[red]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po3_led1[green]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po3_led1[blue]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po2_pfc_pwm[ac2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {po2_pfc_pwm[ac1]}]

# User Generated physical constraints

set_property PACKAGE_PIN G1 [get_ports {po2_pfc_pwm[ac1]}]
set_property PACKAGE_PIN A4 [get_ports {po2_pfc_pwm[ac2]}]
set_property PACKAGE_PIN D13 [get_ports {po3_led1[blue]}]
set_property PACKAGE_PIN G14 [get_ports {po3_led1[green]}]
set_property PACKAGE_PIN H13 [get_ports {po3_led2[blue]}]
set_property PACKAGE_PIN J12 [get_ports {po3_led2[green]}]
set_property PACKAGE_PIN J14 [get_ports {po3_led3[blue]}]
set_property PACKAGE_PIN L14 [get_ports {po3_led3[green]}]
set_property PACKAGE_PIN P5 [get_ports {po4_dhb_pwm[pri_high]}]
set_property PACKAGE_PIN P4 [get_ports {po4_dhb_pwm[pri_low]}]
set_property PACKAGE_PIN N1 [get_ports {po4_dhb_pwm[sec_high]}]
set_property PACKAGE_PIN M1 [get_ports {po4_dhb_pwm[sec_low]}]
set_property PACKAGE_PIN P3 [get_ports {po4_ht_pwm[pri_high]}]
set_property PACKAGE_PIN N4 [get_ports {po4_ht_pwm[pri_low]}]
set_property PACKAGE_PIN M2 [get_ports {po4_ht_pwm[sync1]}]
set_property PACKAGE_PIN L3 [get_ports {po4_ht_pwm[sync2]}]




# User Generated physical constraints 

set_property PACKAGE_PIN F14 [get_ports {po3_led1[red]}]
set_property PACKAGE_PIN H14 [get_ports {po3_led2[red]}]
set_property PACKAGE_PIN J13 [get_ports {po3_led3[red]}]

# Vivado Generated miscellaneous constraints 

#revert back to original instance
current_instance -quiet
