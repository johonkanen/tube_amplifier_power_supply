library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.numeric_std.all;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
	use work.ad_bus_pkg.all;

entity ad_bus_driver is
	generic(
				g_u8_clk_cnt : unsigned(7 downto 0);
				g_u8_clks_per_conversion : unsigned(7 downto 0);
				g_sh_counter_latch : unsigned(7 downto 0)
			);
    port(
	    ad_clock : in std_logic;
	    --ad converter physical signals
	    po_spi_cs 	 : out std_logic;
	    po_spi_clk_out : out std_logic;
	    pi_spi_serial : in std_logic; 

	    --sequencer control signal
	    so_sh_rdy : out std_logic;

	    so_bus_rdy : out std_logic;

	    so_std17_ad_bus : out std_logic_vector(16 downto 0);
	    ti_ad_triggers : in t_ad_triggers
	);
end ad_bus_driver;


architecture rtl of ad_bus_driver is

signal r_si_spi_start : std_logic;
signal r_s_spi_busy : std_logic; 
signal r_s_spi_rdy : std_logic; 
signal r_so_sh_rdy : std_logic; 
signal r_b_spi_rx : std_logic_vector(15 downto 0);
signal r_so_std17_ad_bus : std_logic_vector(16 downto 0);

signal r_so_bus_rdy : std_logic; 

signal r1_si_bus_ack : std_logic;
signal r2_si_bus_ack : std_logic;
signal ad_address : std_logic_vector(2 downto 0);

begin

ad_spi_driver : ext_ad_spi3w 
    generic map(g_u8_clk_cnt,g_u8_clks_per_conversion,g_sh_counter_latch)
    port map( 
	    si_spi_clk => ad_clock,
	    -- physical signals to ext ad converter
	    po_spi_cs => po_spi_cs, 
	    po_spi_clk_out => po_spi_clk_out,
	    pi_spi_serial => pi_spi_serial, 
	    -- spi driver control signals
	    si_spi_start => r_si_spi_start,
	    s_spi_busy	=> r_s_spi_busy,
	    -- output signal indicating word is ready to be read 
	    so_spi_rdy => r_s_spi_rdy,
	    -- output signal indicating sampling is done
	    so_sh_rdy => so_sh_rdy,
	    -- output buffer
	    b_spi_rx => r_b_spi_rx
	);

	ada_mux_control : process(ad_clock) is
	    type t_ad_dly_states is (idle, conv, drive_data_bus, data_transfer_rdy);
	    variable st_ad_dly : t_ad_dly_states;
	begin
	    if rising_edge(ad_clock) then

		CASE st_ad_dly is
			WHEN idle => 
			    CASE ti_ad_triggers is
                    WHEN ch0 =>
                        r_si_spi_start <= '1';
                        st_ad_dly := conv;
                    WHEN ch1 =>
                        r_si_spi_start <= '1';
                        ad_address <= 3d"2";
                        st_ad_dly := conv;
                    WHEN ch2 =>
                        r_si_spi_start <= '1';
                        ad_address <= 3d"3";
                        st_ad_dly := conv;
                    WHEN ch3 =>
                        r_si_spi_start <= '1';
                        ad_address <= 3d"4";
                        st_ad_dly := conv;
                    WHEN ch4 =>
                        r_si_spi_start <= '1';
                        ad_address <= 3d"5";
                        st_ad_dly := conv;
                    WHEN ch5 =>
                        r_si_spi_start <= '1';
                        ad_address <= 3d"6";
                        st_ad_dly := conv;
                    WHEN ch6 =>
                        r_si_spi_start <= '1';
                        ad_address <= 3d"7";
                        st_ad_dly := conv;
                    WHEN inactive => 
                        -- do nothing
                        r_si_spi_start <= '0';
                        ad_address <= 3d"0";
                        st_ad_dly := idle;
                    WHEN others => 
                        --error
                        ad_address <= 3d"0";
                        st_ad_dly := idle;
			    end CASE;

				r_so_std17_ad_bus <= (others =>'0');
                r_so_bus_rdy <= '0';
			WHEN conv =>
                r_si_spi_start <= '0';
			    if r_s_spi_rdy = '1' then
					st_ad_dly := idle;
                    r_so_bus_rdy <= '1';
					r_so_std17_ad_bus(13 downto 0) <= r_b_spi_rx(13 downto 0);
					r_so_std17_ad_bus(16 downto 14)<= ad_address;
			    else
                    r_so_bus_rdy <= '0';
					st_ad_dly := conv;
					r_so_std17_ad_bus <= (others =>'0');
			    end if;
			    
			WHEN others =>
                r_si_spi_start <= '0';
				st_ad_dly := idle;
		end CASE;

            so_std17_ad_bus <= r_so_std17_ad_bus;
            so_bus_rdy <= r_so_bus_rdy;
	    end if;
	end process ada_mux_control;

end rtl;
