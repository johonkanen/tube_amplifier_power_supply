library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

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

    package max11115_pkg is new work.max11115_generic_pkg;
        use max11115_pkg.all;

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
    signal ada : max11115_record := init_max11115;
    signal adb : max11115_record := init_max11115;

    signal sample_counter : natural range 0 to 4095 := 0;

    signal data_out_from_device : std_logic_vector(7 downto 0) := (others => '0');

    signal core_clock      : std_logic;
    signal modulator_clock : std_logic;
    signal pll_lock        : std_logic;

------------------------------------------------------------------------
begin

------------------------------------------------------------------------
    core_clocks : work.main_clock_8x_serdes
    port map(core_clock, modulator_clock, pll_lock, xclk);

    dingdongpingpongplimplom : entity work.output_serdes_8x
    port map 
    ( 
        data_out_from_device => data_out_from_device,
        data_out_to_pins(0)  => ac1_switch,
        clk_in               => modulator_clock,
        clk_div_in           => core_clock,
        io_reset             => '0'
    );
------------------------------------------------------------------------

    rgb_led1 <= data_from_test_interface(2 downto 0);
    rgb_led2 <= data_from_test_interface(5 downto 3);
    rgb_led3 <= data_from_test_interface(8 downto 6);

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
            connect_read_only_data_to_address(bus_from_communications, bus_out, tubepsu_addresses_pkg.ada_address, get_converted_measurement(ada));
            connect_read_only_data_to_address(bus_from_communications, bus_out, tubepsu_addresses_pkg.adb_address, get_converted_measurement(adb));

            bus_to_communications <= bus_from_hil_simulation      and
                                     bus_from_main_system_control and
                                     bus_out;

            create_max11115(ada , ada_data , ada_cs , ada_clock);
            create_max11115(adb , adb_data , adb_cs , adb_clock);

            sample_counter <= sample_counter + 1;
            if sample_counter = 3000 then
                sample_counter <= 0;
                request_conversion(ada);
                request_conversion(adb);
            end if;

            if sample_counter > 3000/2 then
                data_out_from_device <= (others => '0');
                /* ac1_switch <= '1'; */
                ac2_switch <= '0';
            else
                data_out_from_device <= (others => '1');
                /* ac1_switch <= '0'; */
                ac2_switch <= '1';
            end if;

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
     ada_mux   <= (others => '0');
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

     /* ac1_switch   <= '0'; */
     /* ac2_switch   <= '0'; */
     bypass_relay <= '0';
------------------------------------------------------------------------
end behavioral;
