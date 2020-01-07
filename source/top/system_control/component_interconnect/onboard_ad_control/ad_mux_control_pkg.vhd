library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package ad_mux_control_pkg is
    type ad_mux_control_clock_group is record
        clock : std_logic;
    end record;
    
    type ad_mux_control_FPGA_output_group is record
        ad_mux_channel : std_logic_vector(2 downto 0);
    end record;
    
    type ad_mux_control_data_input_group is record
        ad_sh_is_ready : boolean;
        ad_mux_position : integer;
    end record;
    
    type ad_mux_control_data_output_group is record
        ad_data_is_ready : boolean;
        ad_channel : integer;
    end record;
    
    component ad_mux_control is
        port (
            ad_mux_control_clocks : in ad_mux_control_clock_group;
    
            ad_mux_control_FPGA_out : out ad_mux_control_FPGA_output_group;
    
            ad_mux_control_data_in : in ad_mux_control_data_input_group;
            ad_mux_control_data_out : out ad_mux_control_data_output_group
        );
    end component ad_mux_control;
        
    component adc_wrapper is
        port( 
                si_spi_clk 	 : in std_logic; 
                si_pll_lock : in std_logic;
                 
                -- physical signals to ext ad converter
                po_spi_cs 	 : out std_logic;
                po_spi_clk_out : out std_logic;
                pi_spi_serial : in std_logic; 
     
                si_spi_start : in std_logic; 
                 
                -- ext spi control signals
                s_spi_busy	 : out std_logic; 
                -- output signal indicating word is ready to be read 
                so_spi_rdy	 : out std_logic; 
                -- output signal indicating sampling is done
                so_sh_rdy	 : out std_logic; 
                -- output buffer
                b_spi_rx : out std_logic_vector(15 downto 0)  
            );	
    end component; 

end package ad_mux_control_pkg;
