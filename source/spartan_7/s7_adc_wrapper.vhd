library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity adc_wrapper is
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
end entity; 

architecture rtl of adc_wrapper is

component ext_ad_spi3w is
	generic(
				g_u8_clk_cnt : integer;
				g_u8_clks_per_conversion : integer;
				g_sh_counter_latch : integer
			);
	port( 
		si_spi_clk 	 : in std_logic; 
        si_rstn : in std_logic;
		 
		-- physical signals to ext ad converter
		po_spi_cs 	 : out std_logic;
		po_spi_clk_out : out std_logic;
		pi_spi_serial : in std_logic; 

		si_spi_start	 : in std_logic; 
		 
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



component spi3w_ads7056_driver is
	generic(
				g_u8_clk_cnt : integer;
				g_u8_clks_per_conversion : integer;
				g_sh_counter_latch : integer
			);
	port( 
			si_spi_clk 	 : in std_logic; 
            si_pll_lock : in std_logic;
			 
			-- physical signals to ext ad converter
			po_spi_cs 	 : out std_logic;
			po_spi_clk_out : out std_logic;
			pi_spi_serial : in std_logic; 
 
			si_spi_start	 : in std_logic; 
			 
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

signal s16_spi_data : std_logic_vector(15 downto 0); 

begin

onboard_adc : ext_ad_spi3w
    generic map(4,14,9)
    port map(
			si_spi_clk,
            si_pll_lock,
			po_spi_cs,
			po_spi_clk_out,
			pi_spi_serial, 
			si_spi_start,
			s_spi_busy,
			so_spi_rdy,
			so_sh_rdy,
			s16_spi_data);

b_spi_rx <= std_logic_vector(shift_left(unsigned(s16_spi_data),3));

end rtl;
