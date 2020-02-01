library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package max_11115_pkg is

    type max_11115_clock_group is record
        adc_clock : std_logic;
        reset_n : std_logic;
    end record;
    
    type max_11115_FPGA_input_group is record
        adc_serial_data : std_logic;
    end record;
    
    type max_11115_FPGA_output_group is record
        adc_chip_select : std_logic;
        adc_spi_clock : std_logic;
    end record;
    
    type max_11115_data_input_group is record
        adc_conversion_requested : boolean;
    end record;
    
    type max_11115_data_output_group is record
        adc_conversion_is_done : boolean;
        adc_measurement_data : integer range 0 to 2**16-1;
    end record;
    
    component max_11115 is
        generic (
            g_adc_clock_divisor : integer;
            g_adc_clocks_in_conversion : integer;
            g_adc_clocks_in_frame : integer;
            g_adc_read_delay_in_clocks : integer
        );
        port (
            max_11115_clocks : in max_11115_clock_group;
    
            max_11115_FPGA_in : in max_11115_FPGA_input_group;
            max_11115_FPGA_out : out max_11115_FPGA_output_group;
    
            max_11115_data_in : in max_11115_data_input_group;
            max_11115_data_out : out max_11115_data_output_group
        );
    end component max_11115;

------------------------------------------------------------------------
    procedure start_adc ( signal adc : out max_11115_data_input_group);
------------------------------------------------------------------------         
    procedure idle_adc ( signal adc : out max_11115_data_input_group);
------------------------------------------------------------------------         
end package max_11115_pkg;

package body max_11115_pkg is
------------------------------------------------------------------------
    procedure start_adc ( signal adc : out max_11115_data_input_group) is
    begin 
        adc.adc_conversion_requested <= true; 
    end start_adc;
------------------------------------------------------------------------
    procedure idle_adc ( signal adc : out max_11115_data_input_group) is
    begin 
        adc.adc_conversion_requested <= false; 
    end idle_adc;
------------------------------------------------------------------------
end package body max_11115_pkg;
