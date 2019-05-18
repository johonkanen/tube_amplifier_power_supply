ghdl -a --std=08 --ieee=synopsys spi3w_ads7056_driver.vhd
ghdl -a --std=08 --ieee=synopsys spi3w_ads7056_driver_tb.vhd
ghdl -e --std=08 --ieee=synopsys spi3w_ads7056_driver_tb
ghdl -r --std=08 --ieee=synopsys spi3w_ads7056_driver_tb --vcd=spi3w_ads7056_driver_tb.vcd

gtkwave spi3w_ads7056_driver_tb.vcd
