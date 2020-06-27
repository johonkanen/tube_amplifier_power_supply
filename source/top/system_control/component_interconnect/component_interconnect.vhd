library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.component_interconnect_pkg.all;
    use work.led_driver_pkg.all;
    use work.uart_pkg.all;
    use work.multiplier_pkg.all;
    use work.power_supply_control_pkg.all;
    use work.sincos_pkg.all;
    use work.cl10_fifo_control_pkg.all;
    use work.ram_control_pkg.all;
    
library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.get_ad_measurement;
    use onboard_adc_library.onboard_ad_control_pkg.ad_channel_is_ready;
    use onboard_adc_library.measurement_interface_pkg.all;
    use onboard_adc_library.psu_measurement_interface_pkg.all;

library common_library;
    use common_library.timing_pkg.all;
    use common_library.typedefines_pkg.all;

entity component_interconnect is
    port (
        system_clocks : in work.system_clocks_pkg.system_clock_group;    

        component_interconnect_FPGA_in : in component_interconnect_FPGA_input_group;
        component_interconnect_FPGA_out : out component_interconnect_FPGA_output_group;

        component_interconnect_data_in : in component_interconnect_data_input_group;
        component_interconnect_data_out : out component_interconnect_data_output_group
    );
end entity component_interconnect;

architecture rtl of component_interconnect is
    alias core_clock is system_clocks.core_clock;
    alias reset_n is system_clocks.pll_lock;

------------------------------------------------------------------------
    signal si_uart_start_event : std_logic_vector(2 downto 0);
    signal si16_uart_tx_data   : std_logic_vector(15 downto 0);
    signal so_uart_ready_event :  std_logic;
    signal so16_uart_rx_data   :  std_logic_vector(15 downto 0);
------------------------------------------------------------------------
    signal measurement_interface_clocks   : measurement_interface_clock_group;
    signal measurement_interface_data_in  : measurement_interface_data_input_group;
    signal measurement_interface_data_out : measurement_interface_data_output_group;
------------------------------------------------------------------------
    signal multiplier_clocks   : multiplier_clock_group;
    signal multiplier_data_in  : multiplier_data_input_group;
    signal multiplier_data_out :  multiplier_data_output_group;
------------------------------------------------------------------------
    signal power_supply_control_clocks   : power_supply_control_clock_group;
    signal power_supply_control_data_in  : power_supply_control_data_input_group;
    signal power_supply_control_data_out :  power_supply_control_data_output_group;
------------------------------------------------------------------------
    signal sincos_clocks   : sincos_clock_group;
    signal sincos_data_in  : sincos_data_input_group;
    signal sincos_data_out : sincos_data_output_group;
------------------------------------------------------------------------
    signal angle : uint16;
    signal sincos_is_requested : boolean;
------------------------------------------------------------------------
    signal delay_timer_data_in  : delay_timer_data_input_group;
    signal delay_timer_data_out : delay_timer_data_output_group;
------------------------------------------------------------------------     
    signal measurement_container : uint16_array(0 to 7);
    signal index : uint8;
    signal ada_meas_buffer : uint16;
    signal adb_meas_buffer : uint16;
    signal send_index : uint8;

        signal pi_out : int18;
        signal mem : int18;
        signal ekp : int18;
--------------------------------------------------
    procedure send_data_to_uart
    (
        uart_is_requested : boolean;
        signal start_uart : out std_logic;
        signal uart_tx_data : out std_logic_vector(15 downto 0);
        data_array : uint16_array;
        signal tx_index : inout natural
    ) is
        variable data_to_stream : integer;
    begin
        data_to_stream := data_array(tx_index);

        if uart_is_requested then
            start_uart <= '1';
            uart_tx_data <= std_logic_vector(to_unsigned(data_to_stream,16));

            if tx_index < measurement_container'right then
                tx_index <= tx_index + 1;
            else
                tx_index <= 0;
            end if;

        else
            start_uart <= '0';
        end if;
        
    end send_data_to_uart;

--------------------------------------------------

    signal fifo_output_control : fifo_output_control_group;
    signal fifo_control_input : fifo_input_control_group;

--------------------------------------------------
    signal ram_input : ram_2_port_input_group;
    signal ram_output : ram_2_port_output_group;

    
--------------------------------------------------
begin
    ram_2_port_inst : ram_2_port PORT MAP (
		clock     => core_clock,
		data      => ram_input.data,
		rdaddress => ram_input.rdaddress,
		wraddress => ram_input.wraddress,
		wren      => ram_input.wren,
		q         => ram_output.q
	);

    component_interconnect_data_out.measurement_interface_data_out <= measurement_interface_data_out;
------------------------------------------------------------------------

    uart_fifo_inst : uart_fifo 
    PORT MAP (
		clock        => core_clock,
		data         => fifo_control_input.data,
		rdreq        => fifo_control_input.rdreq,
		wrreq        => fifo_control_input.wrreq,
		almost_empty => fifo_output_control.almost_empty,
		almost_full  => fifo_output_control.almost_full,
		empty        => fifo_output_control.empty,
		full         => fifo_output_control.full,
		q            => fifo_output_control.q,
		usedw        => fifo_output_control.usedw
	);
------------------------------------------------------------------------
    multiplier_clocks.dsp_clock <= core_clock;
    u_multiplier : multiplier
        port map(
            multiplier_clocks, 
            multiplier_data_in,
            multiplier_data_out 
        );

------------------------------------------------------------------------
    u_1us_timer : delay_timer
    generic map (count_up_to => 1280)
    port map( core_clock,
              delay_timer_data_in,
              delay_timer_data_out);

------------------------------------------------------------------------
    test_uart : process(core_clock)
        type t_uart_data_log_states is (idle, pack_fifo, init_uart_stream, stream_data);
        variable st_uart_data_log_states : t_uart_data_log_states;

        variable process_counter : uint8;

    begin
        if rising_edge(core_clock) then
            if system_clocks.pll_lock = '0' then
            -- reset state
                st_uart_data_log_states := idle;
                send_index <= 0;
                si_uart_start_event <= (others => '0');
                process_counter := 0;

                reset_measurements :
                for i in 0 to measurement_container'right loop
                    measurement_container(i) <= 0;
                end loop;

            else

                get_vac         (measurement_interface_data_out , measurement_container (0));
                get_dc_link     (measurement_interface_data_out , measurement_container (1));
                get_pfc_I1      (measurement_interface_data_out , measurement_container (2));
                get_pfc_I2      (measurement_interface_data_out , measurement_container (3));
                get_dhb_voltage (measurement_interface_data_out , measurement_container (4));
                get_DHB_current (measurement_interface_data_out , measurement_container (5));
                get_llc_voltage (measurement_interface_data_out , measurement_container (6));
                get_LLC_current (measurement_interface_data_out , measurement_container (7));

                -- init_multiplier(multiplier_data_in);
                -- case process_counter is
                --     WHEN 0 => 
                --         alu_mpy(32768, 11, multiplier_data_in);
                --         increment(process_counter);
                --         
                --     WHEN 1 => 
                --         alu_mpy(32768, 12, multiplier_data_in);
                --         increment(process_counter);
                --
                --     WHEN 2 => 
                --         alu_mpy(32768, 13, multiplier_data_in);
                --         increment(process_counter);
                --
                --     WHEN 3 =>
                --         measurement_container(4) <= get_result(multiplier_data_out, 15);
                --         alu_mpy(32768, 14, multiplier_data_in);
                --         increment(process_counter);
                --
                --     WHEN 4 =>
                --         measurement_container(5) <= get_result(multiplier_data_out, 15);
                --         increment(process_counter);
                --
                --     WHEN 5 =>
                --         measurement_container(6) <= get_result(multiplier_data_out, 15);
                --         increment(process_counter);
                --
                --     WHEN 6 =>
                --         measurement_container(7) <= get_result(multiplier_data_out, 15);
                --         increment(process_counter);
                --
                --     WHEN others =>
                --         process_counter := 0;
                -- end CASE;
                --
                init_timer(delay_timer_data_in);
                si_uart_start_event <= si_uart_start_event(si_uart_start_event'left-1 downto 0) & '0';
                sincos_is_requested <= false;

                enable_ram_write_control(ram_input);
                enable_fifo_read_and_write(fifo_control_input);
                CASE st_uart_data_log_states is
                    WHEN idle =>

                        send_index <= 0;
                        st_uart_data_log_states := idle;
                        process_counter := 0;

                        request_delay(delay_timer_data_in,delay_timer_data_out,80e3);

                        if timer_is_ready(delay_timer_data_out) then
                            st_uart_data_log_states := pack_fifo;
                            write_data_to_ram(ram_input,process_counter,measurement_container(process_counter));
                        end if;

                        -- if sincos_is_ready(sincos_data_out) then
                        --     alu_mpy(get_sine(sincos_data_out), 32766,multiplier_data_in);
                        -- end if;
                        --
                        -- if multiplier_is_ready(multiplier_data_out) then
                        -- end if;
                    WHEN pack_fifo =>
                        increment(process_counter);
                        write_data_to_ram(ram_input,process_counter,measurement_container(process_counter));

                        if process_counter = 7 then
                            st_uart_data_log_states := init_uart_stream;
                        end if;

                    WHEN init_uart_stream => 
                        st_uart_data_log_states := stream_data;
                        load_data_from_ram(ram_input,7-process_counter);
                        si_uart_start_event(0) <= '1';

                    WHEN stream_data =>
                        st_uart_data_log_states := stream_data;

                        request_delay(delay_timer_data_in,delay_timer_data_out,1);
                        if timer_is_ready(delay_timer_data_out) then
                            process_counter := process_counter - 1;
                            load_data_from_ram(ram_input,7-process_counter);
                            si_uart_start_event(0) <= '1';
                        end if;

                        if process_counter = 0 then
                            st_uart_data_log_states := idle;
                        end if;

                end CASE;
    
            end if; -- rstn
        end if; --rising_edge
    end process test_uart;	
------------------------------------------------------------------------
    sincos_data_in <= (angle_uint16_pirad => angle, 
                      sincos_is_requested => sincos_is_requested);
                      -- multiplier_data_out => multiplier_data_out);
    sincos_clocks <= (alu_clock => core_clock, reset_n => reset_n);

    u_sincos : entity work.sincos
    port map
    (
        sincos_clocks,   
        sincos_data_in, 
        sincos_data_out 
    );

------------------------------------------------------------------------  
    measurement_interface_clocks <= (system_clocks.core_clock, system_clocks.core_clock, system_clocks.pll_lock);
    u_measurement_interface : measurement_interface 
    port map(
        measurement_interface_clocks,   
        component_interconnect_FPGA_in.measurement_interface_FPGA_in,  
        component_interconnect_FPGA_out.measurement_interface_FPGA_out, 
        measurement_interface_data_in,
        measurement_interface_data_out 
    );

------------------------------------------------------------------------
    burn_leds : led_driver
    port map(system_clocks.core_clock, 
            component_interconnect_FPGA_out.po3_led1, 
            component_interconnect_FPGA_out.po3_led2, 
            component_interconnect_FPGA_out.po3_led3, 
            component_interconnect_data_in.led1_color, 
            component_interconnect_data_in.led2_color, 
            component_interconnect_data_in.led3_color);

------------------------------------------------------------------------
    u_uart_event_ctrl : uart_event_ctrl
	generic map(25,2,2)
    port map(
	    system_clocks.core_clock,
	    component_interconnect_FPGA_out.po_uart_tx_serial,
	    component_interconnect_FPGA_in.pi_uart_rx_serial,
	    si_uart_start_event(2),
	    ram_output.q,
	    so_uart_ready_event,
	    so16_uart_rx_data);

------------------------------------------------------------------------
        power_supply_control_clocks <= (core_clock      => system_clocks.core_clock,
                                        modulator_clock => system_clocks.modulator_clock,
                                        pll_lock        => system_clocks.pll_lock);

        measurement_interface_data_in <= power_supply_control_data_out.measurement_interface_data_in;
        power_supply_control_data_in.measurement_interface_data_out <= measurement_interface_data_out;
        power_supply_control_data_in.power_supplies_are_enabled <= component_interconnect_data_in.power_supplies_are_enabled;

        u_power_supply_control : power_supply_control
        port map (
            power_supply_control_clocks,
            component_interconnect_FPGA_out.power_supply_control_FPGA_out,
            power_supply_control_data_in,
            power_supply_control_data_out
        );
------------------------------------------------------------------------
end rtl;
