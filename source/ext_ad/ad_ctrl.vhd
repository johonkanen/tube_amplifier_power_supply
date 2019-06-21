library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.numeric_std.all;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
	use work.sys_ctrl_pkg.all;
	use work.ad_bus_pkg.all;

    use work.onboard_ad_ctrl_pkg.all;

entity ad_control is
	port( 
		ad_clock : in std_logic;
		ad_bus_clock : in std_logic;
        si_pll_lock : in std_logic;

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

        so_ada_ctrl : out rec_onboard_ad_ctrl_signals;
        so_adb_ctrl : out rec_onboard_ad_ctrl_signals;

		ti_ada_triggers : in t_ad_triggers;
		ti_adb_triggers : in t_ad_triggers
	    );	
end ad_control; 


architecture rtl of ad_control is

    component adc_wrapper is
	generic(
				g_u8_clk_cnt : unsigned(7 downto 0);
				g_u8_clks_per_conversion : unsigned(7 downto 0);
				g_sh_counter_latch : unsigned(7 downto 0)
			);
	port( 
			si_spi_clk 	 : in std_logic; 
            si_pll_lock : in std_logic;
			 
			-- physical signals to ext ad converter
			po_spi_cs 	 : out std_logic;
			po_spi_clk_out : out std_logic;
			pi_spi_serial : in std_logic; 
 
			si_spi_start : in std_logic; 
			 
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

signal si_ada_start : std_logic;
signal so_ada_sh_rdy : std_logic;
signal ada_data : std_logic_vector(15 downto 0);

signal si_adb_start : std_logic;
signal so_adb_sh_rdy : std_logic;
signal adb_data : std_logic_vector(15 downto 0);

signal test_ad : t_ad_triggers;
signal trig_cnt : unsigned(10 downto 0);

begin

ada : adc_wrapper 
    port map(ad_bus_clock,si_pll_lock, po_ada_cs, po_ada_clk, pi_ada_sdata, si_ada_start, open, so_ada_ctrl.ad_rdy_trigger, so_ada_sh_rdy, so_ada_ctrl.std16_ad_bus);

adb : adc_wrapper 
    port map(ad_bus_clock, si_pll_lock, po_adb_cs, po_adb_clk, pi_adb_sdata, si_adb_start, open, so_adb_ctrl.ad_rdy_trigger, so_adb_sh_rdy, so_adb_ctrl.std16_ad_bus);

ada_mux_sequencer : process(ad_clock)
    variable st_ada_seq : t3_mux_pos;
    variable st_ada_seq_nxt : t3_mux_pos;

begin
    if rising_edge(ad_bus_clock) then

        if so_adb_sh_rdy = '1' then
            po3_ada_muxsel <= st_ada_seq_nxt;
            po3_adb_muxsel <= st_ada_seq_nxt;
        end if;

        CASE test_ad is
            WHEN ch0 => 
                so_ada_ctrl.std3_ad_address <= 3d"0";
                so_adb_ctrl.std3_ad_address <= 3d"0";
                st_ada_seq_nxt := c_mux_ada1;  
            WHEN ch1 => 
                so_ada_ctrl.std3_ad_address <= 3d"1";
                so_adb_ctrl.std3_ad_address <= 3d"1";
                st_ada_seq_nxt := c_mux_ada2;  
            WHEN ch2 => 
                so_ada_ctrl.std3_ad_address <= 3d"2";
                so_adb_ctrl.std3_ad_address <= 3d"2";
                st_ada_seq_nxt := c_mux_ada3;  
            WHEN ch3 => 
                so_ada_ctrl.std3_ad_address <= 3d"3";
                so_adb_ctrl.std3_ad_address <= 3d"3";
                st_ada_seq_nxt := c_mux_ada4;  
            WHEN ch4 => 
                so_ada_ctrl.std3_ad_address <= 3d"4";
                so_adb_ctrl.std3_ad_address <= 3d"4";
                st_ada_seq_nxt := c_mux_ada5;  
            WHEN ch5 => 
                so_ada_ctrl.std3_ad_address <= 3d"5";
                so_adb_ctrl.std3_ad_address <= 3d"5";
                st_ada_seq_nxt := c_mux_ada6;  
            WHEN ch6 => 
                so_ada_ctrl.std3_ad_address <= 3d"6";
                so_adb_ctrl.std3_ad_address <= 3d"6";
                st_ada_seq_nxt := c_mux_ada0;  
            WHEN others =>
            --do nothing
        end CASE;
    end if; --rising_edge
end process;

create_test_triggers : process(ad_bus_clock)
    
begin
    if rising_edge(ad_bus_clock) then
        trig_cnt <= trig_cnt + 1;
        CASE trig_cnt is
            WHEN 11d"0" => 
                test_ad <= ch0;
                si_ada_start <= '1';
                si_adb_start <= '1';
            WHEN 11d"292" =>
                test_ad <= ch1;
                si_ada_start <= '1';
                si_adb_start <= '1';
            WHEN 11d"584" =>
                test_ad <= ch2;
                si_ada_start <= '1';
                si_adb_start <= '1';
            WHEN 11d"876" =>
                test_ad <= ch3;
                si_ada_start <= '1';
                si_adb_start <= '1';
            WHEN 11d"1168" =>
                test_ad <= ch4;
                si_ada_start <= '1';
                si_adb_start <= '1';
            WHEN 11d"1460" =>
                test_ad <= ch5;
                si_ada_start <= '1';
                si_adb_start <= '1';
            WHEN 11d"1752" =>
                test_ad <= ch6;
                si_ada_start <= '1';
                si_adb_start <= '1';
            WHEN others =>
                si_ada_start <= '0';
                si_adb_start <= '0';
        END case;
    end if; --rising_edge
end process create_test_triggers;	

end rtl;
