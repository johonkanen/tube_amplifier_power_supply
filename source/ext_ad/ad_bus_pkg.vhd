library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package ad_bus_pkg is

component ext_ad_spi3w is
	generic(
				g_u8_clk_cnt : unsigned(7 downto 0);
				g_u8_clks_per_conversion : unsigned(7 downto 0);
				g_sh_counter_latch : unsigned(7 downto 0)
			);
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
end component; 

component spi3w_ads7056_driver is
	generic(
				g_u8_clk_cnt : unsigned(7 downto 0);
				g_u8_clks_per_conversion : unsigned(7 downto 0);
				g_sh_counter_latch : unsigned(7 downto 0)
			);
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
end component; 

component cdc_bus_driver is
    port (
		ad_clock : in std_logic;
		ad_bus_clock : in std_logic;

        si16_ad_clocked_data : in std_logic_vector(15 downto 0);
        si_ad_data_rdy : in std_logic;

        so16_ad_bus_data : out std_logic_vector(15 downto 0);
        so_ad_bus_rdy : out std_logic
    );
end component;

component cdc_onboard_ad_bus_driver is
    port (
        ad_clock : in std_logic;
        ad_bus_clock : in std_logic;

        si_ad_data_rdy : in std_logic;
        so_ad_bus_rdy : out std_logic;

        si17_ad_clocked_data : in std_logic_vector(16 downto 0);
        so17_ad_bus_data : out std_logic_vector(16 downto 0)
        );
end component;


type rec_ext_ad_ctrl is record
    std16_ad_bus : std_logic_vector(15 downto 0);
    ad_rdy_trigger : std_logic;
end record;

subtype t3_mux_pos is std_logic_vector(2 downto 0);
subtype t_ad_triggers is std_logic_vector(6 downto 0);

    --ad mux positions
    constant c_mux_ada0 : t3_mux_pos := 3d"2";
    constant c_mux_ada1 : t3_mux_pos := 3d"1";
    constant c_mux_ada2 : t3_mux_pos := 3d"0";
    constant c_mux_ada3 : t3_mux_pos := 3d"3";
    constant c_mux_ada4 : t3_mux_pos := 3d"4";
    constant c_mux_ada5 : t3_mux_pos := 3d"6";
    constant c_mux_ada6 : t3_mux_pos := 3d"7";

    constant c_mux_adb0 : t3_mux_pos := 3d"2";
    constant c_mux_adb1 : t3_mux_pos := 3d"1";
    constant c_mux_adb2 : t3_mux_pos := 3d"0";
    constant c_mux_adb3 : t3_mux_pos := 3d"3";
    constant c_mux_adb4 : t3_mux_pos := 3d"4";
    constant c_mux_adb5 : t3_mux_pos := 3d"6";
    constant c_mux_adb6 : t3_mux_pos := 3d"7";

    -- tube psu measurements
    alias aka_mux_PFC_I2_MEAS : t3_mux_pos is c_mux_ADA3;
    alias aka_mux_AUX_MEAS : t3_mux_pos is c_mux_ADA5;
    alias aka_mux_cuk_cap_meas_raw : t3_mux_pos is c_mux_ada6;

    alias aka_mux_VAC_MEAS : t3_mux_pos is c_mux_ADB1;
    alias aka_mux_HEATER_I_MEAS : t3_mux_pos is c_mux_ADB2;
    alias aka_mux_PFC_I1_MEAS : t3_mux_pos is c_mux_ADB3;
    alias aka_mux_DC_LINK_MEAS : t3_mux_pos is c_mux_ADB4;
    alias aka_mux_heater_cap_ad_meas : t3_mux_pos is c_mux_ADB5;
    alias aka_mux_DHB_I_MEAS : t3_mux_pos is c_mux_ADB6;

    -- one hot encoding, ch corresponds to 7d"3" and is also named using triggers
    signal r_ada_triggers : t_ad_triggers;
    signal r_adb_triggers : t_ad_triggers;
    
	-- one hot encoding for ad triggers
	constant ch0 : t_ad_triggers := 7d"1"; -- (0)
	constant ch1 : t_ad_triggers := 7d"2"; -- (1)
	constant ch2 : t_ad_triggers := 7d"4"; -- (2)
	constant ch3 : t_ad_triggers := 7d"8"; -- (3)
	constant ch4 : t_ad_triggers := 7d"16"; -- (4)
	constant ch5 : t_ad_triggers := 7d"32"; -- (5)
	constant ch6 : t_ad_triggers := 7d"64"; -- (6)
	constant inactive : t_ad_triggers := 7d"0";

    alias aka_trig_ada0 : t_ad_triggers is ch0;
    alias aka_trig_ada1 : t_ad_triggers is ch1;
    alias aka_trig_ada2 : t_ad_triggers is ch2;
    alias aka_trig_PFC_i2 : t_ad_triggers is ch3;
    alias aka_trig_ada4 : t_ad_triggers is ch4;
    alias aka_trig_AUX : t_ad_triggers is ch5;
    alias aka_trig_cuk_cap : t_ad_triggers is ch6;

    alias aka_trig_adb0 : t_ad_triggers is ch0;
    alias aka_trig_vac : t_ad_triggers is ch1;
    alias aka_trig_heater_i : t_ad_triggers is ch2;
    alias aka_trig_PFC_i1 : t_ad_triggers is ch3;
    alias aka_trig_DC_link : t_ad_triggers is ch4;
    alias aka_trig_heater_cap : t_ad_triggers is ch5;
    alias aka_trig_dhb_i : t_ad_triggers is ch6;


end ad_bus_pkg;


package body ad_bus_pkg is


end ad_bus_pkg;
