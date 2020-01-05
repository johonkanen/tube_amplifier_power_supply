library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.onboard_ad_control_pkg.all;

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
    signal ada_start : std_logic;
    signal ada_sh_ready : std_logic;
    signal ada_data : std_logic_vector(15 downto 0);

    signal adb_ready : std_logic;
    signal adb_start : std_logic;
    signal adb_sh_ready : std_logic;
    signal adb_data : std_logic_vector(15 downto 0);

    signal ad_mux_io : std_logic_vector(2 downto 0);
            -- ada_data_is_ready 
begin

onboard_ad_control_data_out.ada_data_is_ready <= std_to_bool(ada_ready);

    ad_mux_control : process(onboard_ad_control_clocks.core_clock)
    begin
        if rising_edge(onboard_ad_control_clocks.core_clock) then
            if onboard_ad_control_clocks.reset_n = '0' then
            -- reset state
                ada_start <= '0';
                onboard_ad_control_FPGA_out.ada_mux <= (others => '0');
                ad_mux_io <= (others => '0');
    
            else
                if ada_sh_ready = '1' then
                    onboard_ad_control_FPGA_out.ada_mux <= drive_ad_mux(onboard_ad_control_data_in.ada_mux_position);
                end if;

                ada_start <= bool_to_std(onboard_ad_control_data_in.ada_start_request);
            end if; -- rstn
        end if; --rising_edge
    end process ad_mux_control;	

ada : adc_wrapper 
    port map(onboard_ad_control_clocks.core_clock,
    onboard_ad_control_clocks.reset_n,
    onboard_ad_control_FPGA_out.ada_cs,
    onboard_ad_control_FPGA_out.ada_clock,
    onboard_ad_control_FPGA_in.ada_data,
    ada_start,
    open,
    ada_ready,
    ada_sh_ready,
    ada_data);

adb : adc_wrapper 
    port map(onboard_ad_control_clocks.core_clock,
    onboard_ad_control_clocks.reset_n,
    onboard_ad_control_FPGA_out.adb_cs,
    onboard_ad_control_FPGA_out.adb_clock,
    onboard_ad_control_FPGA_in.adb_data,
    adb_start,
    open,
    adb_ready,
    adb_sh_ready,
    adb_data);

end rtl;
