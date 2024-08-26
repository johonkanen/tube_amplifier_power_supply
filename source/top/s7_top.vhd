library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.system_clocks_pkg.all;

entity top is
    port(
	    xclk : in std_logic;
        pi_uart_rx_serial : in std_logic;
        po_uart_tx_serial : out std_logic;

        -- onboard adc io
        ada_data  : in std_logic;
        ada_clock : out std_logic;
        ada_cs    : out std_logic;
        ada_mux   : out std_logic_vector(2 downto 0);

        adb_data  : in std_logic;
        adb_clock : out std_logic;
        adb_cs    : out std_logic;
        adb_mux   : out std_logic_vector(2 downto 0);


        -- dhb io
        dhb_primary_high   : out std_logic;
        dhb_primary_low    : out std_logic;
        dhb_secondary_high : out std_logic;
        dhb_secondary_low  : out std_logic;

        dhb_ad_data  : in std_logic;
        dhb_ad_clock : out std_logic;
        dhb_ad_cs    : out std_logic;

        -- llc io
        pri_high : out std_logic;
        pri_low  : out std_logic;
        sync1    : out std_logic;
        sync2    : out std_logic;

        llc_ad_data  : in std_logic;
        llc_ad_clock : out std_logic;
        llc_ad_cs    : out std_logic;

        -- pfc io
        ac1_switch : out std_logic;
        ac2_switch : out std_logic;

        -- misc
        bypass_relay : out std_logic;

        rgb_led1 : out std_logic_vector(2 downto 0);
        rgb_led2 : out std_logic_vector(2 downto 0);
        rgb_led3 : out std_logic_vector(2 downto 0)

    );
end top;

architecture behavioral of top is

    signal system_clocks : system_clock_group;

begin

------------------------------------------------------------------------
    clocks : entity work.pll_wrapper
	port map (
		xclk           => xclk,
        core_clk       => system_clocks.core_clock,
        modulator_clk  => system_clocks.modulator_clock,
        modulator_clk2 => system_clocks.adc_clock,
        pll_lock       => system_clocks.pll_lock
	);

	system_clocks.adc_pll_lock <= system_clocks.pll_lock;

------------------------------------------------------------------------
    u_efinix_top : entity work.efinix_top
	port map (
        core_clock => system_clocks.core_clock,
        uart_rx    => pi_uart_rx_serial,
        uart_tx    => po_uart_tx_serial,

        rgb_led1   => rgb_led1, 
        rgb_led2   => rgb_led2
    );
------------------------------------------------------------------------
     /* ada_data           <= '0'; */
     ada_clock          <= '0';
     ada_cs             <= '0';
     ada_mux            <= (others => '0');

     /* adb_data           <= '0'; */
     adb_clock          <= '0';
     adb_cs             <= '0';
     adb_mux            <= (others => '0');

     dhb_ad_cs          <= '0';
     dhb_ad_clock       <= '0';
     /* dhb_ad_data        <= '0'; */
     dhb_primary_high   <= '0';
     dhb_primary_low    <= '0';
     dhb_secondary_high <= '0';
     dhb_secondary_low  <= '0';

     llc_ad_cs          <= '0';
     llc_ad_clock       <= '0';
     /* llc_ad_data        <= '0'; */
     pri_high           <= '0';
     pri_low            <= '0';
     sync1              <= '0';
     sync2              <= '0';

     ac1_switch         <= '0';
     ac2_switch         <= '0';
     bypass_relay       <= '0';
------------------------------------------------------------------------
end behavioral;
