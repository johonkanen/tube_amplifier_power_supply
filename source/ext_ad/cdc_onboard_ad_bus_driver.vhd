library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.numeric_std.all;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
	use work.sys_ctrl_pkg.all;
	use work.ad_bus_pkg.all;

entity cdc_onboard_ad_bus_driver is
    port (
		ad_clock : in std_logic;
		ad_bus_clock : in std_logic;

        si_ad_data_rdy : in std_logic;
        so_ad_bus_rdy : out std_logic;

        si17_ad_clocked_data : in std_logic_vector(16 downto 0);
        so17_ad_bus_data : out std_logic_vector(16 downto 0)
        
    );
end entity cdc_onboard_ad_bus_driver;


architecture rtl of cdc_onboard_ad_bus_driver is

    type rec_cdc is record
        unstable : std_logic;
        stable : std_logic;
    end record;
    signal ad_data_rdy : std_logic;
    signal cdc_ad_data_rdy : rec_cdc;
    signal ad_transfer_done : std_logic;
    signal cdc_ad_transfer_done : rec_cdc;

    signal r1_so_ext_ad1_data : std_logic_vector(16 downto 0);

begin

ad_adc_cdc : process(ad_clock)
    type t_cdc_transmit is (wait_data, data_rdy, ack_read);
    variable st_cdc_transmit : t_cdc_transmit;
begin
    if rising_edge(ad_clock) then
        cdc_ad_transfer_done.unstable <= ad_transfer_done;
        cdc_ad_transfer_done.stable <= cdc_ad_transfer_done.unstable;
        CASE st_cdc_transmit is 
            WHEN wait_data =>
                ad_data_rdy <= '0';
                if si_ad_data_rdy = '1' then
                    r1_so_ext_ad1_data <= si17_ad_clocked_data;
                    st_cdc_transmit := data_rdy;
                else
                    r1_so_ext_ad1_data <= (others => '0');
                    st_cdc_transmit := wait_data;
                end if;
            WHEN data_rdy =>
                ad_data_rdy <= '1';
                if cdc_ad_transfer_done.stable = '1' then
                    st_cdc_transmit := ack_read;
                else
                    st_cdc_transmit := data_rdy;
                end if;
            WHEN ack_read =>
                ad_data_rdy <= '0';
                if cdc_ad_transfer_done.stable = '0' then
                    st_cdc_transmit := wait_data;
                else
                    st_cdc_transmit := ack_read;
                end if;
            WHEN others => 
                st_cdc_transmit := wait_data;
                r1_so_ext_ad1_data <= (others => '0');
        end CASE;
    end if; --rising_edge
end process ad_adc_cdc;	

ad_adc_bus_driver : process(ad_bus_clock)
    type t_cdc_receive is (wait_data, data_rdy, ack_read);
    variable st_cdc_receive : t_cdc_receive;
begin
    if rising_edge(ad_bus_clock) then
        cdc_ad_data_rdy.unstable <= ad_data_rdy;
        cdc_ad_data_rdy.stable <= cdc_ad_data_rdy.unstable;

        CASE st_cdc_receive is 
            WHEN wait_data =>
                ad_transfer_done <= '0';
                so_ad_bus_rdy <= '0';
                so17_ad_bus_data<= (others => '0');
                if cdc_ad_data_rdy.stable = '1' then
                    st_cdc_receive := data_rdy;
                else
                    st_cdc_receive := wait_data;
                end if;
            WHEN data_rdy =>
                ad_transfer_done <= '1';
                so17_ad_bus_data <= r1_so_ext_ad1_data;
                if cdc_ad_data_rdy.stable = '0' then
                    so_ad_bus_rdy <= '1';
                    st_cdc_receive := ack_read;
                else
                    so_ad_bus_rdy <= '0';
                    st_cdc_receive := data_rdy;
                end if;
            WHEN ack_read =>
                so_ad_bus_rdy <= '0';
                ad_transfer_done <= '0';
                so17_ad_bus_data <= (others => '0');
                if cdc_ad_data_rdy.stable = '0' then
                    st_cdc_receive := wait_data;
                else
                    st_cdc_receive := ack_read;
                end if;
            WHEN others => 
                st_cdc_receive := wait_data;
                so_ad_bus_rdy <= '0';
        end CASE;

    end if; --rising_edge
end process ad_adc_bus_driver;	
end rtl;
