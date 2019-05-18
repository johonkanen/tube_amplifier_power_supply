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
			so_spi_rdy	 : out std_logic; 
			-- output signal indicating sampling is done
			so_sh_rdy	 : out std_logic; 
			-- output buffer
			b_spi_rx : out std_logic_vector(15 downto 0)  
		);	
end ext_ad_spi3w; 
 
 
architecture synth of ext_ad_spi3w is 

	signal i : std_logic_vector(3 downto 0);
	signal route_spi_rx : std_logic_vector (0 to 15);
	signal route_spi_rx_buf : std_logic_vector(0 to 15); 
	 
	 
	signal r_spi_CS 		 : std_logic; 
	signal r_spi_clk_out 	 : std_logic; 
	signal r_spi_serial 	 : std_logic; 
	signal r_spi_rdy		 : std_logic;
	signal r_spi_busy : std_logic;

	--states
	type t_state is (idle,active,latch_data);
	signal r_pres_state, r_next_state : t_state;
	
begin
  
  
	r_pres_state <= r_next_state;-- receive data state 
	
receive_data: process(r_pres_state, si_spi_clk,si_spi_start)
    variable v_ad_cntr : unsigned(7 downto 0);
    variable v_spi_clk_out : std_logic;

    begin 
     
    if rising_edge(si_spi_clk) then
	    CASE r_pres_state is 
	    
		    WHEN idle =>				 
		    -- zero index 
			v_ad_cntr := 8d"0";
			v_spi_clk_out := '0';
			r_spi_rdy <= '0'; 
			i <=(others=>'0'); 
			r_spi_CS <= '1'; 
			so_sh_rdy <= '0';
			 
			 
			if si_spi_start = '1' then 
				r_next_state <= active; 
				r_spi_busy <= '1';
				 
			else 
				r_next_state <= idle; 
				r_spi_busy <= '0';
			end if; 
			    
		    WHEN active => 
				    r_spi_CS <= '0'; 
				    r_spi_busy <= '1';
				    r_spi_rdy <= '0'; 
					-- generate counter for spi clk control
				    if v_ad_cntr = 7 then
						v_ad_cntr := 8d"0";
				    else
						v_ad_cntr := v_ad_cntr + 1;
				    end if;

					-- signal sample and hold complete
					if v_ad_cntr = 4 and i = x"2"  then
						so_sh_rdy <= '1';
					else
						so_sh_rdy <= '0';
					end if;
				    
					-- read spi data from external ad converter
				    if v_ad_cntr > 3 then
						v_spi_clk_out := '1';
				    else
						v_spi_clk_out := '0';
				    end if;

				    if v_ad_cntr = 5 then
						route_spi_rx(to_integer(unsigned(i+2))) <= r_spi_serial;
						
						if i = x"d" then
							i<=x"0"; 
							r_next_state <= latch_data ;
							route_spi_rx_buf <= route_spi_rx; 
						else 
							r_next_state <= active;   
							i <= i + 1;
						end if; 
				    end if;
		    WHEN latch_data => 
				so_sh_rdy <= '0';
			    v_ad_cntr := 8d"0";
			    v_spi_clk_out := '0';
	     
			    r_spi_busy <= '1';
			    route_spi_rx_buf <= route_spi_rx; 
			    r_spi_CS <= '1'; 
			    r_next_state <= idle; 
			    r_spi_rdy <= '1'; 
			     
		    WHEN others => 
			    r_next_state <= idle;
	    end CASE; 
	    end if;
	    r_spi_clk_out <= v_spi_clk_out;
	end process receive_data;

-- route data
	b_spi_rx 	 <= route_spi_rx_buf; 
	 
-- route port	 
	po_spi_cs 	 <= r_spi_CS; 
	po_spi_clk_out  <= r_spi_clk_out; 
	r_spi_serial  <= pi_spi_serial; 
	s_spi_busy 	 <= not r_spi_CS; 
	so_spi_rdy	 <= r_spi_rdy;

	
end synth; --architecture
