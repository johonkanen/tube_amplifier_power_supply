library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.numeric_std.all;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ext_ad_spi3w is
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
end ext_ad_spi3w; 
 
 
architecture synth of ext_ad_spi3w is 

    constant c_convert : std_logic := '0';
    constant c_idle : std_logic := '1';
    signal clk_buffer : std_logic; 
    signal r_po_spi_cs : std_logic; 

    signal r_po_spi_rx : std_logic_vector(15 downto 0);

begin

    spi_control : process(si_spi_clk)
        variable spi_process_count : unsigned(7 downto 0);
        variable spi_clk_div : unsigned(7 downto 0);
    begin
        if rising_edge(si_spi_clk) then
            if si_rstn = '0' then
                r_po_spi_cs <= c_idle;
                po_spi_clk_out <= '1';
                clk_buffer <= '1';
                b_spi_rx <= (others => '0');
                r_po_spi_rx <= (others => '0');
                so_spi_rdy <= '0';
            else
                po_spi_clk_out <= clk_buffer;
                CASE r_po_spi_cs is
                    WHEN c_idle =>
                        so_spi_rdy <= '0';
                        spi_process_count := (others => '0');
                        spi_clk_div := (others => '0');

                        if si_spi_start = '1' then
                            r_po_spi_cs <= c_convert;
                            clk_buffer <= '0';
                        else
                            r_po_spi_cs <= c_idle;
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
                            -- r_b_spi_rx(i-2) <= pi_spi_serial;
                            r_po_spi_rx <= r_po_spi_rx(14 downto 0) & pi_spi_serial;
                        end if;

                        if spi_process_count = g_u8_clk_cnt*g_u8_clks_per_conversion-g_u8_clk_cnt/2 + 1 then
                            r_po_spi_cs <= c_idle;
                            so_spi_rdy <= '1';
                            b_spi_rx <= r_po_spi_rx;
                        else
                            r_po_spi_cs <= c_convert;
                            so_spi_rdy <= '0';
                        end if;

                    WHEN others =>
                        r_po_spi_cs <= c_idle;
                end CASE;
            end if;
        end if; --rising_edge
    end process spi_control;	
po_spi_cs <= r_po_spi_cs; 
s_spi_busy <= not r_po_spi_cs;
end synth; --architecture
