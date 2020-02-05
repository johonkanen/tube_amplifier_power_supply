library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;
    use onboard_adc_library.measurement_interface_pkg.all;


entity measurement_interface is
    port 
    (
        measurement_interface_clocks : in measurement_interface_clock_group; 
        measurement_interface_FPGA_in : in measurement_interface_FPGA_input_group;
        measurement_interface_FPGA_out : out measurement_interface_FPGA_output_group; 
        measurement_interface_data_in : in measurement_interface_data_input_group;
        measurement_interface_data_out : out measurement_interface_data_output_group
    );
end entity;

architecture rtl of measurement_interface is

    alias core_clock : std_logic is measurement_interface_clocks.core_clock;
    alias reset_n : std_logic is measurement_interface_clocks.reset_n;

    component ext_ad_spi3w is
        generic(
                    g_u8_clk_cnt : integer;
                    g_u8_clks_per_conversion : integer;
                    g_sh_counter_latch : integer
                );
        port( 
                si_spi_clk 	 : in std_logic; 
                si_rstn : in std_logic;
                 
                -- physical signals to ext ad converter
                po_spi_cs 	 : out std_logic;
                po_spi_clk_out : out std_logic;
                pi_spi_serial : in std_logic; 
     
                si_spi_start	 : in std_logic; 
                 
                -- ext spi control signals
                s_spi_busy	 : out std_logic; 
                -- output signal indicating word is ready to be read 
                so_spi_ready	 : out std_logic; 
                -- output signal indicating sampling is done
                so_sh_ready	 : out std_logic; 
                -- output buffer
                b_spi_rx : out std_logic_vector(15 downto 0)  
            );	
    end component; 

    signal onboard_ad_control_clocks : onboard_ad_control_clock_group;
    signal onboard_ad_control_data_out : onboard_ad_control_data_output_group;
    signal onboard_ad_control_data_in : onboard_ad_control_data_input_group;

    signal llc_voltage : integer range 0 to 2**16-1;
    signal llc_ad_trigger : std_logic_vector(2 downto 0);
    signal llc_ad_spi_start : std_logic;
    signal llc_spi_ready : std_logic;
    signal llc_ad_data : std_logic_vector(15 downto 0);

    signal dhb_voltage : integer range 0 to 2**16-1;
    signal dhb_ad_trigger : std_logic_vector(2 downto 0);
    signal dhb_ad_spi_start : std_logic;
    signal dhb_spi_ready : std_logic;
    signal dhb_ad_data : std_logic_vector(15 downto 0);

begin
------------------------------------------------------------------------
    trigger_llc_ad : process(core_clock)
        
    begin
        if rising_edge(core_clock) then
            if reset_n = '0' then
            -- reset state
                llc_ad_trigger <= (others => '0');
    
            else
                llc_ad_trigger <= llc_ad_trigger(1 downto 0) & measurement_interface_data_in.llc_ad_start_request_toggle; 
                llc_ad_spi_start <= '0';
                if llc_ad_trigger(2) /= llc_ad_trigger(1) then 
                    llc_ad_spi_start <= '1';
                end if;

                dhb_ad_trigger <= dhb_ad_trigger(1 downto 0) & measurement_interface_data_in.dhb_ad_start_request_toggle; 
                dhb_ad_spi_start <= '0';
                if dhb_ad_trigger(2) /= dhb_ad_trigger(1) then 
                    dhb_ad_spi_start <= '1';
                end if;
            end if; -- rstn
        end if; --rising_edge
    end process trigger_llc_ad;	
------------------------------------------------------------------------
llc_adc : ext_ad_spi3w
    generic map(4,14,9)
    port map(
			core_clock,
            reset_n,
			measurement_interface_FPGA_out.llc_ad_cs,
			measurement_interface_FPGA_out.llc_ad_clock,
			measurement_interface_FPGA_in.llc_ad_data, 
			llc_ad_spi_start,
			open,
			llc_spi_ready,
			open,
			llc_ad_data);
llc_voltage <= to_integer(shift_left(unsigned(llc_ad_data),3));
------------------------------------------------------------------------
dhb_adc : ext_ad_spi3w
    generic map(4,14,9)
    port map(
			core_clock,
            reset_n,
			measurement_interface_FPGA_out.dhb_ad_cs,
			measurement_interface_FPGA_out.dhb_ad_clock,
			measurement_interface_FPGA_in.dhb_ad_data, 
			dhb_ad_spi_start,
			open,
			dhb_spi_ready,
			open,
			dhb_ad_data);
dhb_voltage <= to_integer(shift_left(unsigned(dhb_ad_data),3));
------------------------------------------------------------------------
    measurement_interface_data_out.onboard_ad_control_data_out <= onboard_ad_control_data_out;
    onboard_ad_control_clocks <= (core_clock, core_clock, reset_n);
    u_onboard_ad_control : onboard_ad_control 
    port map(
        onboard_ad_control_clocks,   
        measurement_interface_FPGA_in.onboard_ad_control_FPGA_in,  
        measurement_interface_FPGA_out.onboard_ad_control_FPGA_out, 
        onboard_ad_control_data_in,
        onboard_ad_control_data_out 
    );
end rtl;
