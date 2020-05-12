library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;

library work;
    use work.power_supply_control_pkg.all;
    use work.pfc_control_pkg.all;
    use work.llc_control_pkg.all;
    use work.dhb_control_pkg.all;

entity power_supply_control is
    port (
        power_supply_control_clocks   : in power_supply_control_clock_group;
        power_supply_control_FPGA_out : out power_supply_control_FPGA_output_group;
        power_supply_control_data_in  : in power_supply_control_data_input_group;
        power_supply_control_data_out : out power_supply_control_data_output_group
    );
end entity power_supply_control;

architecture rtl of power_supply_control is

-------------------- simplify signal naming ----------------------------
    alias measurement_interface_data_in  is power_supply_control_data_out.measurement_interface_data_in;
    alias measurement_interface_data_out is power_supply_control_data_in.measurement_interface_data_out;
    alias modulator_clock                is power_supply_control_clocks.modulator_clock;
    alias core_clock                     is power_supply_control_clocks.core_clock;
    alias pll_lock                       is power_supply_control_clocks.pll_lock;
------------------------------------------------------------------------
    signal ada_triggers : muxed_ad_control;
    signal adb_triggers : muxed_ad_control;
    signal dhb_trigger : std_logic;
    signal llc_trigger : std_logic;
------------------------------------------------------------------------
    signal master_carrier : integer range 0 to 2**12-1;
------------------------------------------------------------------------
    signal pfc_control_clocks   : pfc_control_clock_group;
    signal pfc_control_data_in  : pfc_control_data_input_group;
    signal pfc_control_data_out : pfc_control_data_output_group;
------------------------------------------------------------------------
    signal llc_control_clocks   : llc_control_clock_group;
    signal llc_control_data_in  : llc_control_data_input_group;
    signal llc_control_data_out : llc_control_data_output_group;
------------------------------------------------------------------------
    signal dhb_control_clocks   : dhb_control_clock_group;
    signal dhb_control_data_in  : dhb_control_data_input_group;
    signal dhb_control_data_out : dhb_control_data_output_group;
------------------------------------------------------------------------
    constant carrier_maximum : integer := 1896;
begin

------------------------------------------------------------------------
    power_supply_sequencer : process(core_clock)

        type t_power_supply_sequencer is (wait_for_start, start_pfc, start_llc, start_dhb, psu_running);
        variable st_power_supply_sequencer : t_power_supply_sequencer;
        --------------------------------------------------
        procedure change_state_to (
            variable state : out t_power_supply_sequencer;
            next_state : t_power_supply_sequencer;
            next_state_is_requested : boolean) is
        begin
            if next_state_is_requested then
                state := next_state;
            end if; 
        end change_state_to;
        -------------------------------------------------- 
    begin
        if rising_edge(core_clock) then
            if pll_lock = '0' then
            -- reset state
                disable_pfc(pfc_control_data_in);
                disable_llc(llc_control_data_in);
                disable_dhb(dhb_control_data_in);
                st_power_supply_sequencer := wait_for_start;

            else
                CASE st_power_supply_sequencer is
                    WHEN wait_for_start =>

                        disable_pfc(pfc_control_data_in);
                        disable_llc(llc_control_data_in);
                        disable_dhb(dhb_control_data_in);

                        if power_supplies_are_enabled(power_supply_control_data_in) then
                            st_power_supply_sequencer := start_pfc;
                        end if;
                    WHEN start_pfc =>
                        enable_pfc(pfc_control_data_in);

                        -- TOO, add pfc startup routing
                        st_power_supply_sequencer := start_llc;
                    WHEN start_llc =>

                        enable_llc(llc_control_data_in);
                        -- TOO, add llc startup routing
                        st_power_supply_sequencer := start_dhb;

                    WHEN start_dhb =>

                        enable_dhb(dhb_control_data_in);

                    WHEN others =>
                        -- do nothing
                end CASE;

            -- if all power supplies are operational, signal all is good

            end if; -- rstn
        end if; --rising_edge
    end process power_supply_sequencer;	

------------------------------------------------------------------------
    -- free running carrier common for pfc and dhb controls, and used for triggering adc
------------------------------------------------------------------------
    carrier_generation : process(power_supply_control_clocks.modulator_clock) 
    begin
        if rising_edge(power_supply_control_clocks.modulator_clock) then
                measurement_interface_data_in.onboard_ad_control_data_in.ada_triggers <= ada_triggers;
                measurement_interface_data_in.onboard_ad_control_data_in.adb_triggers <= ada_triggers;
                measurement_interface_data_in.dhb_ad_start_request_toggle <= dhb_trigger;
                measurement_interface_data_in.llc_ad_start_request_toggle <= llc_trigger;
                -- register carrier for pfc and dhb to shorten logic path
                pfc_control_data_in.pfc_carrier <= master_carrier;
                dhb_control_data_in.dhb_carrier <= master_carrier;

                master_carrier <= master_carrier + 1;
                if master_carrier > carrier_maximum then
                    master_carrier <= 0;
                end if;

                CASE master_carrier is
                    WHEN 6 =>
                        -- pfc current measurement
                        trigger_adc(ada_triggers,6);
                        trigger_adc(adb_triggers,6);
                    WHEN 300 =>
                        --dhb_I
                        trigger_adc(ada_triggers,0);
                        trigger_adc(adb_triggers,2);
                    WHEN 500 =>
                        --heater_I
                        trigger_adc(ada_triggers,1);
                        trigger_adc(adb_triggers,6);
                    WHEN 700 =>
                        --dhb_I
                        trigger_adc(ada_triggers,2);
                        trigger_adc(adb_triggers,2);
                    WHEN 900 =>
                        --heater_I
                        trigger_adc(ada_triggers,4);
                        trigger_adc(adb_triggers,6);

                        trigger_ext_ad(llc_trigger);
                        trigger_ext_ad(dhb_trigger);
                    WHEN 1200 =>
                        --heater_I
                        trigger_adc(ada_triggers,5);
                        trigger_adc(adb_triggers,6);
                    WHEN 1500 =>
                        -- vaux & vac
                        trigger_adc(ada_triggers,3);
                        trigger_adc(adb_triggers,3);
                    WHEN others =>
                        -- do nothing
                end CASE;
        end if; --rising_edge
    end process carrier_generation;	
------------------------------------------------------------------------

---------------------- pfc control --------------------------------------
    pfc_control_clocks <= ( core_clock      => core_clock,
                            modulator_clock => modulator_clock,
                            pll_lock        => pll_lock);
    pfc_control_data_in.measurement_interface_data_out <= measurement_interface_data_out;
    u_pfc_control : pfc_control
        generic map(carrier_maximum)
        port map
        (
            pfc_control_clocks, 
            power_supply_control_FPGA_out.pfc_control_FPGA_out, 
            pfc_control_data_in, 
            pfc_control_data_out  
        );
---------------------- llc control -------------------------------------
    llc_control_clocks <= ( core_clock      => core_clock,
                            modulator_clock => modulator_clock,
                            pll_lock        => pll_lock);
    llc_control_data_in.measurement_interface_data_out <= measurement_interface_data_out;
    u_llc_control : llc_control
        port map
        (
            llc_control_clocks,
            power_supply_control_FPGA_out.llc_control_FPGA_out,
            llc_control_data_in,
            llc_control_data_out
        );
---------------------- dhb control -------------------------------------
    dhb_control_clocks <= ( core_clock      => core_clock,
                            modulator_clock => modulator_clock,
                            pll_lock        => pll_lock);
    dhb_control_data_in.measurement_interface_data_out <= measurement_interface_data_out;
    u_dhb_control : dhb_control
        generic map(carrier_maximum)
        port map
        (
            dhb_control_clocks,
            power_supply_control_FPGA_out.dhb_control_FPGA_out,
            dhb_control_data_in,
            dhb_control_data_out
        );
------------------------------------------------------------------------
end rtl;
