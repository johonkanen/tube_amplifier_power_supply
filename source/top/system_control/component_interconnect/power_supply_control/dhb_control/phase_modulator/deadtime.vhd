library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.deadtime_pkg.all;


entity deadtime is
    port (
        deadtime_clocks : in deadtime_clock_group; 
        deadtime_FPGA_out : out deadtime_FPGA_output_group; 
        deadtime_data_in : in deadtime_data_input_group
    );
end entity;

architecture rtl of deadtime is

    

begin



end rtl;

