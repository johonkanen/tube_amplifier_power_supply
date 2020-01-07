library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.component_interconnect_pkg.all;
    use work.onboard_ad_control_pkg.all;
    use work.vendor_specifics_pkg.all;
    use work.led_driver_pkg.all;
    -- use work.sw_supply_ctrl_pkg.all;

entity component_interconnect is
    port (
        system_clocks : in work.vendor_specifics_pkg.system_clock_group;    

        component_interconnect_FPGA_in : in component_interconnect_FPGA_input_group;
        component_interconnect_FPGA_out : out component_interconnect_FPGA_output_group;

        component_interconnect_data_in : in component_interconnect_data_input_group;
        component_interconnect_data_out : out component_interconnect_data_output_group
    );
end entity component_interconnect;

architecture rtl of component_interconnect is

    -- signal sw_supply_control_clocks : sw_supply_control_clock_group;
    -- signal sw_supply_control_FPGA_out : sw_supply_control_FPGA_output_group;
    -- signal sw_supply_control_data_in : sw_supply_control_data_input_group;
    -- signal sw_supply_control_data_out : sw_supply_control_data_output_group;
    
    component uart_event_ctrl is
	generic (
				g_CLKS_PER_BIT : integer; 
				g_RX_bytes_in_word : integer;
				g_TX_bytes_in_word : integer 
			);
--- uart interface
	port(
				uart_Clk   : in std_logic;
				
				po_uart_tx_serial : out std_logic;
				pi_uart_rx_serial : in std_logic;

				si_uart_start_event	: in std_logic;
				si16_uart_tx_data	: in std_logic_vector(15 downto 0);
				
				so_uart_rx_rdy		: out std_logic;
				so16_uart_rx_data	: out std_logic_vector(15 downto 0)
		);
    end component;		

    signal core_clk            : std_logic;
    signal po_uart_tx_serial   :  std_logic;
    signal pi_uart_rx_serial   : std_logic;
    signal si_uart_start_event : std_logic;
    signal si16_uart_tx_data   : std_logic_vector(15 downto 0);
    signal so_uart_ready_event :  std_logic;
    signal so16_uart_rx_data   :  std_logic_vector(15 downto 0);



    signal onboard_ad_control_clocks   : onboard_ad_control_clock_group;
    signal onboard_ad_control_data_in  : onboard_ad_control_data_input_group;
    signal onboard_ad_control_data_out : onboard_ad_control_data_output_group;
    constant jihuu : std_logic_vector(15 downto 0) := x"ACDC";
begin


    component_interconnect_FPGA_out.testiout <= '0';


    u_uart_event_ctrl : uart_event_ctrl
	generic map(
				g_CLKS_PER_BIT => g_vendor_specific_uart_clks_per_bit,
				g_RX_bytes_in_word => g_vendor_specific_RX_bytes_in_word,
				g_TX_bytes_in_word => g_vendor_specific_TX_bytes_in_word 
			)
    port map(
	    system_clocks.core_clock,
	    component_interconnect_FPGA_out.po_uart_tx_serial,
	    component_interconnect_FPGA_in.pi_uart_rx_serial,
	    si_uart_start_event,
        -- '1',
	    jihuu,
	    so_uart_ready_event,
	    so16_uart_rx_data
	);
    -- si_uart_start_event <= '1' when onboard_ad_control_data_out.ada_data_is_ready and onboard_ad_control_data_out.ada_channel = 0 else '0';

    -- si16_uart_tx_data <= std_logic_vector(to_unsigned(onboard_ad_control_data_out.ada_conversion_data,16));

    test_adc : process(system_clocks.core_clock)
        variable adc_test_counter : integer;
    begin
        if rising_edge(system_clocks.core_clock) then
            if system_clocks.pll_lock = '0' then
            -- reset state
                adc_test_counter := 0;
                si_uart_start_event <= '0';
                si16_uart_tx_data <= x"ACDC";
    
            else
                adc_test_counter := adc_test_counter + 1;
                if adc_test_counter = 7680 then
                    adc_test_counter := 0;
                end if;
                if so_uart_ready_event = '1' then
                    si16_uart_tx_data <= so16_uart_rx_data;
                end if;

                onboard_ad_control_data_in.ada_start_request <= false;
                onboard_ad_control_data_in.adb_start_request <= false;
                CASE adc_test_counter is
                    WHEN 0 =>
                        onboard_ad_control_data_in <= trigger_adc(1);
                    WHEN 948 =>
                        onboard_ad_control_data_in <= trigger_adc(2);
                        si_uart_start_event <= '1';
                    WHEN 1896 =>
                        onboard_ad_control_data_in <= trigger_adc(3);
                    WHEN 3792 =>
                        onboard_ad_control_data_in <= trigger_adc(4);
                    WHEN 4740 =>
                        onboard_ad_control_data_in <= trigger_adc(5);
                    WHEN 5688 =>
                        onboard_ad_control_data_in <= trigger_adc(6);
                    WHEN 6636 =>
                        onboard_ad_control_data_in <= trigger_adc(0);
                    WHEN others =>
                        si_uart_start_event <= '0';
                end CASE;
    
            end if; -- rstn
        end if; --rising_edge
    end process test_adc;	

-- onboard_ad_control_data_in <= component_interconnect_data_in.onboard_ad_control_data_in;
component_interconnect_data_out.onboard_ad_control_data_out <= onboard_ad_control_data_out;
 
    onboard_ad_control_clocks <= (system_clocks.core_clock, system_clocks.core_clock, system_clocks.pll_lock);
    u_onboard_ad_control : onboard_ad_control 
    port map(
        onboard_ad_control_clocks,   
        component_interconnect_FPGA_in.onboard_ad_control_FPGA_in,  
        component_interconnect_FPGA_out.onboard_ad_control_FPGA_out, 
        onboard_ad_control_data_in,
        onboard_ad_control_data_out 
    );

    -- u_sw_supply_control : sw_supply_control
    --     port map(
    --         sw_supply_control_clocks,   
    --         component_interconnect_FPGA_out.sw_supply_control_FPGA_out,
    --         sw_supply_control_data_in, 
    --         sw_supply_control_data_out 
    --     );

burn_leds : led_driver
port map(system_clocks.core_clock, component_interconnect_FPGA_out.po3_led1, component_interconnect_FPGA_out.po3_led2, component_interconnect_FPGA_out.po3_led3, component_interconnect_data_in.led1_color, component_interconnect_data_in.led2_color, component_interconnect_data_in.led3_color);

end rtl;
