library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.boost_model_pkg.all;

    use work.fpga_interconnect_pkg.all;
    use work.boost_model_interface_pkg.all;
    use work.main_system_control_pkg.all;

    use work.real_to_fixed_pkg.all;
    use work.tubepsu_addresses_pkg;
    use work.boost_control_interface_pkg.all;
    use work.test_interface_pkg.all;
    use work.sincos_pkg.all;
    use work.multiplier_pkg.all;
    
entity efinix_top is
    port (
        core_clock : in std_logic;
        uart_rx    : in std_logic;
        uart_tx    : out std_logic;

        rgb_led1   : out std_logic_vector(2 downto 0);
        rgb_led2   : out std_logic_vector(2 downto 0)
    );
end entity efinix_top;

architecture rtl of efinix_top is

------------------------------------------------------------------------
------------------------------------------------------------------------
    signal boost_model_interface : boost_model_interface_record;
    signal bus_from_boost_model : fpga_interconnect_record := init_fpga_interconnect;

    signal bus_to_communications : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_out : fpga_interconnect_record := init_fpga_interconnect;

    signal bus_from_communications : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_main_system_control : fpga_interconnect_record := init_fpga_interconnect;
------------------------------------------------------------------------
------------------------------------------------------------------------
    signal model_trigger_counter : natural range 0 to 255 := 0;

    constant cl_parameters : boost_model_parameters_record := (
        inductance  => 500.0e-6 ,
        capacitance => 320.0e-6 ,
        rl          => 100.0e-3 ,
        timestep    => 1.0e-6);

    signal boost_control_ready : boolean := false;
    signal duty_ratio : natural range 0 to 2**16-1;
    signal main_system_control_interface : main_system_control_record;
    signal boost_control_is_enabled : boolean := true;

    signal test_interface : comm_bus_record;
    signal data_from_test_interface : std_logic_vector(15 downto 0);
    signal sincos_multiplier : multiplier_record := init_multiplier;
    signal sincos : sincos_record := init_sincos;
    signal sincos_counter : natural range 0 to 2**16-1 := 0;
    signal angle_rad16 : unsigned(15 downto 0) := (others => '0');

------------------------------------------------------------------------
begin

    rgb_led1 <= data_from_test_interface(2 downto 0);
    rgb_led2 <= data_from_test_interface(5 downto 3);

------------------------------------------------------------------------
    u_communications : entity work.fpga_communications
        port map(
            clock                   => core_clock            ,
            uart_rx                 => uart_rx               ,
            uart_tx                 => uart_tx               ,
            bus_to_communications   => bus_to_communications ,
            bus_from_communications => bus_from_communications
        );

------------------------------------------------------------------------
        u_main_system_control : entity work.main_system_control
        port map (
            core_clock => core_clock,
            bus_to_main_system_control    => bus_from_communications,
            bus_from_main_system_control  => bus_from_main_system_control,
            main_system_control_interface => main_system_control_interface
        );
-----
        main_system_control_interface.boost_control_interface.inductor_current <= get_measurement(boost_model_interface , inductor_current) ;
        main_system_control_interface.boost_control_interface.input_voltage    <= get_measurement(boost_model_interface , inductor_current) ;
        main_system_control_interface.boost_control_interface.dc_link_voltage  <= get_measurement(boost_model_interface , dc_link_voltage)  ;

-----
        boost_control_ready <= main_system_control_interface.boost_control_interface.boost_control_ready;
        duty_ratio          <= main_system_control_interface.boost_control_interface.duty_ratio;

------------------------------------------------------------------------
------------------------------------------------------------------------
    boost_model_control : process(core_clock)
    begin
        if rising_edge(core_clock) then

            init_bus(bus_out);
            connect_read_only_data_to_address(bus_from_communications, bus_out, tubepsu_addresses_pkg.interconnect_test_address, 44252);
            connect_read_only_data_to_address(bus_from_communications, bus_out, tubepsu_addresses_pkg.sincos_address, abs(get_sine(sincos)));

            if write_to_address_is_requested(bus_from_communications, tubepsu_addresses_pkg.boost_control_enable) then
                if get_data(bus_from_communications) = 0 then
                    boost_control_is_enabled <= false;
                else
                    boost_control_is_enabled <= true;
                end if;
            end if;

            init_tx(test_interface);
            if write_to_address_is_requested(bus_from_communications, tubepsu_addresses_pkg.vhdl2019_interface_test_address) then
                write_data(test_interface, get_data(bus_from_communications));
            end if;
            if bus_feedback_is_ready(test_interface) then
                data_from_test_interface <= get_data_from_entity(test_interface);
            end if;

            connect_read_only_data_to_address(bus_from_communications, bus_out, tubepsu_addresses_pkg.vhdl2019_interface_test_address, data_from_test_interface);

            bus_to_communications <= bus_out              and
                                     bus_from_boost_model and
                                     bus_from_main_system_control;

            create_boost_model_interface(boost_model_interface);
            if boost_control_is_enabled then
                if boost_control_ready then
                    set_duty(boost_model_interface, duty_ratio);
                end if;
            else
                set_duty(boost_model_interface, to_fixed(0.999, 15));
            end if;

            if model_trigger_counter < integer(cl_parameters.timestep*128.0e6) then -- counter for 1us calculation time
                model_trigger_counter <= model_trigger_counter + 1;
            else
                model_trigger_counter <= 0;
                request_boost_calculation(boost_model_interface);
            end if;

            create_multiplier(sincos_multiplier);
            create_sincos(sincos_multiplier, sincos);

            sincos_counter <= sincos_counter + 1;
            if sincos_counter > 511 then
                sincos_counter <= 0;
                angle_rad16 <= angle_rad16 + 13;
                request_sincos(sincos, angle_rad16);
            end if;

        end if; --rising_edge
    end process boost_model_control;	

------------------------------------------------------------------------
    u_boost_model : entity work.boost_model
    generic map(boost_model_parameters => cl_parameters         ,
                initial_voltage        => 150.0                 ,
                load_current_address   => tubepsu_addresses_pkg.load_current_address  ,
                input_voltage_address  => tubepsu_addresses_pkg.input_voltage_address ,
                boost_current_address  => tubepsu_addresses_pkg.boost_current_address ,
                boost_voltage_address  => tubepsu_addresses_pkg.boost_voltage_address)
    port map(
        core_clock                  ,
        bus_from_communications     ,
        bus_from_boost_model        ,
        boost_model_interface.input ,
        boost_model_interface.output
        /* boost_model_interface */
    );
------------------------------------------------------------------------
    u_test_entity : entity work.test_entity
    port map(core_clock, test_interface);
------------------------------------------------------------------------
end rtl;
