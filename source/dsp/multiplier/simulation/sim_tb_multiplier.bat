ghdl -a --std=08 --ieee=synopsys ..\multiplier_pkg.vhd
ghdl -a --std=08 --ieee=synopsys ..\multiplier.vhd
ghdl -a --std=08 --ieee=synopsys tb_multiplier.vhd
ghdl -e --std=08 --ieee=synopsys tb_multiplier
ghdl -r --std=08 --ieee=synopsys tb_multiplier --vcd=tb_multiplier.vcd

rem gtkwave tb_multiplier.vcd
