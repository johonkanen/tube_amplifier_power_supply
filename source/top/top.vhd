library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.vendor_specifics_pkg.all;
    use work.led_driver_pkg.all;
	use work.dhb_pkg.all;
    use work.llc_pkg.all;
    use work.pfc_pkg.all;

entity top is
    port(
-- main clock input
	    xclk32mhz : in std_logic;

-- relay bypass
	    po_bypass_relay : out std_logic;	

-- PFC pwm
	    po2_pfc_pwm : out bridgeless_pfc_pwm;

-- heater pwm
        po4_ht_pwm : out hb_llc_pwm;

-- DBH pwm
        po4_dhb_pwm : out dhb_pwm;

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
	    po3_led1 : out rgb_led;
	    po3_led2 : out rgb_led;
	    po3_led3 : out rgb_led
        );
end top;

architecture behavioral of top is

    signal clk_256mhz : std_logic;
    signal clk2_256mhz : std_logic;
    signal clk_128mhz :std_logic;
    signal std_pll_lock : std_logic;
    signal r_po_ada_cs : std_logic;
    signal r_po_adb_cs: std_logic;

component system_control is
    port(
	    core_clk : in std_logic;
	    modulator_clk : in std_logic;
	    modulator_clk2 : in std_logic;

	    si_pll_lock : in std_logic;
	    
-- relay bypass
	    po_bypass_relay : out std_logic;	

-- PFC pwm
	    po2_pfc_pwm : out bridgeless_pfc_pwm;

-- heater pwm
        po4_ht_pwm : out hb_llc_pwm;

-- DBH pwm
        po4_dhb_pwm : out dhb_pwm;

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
	    po3_led1 : out rgb_led;
	    po3_led2 : out rgb_led;
	    po3_led3 : out rgb_led
         );
end component;


begin
core_clocks : pll_1x256mhz
	port map
	(
		clk_256mhz,
		std_pll_lock,
		xclk32mhz
	);



main_system_control : system_control 
    port map(
        clk_256mhz, 
        clk_256mhz,
        clk_256mhz,

        std_pll_lock,
			
-- relay bypass
		po_bypass_relay, 

-- PFC pwm
	    po2_pfc_pwm,

-- heater pwm
        po4_ht_pwm,

-- DBH pwm
        po4_dhb_pwm,
			
-- uart rx and tx
	    pi_uart_rx,
	    po_uart_tx,

-- ad converter A signals
	    r_po_ada_cs,
	    po_ada_clk,
	    pi_ada_sdata,
	    po3_ada_muxsel,

-- ad converter B signals
	    r_po_adb_cs,
	    po_adb_clk, 
	    pi_adb_sdata,
	    po3_adb_muxsel,

-- ext ad converter 1 signals
	    po_ext_ad1_cs, 
        po_ext_ad1_clk, 
	    pi_ext_ad1_sdata, 

-- ext ad converter 2 signals
	    po_ext_ad2_cs, 
	    po_ext_ad2_clk, 
	    pi_ext_ad2_sdata, 
	    

-- rgb status leds driver signals, active low
	    po3_led1,
	    po3_led2, 
	    po3_led3 
         );


	    po_ada_cs <= r_po_ada_cs;
	    po_adb_cs <= r_po_adb_cs;

end behavioral;
