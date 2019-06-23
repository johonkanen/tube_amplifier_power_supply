open_hw
connect_hw_server -url localhost:3121
open_hw_target

# Program and Refresh the Device

current_hw_device [lindex [get_hw_devices] 0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices] 0]
set_property PROGRAM.FILE {./output/testibitstream.bit} [lindex [get_hw_devices] 0]

program_hw_devices [lindex [get_hw_devices] 0]
# refresh_hw_device [lindex [get_hw_devices] 0]
disconnect_hw_server
