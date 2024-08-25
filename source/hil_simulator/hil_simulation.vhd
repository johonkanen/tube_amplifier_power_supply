library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.boost_model_pkg.all;

    use work.fpga_interconnect_pkg.all;
    use work.boost_rtl_entity_interface_pkg.all;

    use work.real_to_fixed_pkg.all;
    use work.tubepsu_addresses_pkg;
    use work.boost_control_interface_pkg.all;
    use work.test_interface_pkg.all;
    use work.sincos_pkg.all;
    use work.multiplier_pkg.all;
----
entity hil_simulation is
    port (
        core_clock : in std_logic;
        bus_to_hil_simulation   : in fpga_interconnect_record;
        bus_from_hil_simulation : out fpga_interconnect_record;

        -- from boost control interface
        rtl_inductor_current : out integer range -2**15 to 2**15-1;
        rtl_input_voltage    : out integer range -2**15 to 2**15-1;
        rtl_dc_link_voltage  : out integer range -2**15 to 2**15-1;

        boost_control_ready     : in boolean ;
        duty_ratio              : in natural range 0 to 2**16-1
    );
end entity hil_simulation;

architecture rtl of hil_simulation is

    alias bus_from_communications is bus_to_hil_simulation;
    signal model_trigger_counter : natural range 0 to 255 := 0;
    signal bus_from_boost_model : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_model_control : fpga_interconnect_record := init_fpga_interconnect;

    constant cl_parameters : boost_model_parameters_record := (
        inductance  => 500.0e-6 ,
        capacitance => 320.0e-6 ,
        rl          => 100.0e-3 ,
        timestep    => 1.0e-6);

    signal boost_control_is_enabled : boolean                    := false;
    signal sincos_multiplier        : multiplier_record          := init_multiplier;
    signal sincos                   : sincos_record              := init_sincos;
    signal sincos_counter           : natural range 0 to 2**16-1 := 0;
    signal angle_rad16              : unsigned(15 downto 0)      := (others => '0');
    signal read_voltage             : boolean                    := false;

    signal boost_model_interface : boost_model_interface_record;

begin

    rtl_inductor_current   <= get_measurement(boost_model_interface , inductor_current) ;
    rtl_input_voltage      <= get_measurement(boost_model_interface , inductor_current) ;
    rtl_dc_link_voltage    <= get_measurement(boost_model_interface , dc_link_voltage)  ;


    combine_buses : process(bus_from_boost_model, bus_from_model_control)
        
    begin
        bus_from_hil_simulation <= bus_from_boost_model and 
                                   bus_from_model_control;

    end process combine_buses;	

------------------------------------------------------------------------
    boost_model_control : process(core_clock)
    begin
        if rising_edge(core_clock) then

            init_bus(bus_from_model_control);
            connect_read_only_data_to_address(bus_from_communications, bus_from_model_control, tubepsu_addresses_pkg.interconnect_test_address, 44252);
            connect_read_only_data_to_address(bus_from_communications, bus_from_model_control, tubepsu_addresses_pkg.sincos_address, abs(get_sine(sincos)));

            if write_to_address_is_requested(bus_from_communications, tubepsu_addresses_pkg.boost_control_enable) then
                if get_data(bus_from_communications) = 0 then
                    boost_control_is_enabled <= false;
                else
                    boost_control_is_enabled <= true;
                end if;
            end if;

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

            if sincos_is_ready(sincos) then
                multiply(sincos_multiplier, abs(get_sine(sincos)), to_fixed(100.0, 7));
                read_voltage <= true;
            end if;

            if read_voltage and multiplier_is_ready(sincos_multiplier) then
                read_voltage <= false;
                set_input_voltage(boost_model_interface, get_int_multiplier_result(sincos_multiplier, 15, 7, target_radix => 6));
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

end rtl;

----
