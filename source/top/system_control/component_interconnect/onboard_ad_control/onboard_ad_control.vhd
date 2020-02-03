library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;
    use onboard_adc_library.onboard_ad_control_internal_pkg.all;

entity onboard_ad_control is
    port (
        onboard_ad_control_clocks : in onboard_ad_control_clock_group;

        onboard_ad_control_FPGA_in : in onboard_ad_control_FPGA_input_group;
        onboard_ad_control_FPGA_out : out onboard_ad_control_FPGA_output_group;

        onboard_ad_control_data_in : in onboard_ad_control_data_input_group;
        onboard_ad_control_data_out : out onboard_ad_control_data_output_group
    );
end entity onboard_ad_control;

architecture rtl of onboard_ad_control is

    component adc_wrapper is
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

    signal ada_ready : std_logic;
    signal ada_trigger_register : std_logic_vector(2 downto 0);
    signal ada_start_conversion : std_logic;
    signal ada_sh_ready : std_logic;
    signal ada_data : std_logic_vector(15 downto 0);
    signal ada_mux_io : std_logic_vector(2 downto 0);


    signal adb_ready : std_logic;
    signal adb_trigger_register : std_logic_vector(2 downto 0);
    signal adb_start_conversion : std_logic;
    signal adb_sh_ready : std_logic;
    signal adb_data : std_logic_vector(15 downto 0);
    signal adb_mux_io : std_logic_vector(2 downto 0);
begin
------------------------------------------------------------------------
    onboard_ad_control_FPGA_out.ada_mux <= ada_mux_io;
    ad_mux_control : process(onboard_ad_control_clocks.core_clock)
    begin
        if rising_edge(onboard_ad_control_clocks.core_clock) then

            onboard_ad_control_data_out.ada_measurements.ad_data_is_ready <= false;
            if onboard_ad_control_clocks.reset_n = '0' then
            -- reset state
                ada_mux_io <= (others => '0');
                ada_trigger_register <= (others => '0');
                ada_start_conversion <= '0';
            else

                ada_trigger_register <= ada_trigger_register(1 downto 0) & (onboard_ad_control_data_in.ada_triggers.ad_start_request_toggle);
                ada_start_conversion <= ada_trigger_register(2) xor ada_trigger_register(1);

                if ada_sh_ready = '1' then
                    ada_mux_io <= drive_ad_mux(onboard_ad_control_data_in.ada_triggers.ad_mux_position);
                    onboard_ad_control_data_out.ada_measurements.ad_channel <= read_ad_mux_position(ada_mux_io);
                end if;

                if std_to_bool(ada_ready) then
                    onboard_ad_control_data_out.ada_measurements.ad_data_is_ready <= true;
                    onboard_ad_control_data_out.ada_measurements.ad_conversion_data <= read_ad_data(ada_data);
                end if;
            end if; -- rstn
        end if; --rising_edge
    end process ad_mux_control;	

ada : adc_wrapper 
    port map(onboard_ad_control_clocks.core_clock,
    onboard_ad_control_clocks.reset_n,
    onboard_ad_control_FPGA_out.ada_cs,
    onboard_ad_control_FPGA_out.ada_clock,
    onboard_ad_control_FPGA_in.ada_data,
    ada_start_conversion,
    open,
    ada_ready,
    ada_sh_ready,
    ada_data);
------------------------------------------------------------------------
    onboard_ad_control_FPGA_out.adb_mux <= adb_mux_io;
    adb_mux_control : process(onboard_ad_control_clocks.core_clock)
    begin
        if rising_edge(onboard_ad_control_clocks.core_clock) then

            onboard_ad_control_data_out.adb_measurements.ad_data_is_ready <= false;
            if onboard_ad_control_clocks.reset_n = '0' then
            -- reset state
                adb_mux_io <= (others => '0');
                adb_trigger_register <= (others => '0');
                adb_start_conversion <= '0';
            else

                adb_trigger_register <= adb_trigger_register(1 downto 0) & (onboard_ad_control_data_in.adb_triggers.ad_start_request_toggle);
                adb_start_conversion <= adb_trigger_register(2) xor adb_trigger_register(1);

                if adb_sh_ready = '1' then
                    adb_mux_io <= drive_ad_mux(onboard_ad_control_data_in.adb_triggers.ad_mux_position);
                    onboard_ad_control_data_out.adb_measurements.ad_channel <= read_ad_mux_position(adb_mux_io);
                end if;

                if std_to_bool(adb_ready) then
                    onboard_ad_control_data_out.adb_measurements.ad_data_is_ready <= true;
                    onboard_ad_control_data_out.adb_measurements.ad_conversion_data <= read_ad_data(adb_data);
                end if;
            end if; -- rstn
        end if; --rising_edge
    end process adb_mux_control;	

adb : adc_wrapper 
    port map(onboard_ad_control_clocks.core_clock,
    onboard_ad_control_clocks.reset_n,
    onboard_ad_control_FPGA_out.adb_cs,
    onboard_ad_control_FPGA_out.adb_clock,
    onboard_ad_control_FPGA_in.adb_data,
    adb_start_conversion,
    open,
    adb_ready,
    adb_sh_ready,
    adb_data);
------------------------------------------------------------------------
end rtl;
