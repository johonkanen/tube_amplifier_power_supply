library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.numeric_std.all;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ext_ad_spi3w is
	port( 
			si_spi_clk 	 : in std_logic; 
			 
			-- physical signals to ext ad converter
			po_spi_cs 	 : out std_logic;
			po_spi_clk_out : out std_logic;
			pi_spi_serial : in std_logic; 
 
			si_spi_start	 : in std_logic; 
			 
			 
			-- ext spi control signals
			s_spi_busy	 : out std_logic; 
			-- output signal indicating word is ready to be read 
			s_spi_rdy	 : out std_logic; 
			-- output signal indicating sampling is done
			so_sh_rdy	 : out std_logic; 
			-- output buffer
			b_spi_rx : out std_logic_vector(15 downto 0)  
		);	
end ext_ad_spi3w; 
 
 
architecture synth of ext_ad_spi3w is 

	signal route_spi_rx : std_logic_vector (0 to 15);
	signal route_spi_rx_buf : std_logic_vector(0 to 15); 
	 
	constant sh_counter_latch : unsigned(7 downto 0) := 8d"14";
	constant spi_clock_cycles : unsigned(7 downto 0) := 8d"14";
	 
	signal r_spi_CS 		 : std_logic; 
	signal r_spi_clk_out 	 : std_logic; 
	signal r_spi_serial 	 : std_logic; 
	signal r_spi_rdy		 : std_logic;
	signal r_spi_busy : std_logic;

	--states
	
begin
  
receive_data: process(r_pres_state, si_spi_clk,si_spi_start)
    variable v_ad_cntr : unsigned(7 downto 0);
	variable v_clock_cnt : unsigned(7 downto 0);
    variable v_spi_clk_out : std_logic;
	type spi_ad_states is (idle,
							conv,
							read_ad,
							latch_data
							);
	variable st_spi_ad_states : spi_ad_states;
    begin 
     
    if rising_edge(si_spi_clk) then
	    CASE st_spi_ad_states is 
		    WHEN idle =>				 
		    -- zero index 
			v_ad_cntr := 8d"0";
			r_spi_rdy <= '0'; 
			v_clock_cnt :=(others=>'0'); 
			r_spi_CS <= '1'; 
			v_spi_clk_out := '0';

			if si_spi_start = '1' then 
				st_spi_ad_states <= conv; 
				r_spi_busy <= '1';
			else 
				r_next_state <= idle; 
				r_spi_busy <= '0';
			end if; 
			    
		    WHEN conv => 
				    r_spi_CS <= '0'; 
				    r_spi_busy <= '1';
				    r_spi_rdy <= '0'; 
					v_spi_clk_out := '0';
					v_ad_cntr := v_ad_cntr + 1;

					if v_ad_cntr = 3 then
						st_spi_ad_states := read_ad; 
				    else
						st_spi_ad_states := conv; 
				    end if;

		    WHEN read_ad => 
					v_spi_clk_out := '1';

					v_ad_cntr := v_ad_cntr - 1;

					-- generate counter for spi clk control
					CASE v_ad_cntr is
						WHEN v_ad_cntr = 8d"3" =>
							route_spi_rx(to_integer(unsigned(i+2))) <= r_spi_serial;
							v_clock_cnt = v_clock_cnt + 1;
							if v_clock_cnt = spi_clock_cycles then
								st_spi_ad_states := latch_data; 
							else 
								st_spi_ad_states := conv; 
							end if;
						WHEN others =>
						st_spi_ad_states := conv; 
					end CASE;

		    WHEN latch_data => 
			    v_ad_cntr := 8d"0";
			    v_spi_clk_out := '0';
	     
			    r_spi_busy <= '1';
			    r_spi_CS <= '1'; 
			    r_next_state <= idle; 
			    r_spi_rdy <= '1'; 
			     
		    WHEN others => 
			    r_next_state <= idle;
	    end CASE; 
	    r_spi_clk_out <= v_spi_clk_out;
	    end if;
	end process receive_data;

	sh_completed : process(si_spi_clk)
		variable sh_counter : unsigned(7 downto 0);
	begin
		if rising_edge(si_spi_clk)
			if r_spi_CS = '0' then
					-- signal sample and hold complete
					if sh_counter = sh_counter_latch then
						so_sh_rdy <= '1';
					else
						so_sh_rdy <= '0';
						sh_counter := sh_counter + 1;
					end if;
				else
					so_sh_rdy <= '0';
					sh_counter := 8d"0";
				end if;
			end if;
		end if;
	end process sh_completed;
-- route data
	b_spi_rx 	 <= route_spi_rx_buf; 
	 
-- route port	 
	po_spi_cs 	 <= r_spi_CS; 
	po_spi_clk_out  <= r_spi_clk_out; 
	r_spi_serial  <= pi_spi_serial; 
	s_spi_busy 	 <= not r_spi_CS; 
	s_spi_rdy	 <= r_spi_rdy;

	
end synth; --architecture
