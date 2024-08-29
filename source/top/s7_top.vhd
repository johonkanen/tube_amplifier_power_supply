library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.system_clocks_pkg.all;
    use work.main_system_control_pkg.all;
    use work.boost_model_pkg.all;

    use work.fpga_interconnect_pkg.all;
    use work.boost_rtl_entity_interface_pkg.all;

    use work.real_to_fixed_pkg.all;
    use work.tubepsu_addresses_pkg;
    use work.boost_control_interface_pkg.all;
    use work.test_interface_pkg.all;
    use work.sincos_pkg.all;
    use work.multiplier_pkg.all;

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

    signal bus_to_communications   : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_hil_simulation : fpga_interconnect_record := init_fpga_interconnect;

    signal bus_from_communications      : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_main_system_control : fpga_interconnect_record := init_fpga_interconnect;

    signal bus_out : fpga_interconnect_record := init_fpga_interconnect;
------------------------------------------------------------------------
------------------------------------------------------------------------

    signal main_system_control_interface : main_system_control_record;

    signal test_interface : comm_bus_record;
    signal data_from_test_interface : std_logic_vector(15 downto 0);
    alias core_clock is system_clocks.core_clock;

------------------------------------------------------------------------
begin

    rgb_led1 <= data_from_test_interface(2 downto 0);
    rgb_led2 <= data_from_test_interface(5 downto 3);

------------------------------------------------------------------------
    u_test_entity : entity work.test_entity
    port map(core_clock, test_interface);
------------------------------------------------------------------------
    combine_buses : process(core_clock)
    begin
        if rising_edge(core_clock) then
            init_bus(bus_out);
            init_tx(test_interface);
            if write_to_address_is_requested(bus_from_communications, tubepsu_addresses_pkg.vhdl2019_interface_test_address) then
                write_data(test_interface, get_data(bus_from_communications));
            end if;
            if bus_feedback_is_ready(test_interface) then
                data_from_test_interface <= get_data_from_entity(test_interface);
            end if;

            connect_read_only_data_to_address(bus_from_communications, bus_out, tubepsu_addresses_pkg.vhdl2019_interface_test_address, data_from_test_interface);

            bus_to_communications <= bus_from_hil_simulation      and
                                     bus_from_main_system_control and
                                     bus_out;

        end if; --rising_edge
    end process combine_buses;	
------------------------------------------------------------------------
    u_communications : entity work.fpga_communications
    generic map(fpga_interconnect_pkg => work.fpga_interconnect_pkg)
        port map(
            clock   => core_clock ,
            uart_rx => pi_uart_rx_serial    ,
            uart_tx => po_uart_tx_serial    ,
            bus_to_communications   => bus_to_communications ,
            bus_from_communications => bus_from_communications
        );
------------------------------------------------------------------------
    u_main_system_control : entity work.main_system_control
    port map (
        core_clock                    => core_clock,
        bus_to_main_system_control    => bus_from_communications      ,
        bus_from_main_system_control  => bus_from_main_system_control ,
        main_system_control_interface => main_system_control_interface);
------------------------------------------------------------------------
    u_hil_simulation : entity work.hil_simulation
    port map(
        core_clock              => core_clock,
        bus_to_hil_simulation   => bus_from_communications,
        bus_from_hil_simulation => bus_from_hil_simulation,
        rtl_inductor_current    => main_system_control_interface.boost_control_interface.inductor_current    ,
        rtl_input_voltage       => main_system_control_interface.boost_control_interface.input_voltage       ,
        rtl_dc_link_voltage     => main_system_control_interface.boost_control_interface.dc_link_voltage     ,
        boost_control_ready     => main_system_control_interface.boost_control_interface.boost_control_ready ,
        duty_ratio              => main_system_control_interface.boost_control_interface.duty_ratio
    );
------------------------------------------------------------------------

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
     /* ada_data  <= '0'; */
     ada_clock <= '0';
     ada_cs    <= '0';
     ada_mux   <= (others => '0');

     /* adb_data  <= '0'; */
     adb_clock <= '0';
     adb_cs    <= '0';
     adb_mux   <= (others => '0');

     dhb_ad_cs          <= '0';
     dhb_ad_clock       <= '0';
     /* dhb_ad_data        <= '0'; */
     dhb_primary_high   <= '0';
     dhb_primary_low    <= '0';
     dhb_secondary_high <= '0';
     dhb_secondary_low  <= '0';

     llc_ad_cs    <= '0';
     llc_ad_clock <= '0';
     /* llc_ad_data  <= '0'; */
     pri_high     <= '0';
     pri_low      <= '0';
     sync1        <= '0';
     sync2        <= '0';

     ac1_switch   <= '0';
     ac2_switch   <= '0';
     bypass_relay <= '0';
------------------------------------------------------------------------
end behavioral;
