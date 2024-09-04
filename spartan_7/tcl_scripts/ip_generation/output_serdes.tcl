create_ip -name selectio_wiz -vendor xilinx.com -library ip -version 5.1 -module_name test_output_serdes
set_property -dict [list \
  CONFIG.BUS_DIR {OUTPUTS} \
  CONFIG.BUS_IO_STD {LVCMOS33} \
  CONFIG.CLK_EN {false} \
  CONFIG.CLK_FWD_IO_STD {LVCMOS33} \
  CONFIG.SELIO_ACTIVE_EDGE {DDR} \
  CONFIG.SELIO_BUS_IN_DELAY {NONE} \
  CONFIG.SELIO_CLK_BUF {MMCM} \
  CONFIG.SELIO_CLK_IO_STD {LVCMOS33} \
  CONFIG.SELIO_INTERFACE_TYPE {NETWORKING} \
  CONFIG.SELIO_ODDR_ALIGNMENT {SAME_EDGE} \
  CONFIG.SERIALIZATION_FACTOR {4} \
  CONFIG.SYSTEM_DATA_WIDTH {1} \
  CONFIG.USE_SERIALIZATION {true} \
] [get_ips test_output_serdes]

generate_ip_module test_output_serdes
