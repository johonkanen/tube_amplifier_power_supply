ghdl -a --std=08 --ieee=synopsys ext_ad_spi3w.vhd
ghdl -a --std=08 --ieee=synopsys spi3w_testbench.vhd
ghdl -e --std=08 --ieee=synopsys spi3w_testbench
ghdl -r --std=08 --ieee=synopsys spi3w_testbench --vcd=spi3w_testbench.vcd

gtkwave spi3w_testbench.vcd
