ghdl -a --ieee=synopsys ..\..\multiplier\sim_multiplier18x18.vhd
ghdl -a --ieee=synopsys ..\..\multiplier\multiplier_pkg.vhd
ghdl -a --ieee=synopsys ..\..\multiplier\multiplier.vhd
ghdl -a --ieee=synopsys tb_nr_div.vhd
ghdl -e --ieee=synopsys tb_nr_div
ghdl -r --ieee=synopsys tb_nr_div --vcd=tb_nr_div.vcd

IF %1 EQU 1 start "" gtkwave tb_nr_div.vcd
