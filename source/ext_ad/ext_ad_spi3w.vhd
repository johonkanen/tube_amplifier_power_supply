library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.numeric_std.all;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ext_ad_spi3w is
	generic(
				g_u8_clk_cnt : unsigned(7 downto 0);
				g_u8_clks_per_conversion : unsigned(7 downto 0);
				g_sh_counter_latch : unsigned(7 downto 0)
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
end ext_ad_spi3w; 
 
 
architecture synth of ext_ad_spi3w is 

    signal clock_count : unsigned(3 downto 0); 
    signal spi_rx_buffer : std_logic_vector(15 downto 0);
    constant c_convert : std_logic := '0';
    constant c_idle : std_logic := '1';
    signal i : integer range 0 to 31;
    signal clk_buffer : std_logic;

begin

    spi_control : process(si_spi_clk)
        variable spi_process_count : unsigned(7 downto 0);
        variable spi_clk_div : unsigned(7 downto 0);
    begin
        if rising_edge(si_spi_clk) then
            po_spi_clk_out <= clk_buffer;
            if si_rstn = '1' then
                CASE po_spi_cs is
                    WHEN c_idle =>
                        so_spi_rdy <= '0';
                        spi_process_count := (others => '0');
                        spi_clk_div := (others => '0');
                        i <= to_integer(g_u8_clks_per_conversion)+1;
                        b_spi_rx <= (others => '0');  

                        if si_spi_start = '1' then
                            po_spi_cs <= c_convert;
                            clk_buffer <= '0';
                        else
                            po_spi_cs <= c_idle;
                            clk_buffer <= '1';
                        end if;
                    WHEN c_convert =>
                        spi_process_count := spi_process_count + 1;
                        
                        --indicate sample and hold being ready
                        if spi_process_count = g_sh_counter_latch then
                            so_sh_rdy <= '1';
                        else
                            so_sh_rdy <= '0';
                        end if;

                        if spi_clk_div = g_u8_clk_cnt-1 then
                            spi_clk_div := (others => '0');
                            clk_buffer <= not clk_buffer;
                        else
                            spi_clk_div := spi_clk_div + 1;
                        end if;

                        if spi_clk_div = g_u8_clk_cnt/2 then
                            clk_buffer <= not clk_buffer;
                            b_spi_rx(i-2) <= pi_spi_serial;
                            i <= i - 1;
                        end if;

                        if spi_process_count = g_u8_clk_cnt*g_u8_clks_per_conversion-g_u8_clk_cnt/2+2 then
                            po_spi_cs <= c_idle;
                            so_spi_rdy <= '1';
                        else
                            po_spi_cs <= c_convert;
                            so_spi_rdy <= '0';
                        end if;

                    WHEN others =>
                        po_spi_cs <= c_idle;
                end CASE;
            else
                po_spi_cs <= '1';
                clk_buffer <= '1';
                b_spi_rx <= (others => '0');
            end if;
        end if; --rising_edge
    end process spi_control;	

s_spi_busy <= not po_spi_cs;
end synth; --architecture
