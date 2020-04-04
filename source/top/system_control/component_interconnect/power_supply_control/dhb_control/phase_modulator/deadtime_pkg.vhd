library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package deadtime_pkg is

    -- TODO, add utility library!
    subtype uint12 is integer range 0 to 2**12-1;

    type deadtime_clock_group is record
        modulator_clock : std_logic;
    end record;
    
    type deadtime_FPGA_output_group is record
        half_bridge_gates : std_logic_vector(1 downto 0);
    end record;
    
    type deadtime_data_input_group is record
        half_bridge_voltage : std_logic;
        deadtime_cycles : uint12;
    end record;

    component deadtime is
        port (
            deadtime_clocks : in deadtime_clock_group; 
            deadtime_FPGA_out : out deadtime_FPGA_output_group; 
            deadtime_data_in : in deadtime_data_input_group
        );
    end component deadtime;
    
    -- signal deadtime_clocks   : deadtime_clock_group;
    -- signal deadtime_FPGA_out : deadtime_FPGA_output_group;
    -- signal deadtime_data_in  : deadtime_data_input_group;
    
    -- u_deadtime : deadtime
    -- port map( deadtime_clocks,
    --	  deadtime_FPGA_out,
    --	  deadtime_data_in);
   
    

end package deadtime_pkg;