LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY spi3w_ads7056_driver_tb IS 
END ; 
 
ARCHITECTURE testi   OF spi3w_ads7056_driver_tb IS
  SIGNAL so_spi_rdy   :  STD_LOGIC  ; 
  SIGNAL s_spi_busy   :  STD_LOGIC  ; 
  SIGNAL si_spi_start   :  STD_LOGIC  ; 
  SIGNAL si_spi_clk   :  STD_LOGIC  ; 
  SIGNAL b_spi_rx   :  STD_LOGIC_VECTOR (15 downto 0)  ; 
  SIGNAL so_sh_rdy   :  STD_LOGIC  ; 
  SIGNAL po_spi_clk_out   :  STD_LOGIC  ; 
  SIGNAL pi_spi_serial   :  STD_LOGIC  ; 
  SIGNAL po_spi_cs   :  STD_LOGIC  ; 
  COMPONENT spi3w_ads7056_driver
	generic(
				g_u8_clk_cnt : unsigned(7 downto 0);
				g_u8_clks_per_conversion : unsigned(7 downto 0);
				g_sh_counter_latch : unsigned(7 downto 0)
			);
    PORT ( 
      so_spi_rdy  : out STD_LOGIC ; 
      s_spi_busy  : out STD_LOGIC ; 
      si_spi_start  : in STD_LOGIC ; 
      si_spi_clk  : in STD_LOGIC ; 
      b_spi_rx  : out STD_LOGIC_VECTOR (15 downto 0) ; 
      so_sh_rdy  : out STD_LOGIC ; 
      po_spi_clk_out  : out STD_LOGIC ; 
      pi_spi_serial  : in STD_LOGIC ; 
      po_spi_cs  : out STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : spi3w_ads7056_driver
  generic map(8d"2",8d"18",8d"18")
    PORT MAP ( 
      so_spi_rdy   => so_spi_rdy  ,
      s_spi_busy   => s_spi_busy  ,
      si_spi_start   => si_spi_start  ,
      si_spi_clk   => si_spi_clk  ,
      b_spi_rx   => b_spi_rx  ,
      so_sh_rdy   => so_sh_rdy  ,
      po_spi_clk_out   => po_spi_clk_out  ,
      pi_spi_serial   => pi_spi_serial  ,
      po_spi_cs   => po_spi_cs   ) ; 



-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 1 us, Period = 4 ns
  Process
	Begin
	 si_spi_clk  <= '0'  ;
	wait for 2 ns ;
-- 2 ns, single loop till start period.
	for Z in 1 to 250
	loop
	    si_spi_clk  <= '1'  ;
	   wait for 2 ns ;
	    si_spi_clk  <= '0'  ;
	   wait for 2 ns ;
-- 98 ns, repeat pattern in loop.
	end  loop;
	 si_spi_clk  <= '1'  ;
	wait for 2 ns ;
-- dumped values till 100 ns
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  Process
	Begin
	 pi_spi_serial  <= '1'  ;
	wait for 1000 ns ;
-- dumped values till 100 ns
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  Process
	Begin
	 si_spi_start  <= '0'  ;
	wait for 10 ns ;
	 si_spi_start  <= '1'  ;
	wait for 10 ns ;
	 si_spi_start  <= '0'  ;
	wait for 500 ns ;
	 si_spi_start  <= '1'  ;
	wait for 10 ns ;
	 si_spi_start  <= '0'  ;
	wait for 1000 ns ;
-- dumped values till 100 ns
	wait;
 End Process;
END;
