library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.numeric_std.all;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity spi3w_ads7056_driver is
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
end spi3w_ads7056_driver; 
 
 
architecture synth of spi3w_ads7056_driver is 

    signal clock_count : unsigned(3 downto 0); 
    signal spi_rx_buffer : std_logic_vector(17 downto 0);
    constant c_convert : std_logic := '0';
    constant c_idle : std_logic := '1';
    signal i : integer range 0 to 31;
    subtype t_ad_states is std_logic_vector(1 downto 0);
    constant t_idle : t_ad_states := "00";
    constant t_calibrate : t_ad_states := "11";
    constant t_convert : t_ad_states := "10";
    signal st_ad_states : t_ad_states;
    signal r_po_spi_clk_out : std_logic; 
    signal r_po_spi_cs : std_logic; 

    type ctrl_ad_spi3w is record
			-- ext spi control signals
			ad_busy : std_logic;
			-- output signal indicating word is ready to be read 
			ad_rdy : std_logic;
			-- output signal indicating sampling is done
			sh_rdy :  std_logic; 
			-- output buffer
			ad_data : std_logic_vector(17 downto 0);
    end record;

begin
    spi_control : process(si_spi_clk)
        variable spi_process_count : unsigned(11 downto 0);
        variable spi_clk_div : unsigned(7 downto 0);
    begin
        if rising_edge(si_spi_clk) then
            if si_pll_lock = '1' then
                CASE st_ad_states is
                    WHEN t_calibrate =>
                        so_sh_rdy <= '0';
                        so_spi_rdy <= '0';
                        spi_rx_buffer <= (others => '0');  

                        spi_process_count := spi_process_count + 1;

                        if spi_clk_div = g_u8_clk_cnt-1 then
                            spi_clk_div := (others => '0');
                            r_po_spi_clk_out <= not r_po_spi_clk_out;
                        else
                            spi_clk_div := spi_clk_div + 1;
                        end if;

                        if spi_clk_div = g_u8_clk_cnt/2 then
                            r_po_spi_clk_out <= not r_po_spi_clk_out;
                            spi_rx_buffer(i-2) <= pi_spi_serial;
                            i <= i - 1;
                        end if;

                        if spi_process_count = g_u8_clk_cnt*to_unsigned(24,8)-g_u8_clk_cnt/2 then
                            st_ad_states <= t_idle;
                            --po_spi_cs <= c_idle;
                        else
                            st_ad_states <= t_calibrate;
                            --po_spi_cs <= c_convert;
                        end if;

                    WHEN t_idle =>
                        so_spi_rdy <= '0';
                        spi_process_count := (others => '0');
                        spi_clk_div := (others => '0');
                        i <= (g_u8_clks_per_conversion)+1;
                        --spi_rx_buffer <= (others => '0');  
                        so_sh_rdy <= '0';

                        if si_spi_start = '1' then
                            st_ad_states <= t_convert;
                            --po_spi_cs <= c_convert;
                            r_po_spi_clk_out <= '0';
                        else
                            st_ad_states <= t_idle;
                            --po_spi_cs <= c_idle;
                            r_po_spi_clk_out <= '1';
                        end if;
                    WHEN t_convert =>
                        spi_process_count := spi_process_count + 1;
                        
                        --indicate sample and hold being ready
                        if spi_process_count = g_sh_counter_latch then
                            so_sh_rdy <= '1';
                        else
                            so_sh_rdy <= '0';
                        end if;

                        if spi_clk_div = g_u8_clk_cnt-1 then
                            spi_clk_div := (others => '0');
                            r_po_spi_clk_out <= not r_po_spi_clk_out;
                        else
                            spi_clk_div := spi_clk_div + 1;
                        end if;

                        if spi_clk_div = g_u8_clk_cnt/2 then
                            r_po_spi_clk_out <= not r_po_spi_clk_out;
                            spi_rx_buffer(i-2) <= pi_spi_serial;
                            i <= i - 1;
                        end if;

                        if spi_process_count = g_u8_clk_cnt*g_u8_clks_per_conversion-g_u8_clk_cnt/2 then
                            st_ad_states <= t_idle;
                            --po_spi_cs <= c_idle;
                            so_spi_rdy <= '1';
                        else
                            st_ad_states <= t_convert;
                            --po_spi_cs <= c_convert;
                            so_spi_rdy <= '0';
                        end if;

                    WHEN others =>
                        spi_clk_div := (others => '0');
                        spi_process_count := (others => '0');
                        i <= (g_u8_clks_per_conversion)+1;
                        spi_rx_buffer <= (others => '0');  
                        r_po_spi_clk_out <= '1';
                        so_sh_rdy <= '0';
                        so_spi_rdy <= '0';
                        st_ad_states <= t_calibrate;
                        --po_spi_cs <= c_idle;
                end CASE;
            else
                spi_clk_div := (others => '0');
                spi_process_count := (others => '0');
                i <= (g_u8_clks_per_conversion)+1;
                spi_rx_buffer <= (others => '0');  
                r_po_spi_clk_out <= '1';
                so_sh_rdy <= '0';
                so_spi_rdy <= '0';
                st_ad_states <= t_calibrate;
                --po_spi_cs <= c_idle;
            end if;
        end if; --rising_edge
    end process spi_control;	
po_spi_clk_out <= r_po_spi_clk_out;
b_spi_rx <= spi_rx_buffer(17 downto 2);
s_spi_busy <= st_ad_states(1);
po_spi_cs <= NOT st_ad_states(1);
end synth; --architecture
