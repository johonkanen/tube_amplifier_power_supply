library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.ad_mux_control_pkg.all;
    use work.onboard_ad_control_internal_pkg.all;

entity ad_mux_control is
    port (
        ad_mux_control_clocks : in ad_mux_control_clock_group;

        ad_mux_control_FPGA_out : out ad_mux_control_FPGA_output_group;

        ad_mux_control_data_in : in ad_mux_control_data_input_group;
        ad_mux_control_data_out : out ad_mux_control_data_output_group
    );
end entity ad_mux_control;

architecture rtl of ad_mux_control is

    
    signal ad_ready : std_logic;
    signal ad_start : std_logic;
    signal ad_sh_ready : std_logic;
    signal ad_data : std_logic_vector(15 downto 0);

    signal adb_ready : std_logic;
    signal adb_start : std_logic;
    signal adb_sh_ready : std_logic;
    signal adb_data : std_logic_vector(15 downto 0);

    signal ad_mux_io : std_logic_vector(2 downto 0);

begin
    ad_mux_control_FPGA_out.ad_mux_channel <= ad_mux_io;

    ad_start <= bool_to_std(ad_mux_control_data_in.ad_start_request);
    ad_mux_control_FPGA_out.ad_mux <= ad_mux_io;

    ad_mux_control : process(ad_mux_control_clocks.core_clock)
    begin
        if rising_edge(ad_mux_control_clocks.core_clock) then

            ad_mux_control_data_out.ad_data_is_ready <= false;
            if ad_mux_control_clocks.reset_n = '0' then
            -- reset state
                ad_mux_io <= (others => '0');
            else

                if ad_sh_ready = '1' then
                    ad_mux_io <= drive_ad_mux(ad_mux_control_data_in.ad_mux_position);
                    ad_mux_control_data_out.ad_channel <= read_ad_mux_position(ad_mux_io);
                end if;

                if std_to_bool(ad_ready) then
                    ad_mux_control_data_out.ad_data_is_ready <= true;
                    ad_mux_control_data_out.ad_conversion_data <= read_ad_data(ad_data);
                end if;
            end if; -- rstn
        end if; --rising_edge
    end process ad_mux_control;	

ad : adc_wrapper 
    port map(ad_mux_control_clocks.core_clock,
    ad_mux_control_clocks.reset_n,
    ad_mux_control_FPGA_out.ad_cs,
    ad_mux_control_FPGA_out.ad_clock,
    ad_mux_control_FPGA_in.ad_data,
    ad_start,
    open,
    ad_ready,
    ad_sh_ready,
    ad_data);

end rtl;

