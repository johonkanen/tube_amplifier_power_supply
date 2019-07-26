library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.numeric_std.all;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
	use work.sys_ctrl_pkg.all;
	use work.ad_bus_pkg.all;

entity ext_ad_control is
	port( 
		ad_clock : in std_logic;
		ad_bus_clock : in std_logic;
        si_rstn : in std_logic;

-- ext ad converter 1 signals
	    po_ext_ad1_cs : out std_logic;
	    po_ext_ad1_clk : out std_logic;
	    pi_ext_ad1_sdata : in std_logic;

-- ext ad converter 2 signals
	    po_ext_ad2_cs : out std_logic;
	    po_ext_ad2_clk : out std_logic;
	    pi_ext_ad2_sdata : in std_logic;

-- ext ad converter control signals, in ad clock domain
		si_ext_ad1_start : in std_logic;
		si_ext_ad2_start : in std_logic;

-- ext ad converter data, in ad bus clock domain
        ht_adc_control : out rec_ext_ad_ctrl;
        dhb_adc_control : out rec_ext_ad_ctrl
	);
end ext_ad_control;


architecture rtl of ext_ad_control is 

    signal r_so_ext_ad1_data : std_logic_vector(15 downto 0);
    signal r_so_ext_ad2_data : std_logic_vector(15 downto 0);

begin

heater_ad_driver : ext_ad_spi3w 
    generic map(to_unsigned(8,8),to_unsigned(14,8),to_unsigned(17,8))
    port map( 
	    si_spi_clk => ad_clock,
        si_rstn => si_rstn,
	    -- physical signals to ext ad converter
	    po_spi_cs => po_ext_ad1_cs, 
	    po_spi_clk_out => po_ext_ad1_clk,
	    pi_spi_serial => pi_ext_ad1_sdata, 
	    -- spi driver control signals
	    si_spi_start => si_ext_ad1_start,
	    s_spi_busy	=> open,
	    -- output signal indicating word is ready to be read 
	    so_spi_rdy => ht_adc_control.ad_rdy_trigger,
	    -- output signal indicating sampling is done
	    so_sh_rdy => open,
	    -- output buffer
	    b_spi_rx => r_so_ext_ad1_data 
	);

dhb_ad_driver : ext_ad_spi3w 
    generic map(to_unsigned(8,8),to_unsigned(14,8),to_unsigned(17,8))
    port map( 
	    si_spi_clk => ad_clock,
        si_rstn => si_rstn,
	    -- physical signals to ext ad converter
	    po_spi_cs => po_ext_ad2_cs, 
	    po_spi_clk_out => po_ext_ad2_clk,
	    pi_spi_serial => pi_ext_ad2_sdata, 
	    -- spi driver control signals
	    si_spi_start => si_ext_ad2_start,
	    s_spi_busy	=> open,
	    -- output signal indicating word is ready to be read 
	    so_spi_rdy => dhb_adc_control.ad_rdy_trigger,
	    -- output signal indicating sampling is done
	    so_sh_rdy => open,
	    -- output buffer
	    b_spi_rx => r_so_ext_ad2_data
	);
ht_adc_control.std16_ad_bus <= std_logic_vector(shift_left(unsigned(r_so_ext_ad1_data),3));
dhb_adc_control.std16_ad_bus <= std_logic_vector(shift_left(unsigned(r_so_ext_ad2_data),3));

--    ht_bus_driver : cdc_bus_driver
--    port map(ad_clock,ad_bus_clock,r_so_ext_ad1_data,ext_ad1_spi_rdy,ht_adc_control.std16_ad_bus,ht_adc_control.ad_rdy_trigger);

--    dhb_bus_driver : cdc_bus_driver
--    port map(ad_clock,ad_bus_clock,r_so_ext_ad2_data,ext_ad2_spi_rdy,dhb_adc_control.std16_ad_bus,dhb_adc_control.ad_rdy_trigger);
		

end rtl;
