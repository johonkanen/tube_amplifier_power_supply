library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.vendor_specifics_pkg.all;

entity top is
    port(
-- main clock input
	    xclk32mhz : in std_logic;

-- relay bypass
	    po_bypass_relay : out std_logic;	

-- PFC pwm
	    po2_pfc_pwm : out std_logic_vector(1 downto 0);

-- heater pwm
	    po2_ht_pri_pwm : out std_logic_vector(1 downto 0);
	    po2_ht_sec_pwm : out std_logic_vector(1 downto 0);

-- DBH pwm
	    po2_DHB_pri_pwm : out std_logic_vector(1 downto 0);
	    po2_DHB_sec_pwm : out std_logic_vector(1 downto 0);
			
-- uart rx and tx
	    pi_uart_rx : in std_logic;
	    po_uart_tx : out std_logic;

-- ad converter A signals
	    po_ada_cs : out std_logic;
	    po_ada_clk : out std_logic;
	    pi_ada_sdata : in std_logic;
	    po3_ada_muxsel : out std_logic_vector(2 downto 0);

-- ad converter B signals
	    po_adb_cs : out std_logic;
	    po_adb_clk : out std_logic;
	    pi_adb_sdata : in std_logic;
	    po3_adb_muxsel : out std_logic_vector(2 downto 0);

-- ext ad converter 1 signals
	    po_ext_ad1_cs : out std_logic;
	    po_ext_ad1_clk : out std_logic;
	    pi_ext_ad1_sdata : in std_logic;

-- ext ad converter 2 signals
	    po_ext_ad2_cs : out std_logic;
	    po_ext_ad2_clk : out std_logic;
	    pi_ext_ad2_sdata : in std_logic;

-- rgb status leds driver signals, active low
	    po3_led1 : out std_logic_vector(2 downto 0);
	    po3_led2 : out std_logic_vector(2 downto 0);
	    po3_led3 : out std_logic_vector(2 downto 0)
        );
end top;

architecture behavioral of top is

    signal clk_256mhz : std_logic;
    signal clk2_256mhz : std_logic;
    signal clk_128mhz :std_logic;
    signal clk_32mhz : std_logic;
    signal std_pll_lock : std_logic;
    signal r_ada_cs : std_logic;
    signal r_po_ada_cs : std_logic;
    signal r_po_adb_cs: std_logic;

    signal route_test_pwm : std_logic;

--	component main_pll IS
--	PORT
--	(
--		inclk0		: IN STD_LOGIC  := '0';
--		c0		: OUT STD_LOGIC ;
--		c1		: OUT STD_LOGIC ;
--		c2		: OUT STD_LOGIC ;
--		locked		: OUT STD_LOGIC 
--	);
--	END component;

--   component main_pll is
--   port (
--       CLKI: in  std_logic; 
--       CLKOP: out  std_logic; 
--       CLKOS: out  std_logic; 
--       CLKOS2: out  std_logic; 
--       LOCK: out  std_logic);
--   end component;


	
component system_control is
   port(
		core_clk : in std_logic;
		modulator_clk : in std_logic;
		modulator_clk2 : in std_logic;

		si_pll_lock : in std_logic;
		
-- relay bypass
		po_bypass_relay : out std_logic;	

-- aux pwm
		po_aux_pwm : out std_logic;

-- PFC pwm
		po2_pfc_pwm : out std_logic_vector(1 downto 0);

-- heater pwm
		po2_ht_pri_pwm : out std_logic_vector(1 downto 0);
		po2_ht_sec_pwm : out std_logic_vector(1 downto 0);

-- DBH pwm
		po2_DHB_pri_pwm : out std_logic_vector(1 downto 0);
		po2_DHB_sec_pwm : out std_logic_vector(1 downto 0);
			
-- uart rx and tx
	    pi_uart_rx : in std_logic;
	    po_uart_tx : out std_logic;

-- ad converter A signals
	    po_ada_cs : out std_logic;
	    po_ada_clk : out std_logic;
	    pi_ada_sdata : in std_logic;
	    po3_ada_muxsel : out std_logic_vector(2 downto 0);

-- ad converter B signals
	    po_adb_cs : out std_logic;
	    po_adb_clk : out std_logic;
	    pi_adb_sdata : in std_logic;
	    po3_adb_muxsel : out std_logic_vector(2 downto 0);

-- ext ad converter 1 signals
	    po_ext_ad1_cs : out std_logic;
	    po_ext_ad1_clk : out std_logic;
	    pi_ext_ad1_sdata : in std_logic;

-- ext ad converter 2 signals
	    po_ext_ad2_cs : out std_logic;
	    po_ext_ad2_clk : out std_logic;
	    pi_ext_ad2_sdata : in std_logic;

-- rgb status leds driver signals, active low
	    po3_led1 : out std_logic_vector(2 downto 0);
	    po3_led2 : out std_logic_vector(2 downto 0);
	    po3_led3 : out std_logic_vector(2 downto 0)
         );
end component;


begin
core_clocks : main_pll 
	port map
	(
		xclk32mhz,
		clk_256mhz,
		clk_128mhz,
		clk2_256mhz,
		std_pll_lock
	);



main_system_control : system_control 
    port map(
			core_clk => clk_128mhz, 
			modulator_clk => clk_256mhz,
			modulator_clk2 => clk2_256mhz,

			si_pll_lock => std_pll_lock,
			
-- relay bypass
		po_bypass_relay => po_bypass_relay, 

-- aux pwm
		po_aux_pwm => open,

-- PFC pwm
		po2_pfc_pwm => po2_pfc_pwm,

-- heater pwm
		po2_ht_pri_pwm => po2_ht_pri_pwm,
		po2_ht_sec_pwm => po2_ht_sec_pwm,

-- DBH pwm
		po2_DHB_pri_pwm => po2_DHB_pri_pwm,
		po2_DHB_sec_pwm => po2_DHB_sec_pwm,
			
-- uart rx and tx
	    pi_uart_rx => pi_uart_rx,
	    po_uart_tx => po_uart_tx,

-- ad converter A signals
	    po_ada_cs => r_po_ada_cs,
	    po_ada_clk => po_ada_clk,
	    pi_ada_sdata => pi_ada_sdata,
	    po3_ada_muxsel => po3_ada_muxsel,

-- ad converter B signals
	    po_adb_cs => r_po_adb_cs,
	    po_adb_clk => po_adb_clk, 
	    pi_adb_sdata => pi_adb_sdata,
	    po3_adb_muxsel => po3_adb_muxsel,

-- ext ad converter 1 signals
	    po_ext_ad1_cs => po_ext_ad1_cs, 
	    po_ext_ad1_clk => po_ext_ad1_clk, 
	    pi_ext_ad1_sdata => pi_ext_ad1_sdata, 

-- ext ad converter 2 signals
	    po_ext_ad2_cs => po_ext_ad2_cs, 
	    po_ext_ad2_clk => po_ext_ad2_clk, 
	    pi_ext_ad2_sdata => pi_ext_ad2_sdata, 
	    

-- rgb status leds driver signals, active low
	    po3_led1 => po3_led1,
	    po3_led2 => po3_led2, 
	    po3_led3 => po3_led3 
         );


	    po_ada_cs <= r_po_ada_cs;
	    po_adb_cs <= r_po_adb_cs;

end behavioral;
