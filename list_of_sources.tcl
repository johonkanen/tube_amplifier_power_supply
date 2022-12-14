proc read_sources {source_folder} \
{
    return \
    {
        /top/system_clocks_pkg.vhd

        /dsp/multiplier/multiplier_pkg.vhd
        /dsp/multiplier/multiplier_body.vhd
        /dsp/multiplier/multiplier.vhd
        /dsp/sincos/sincos_pkg.vhd
        /dsp/sincos/sincos.vhd

        /dsp/feedback_control/feedback_control_pkg.vhd
        /dsp/feedback_control/feedback_control.vhd

        /common/timing/timing_pkg.vhd
        /common/timing/delay_timer.vhd
        /common/typesdefs/typedefs_pkg.vhd
        /common/register_shifts/register_shifts_pkg.vhd

        /top/system_control/component_interconnect/ext_ad/spi3w_ads7056_driver.vhd 
        /top/system_control/component_interconnect/ext_ad/ext_ad_spi3w.vhd 

        /top/system_control/component_interconnect/uart/uart_pkg.vhd 
        /top/system_control/component_interconnect/uart/uart_tx.vhd 
        /top/system_control/component_interconnect/uart/uart_rx.vhd 
        /top/system_control/component_interconnect/uart/uart.vhd 
        /top/system_control/component_interconnect/uart/uart_event_ctrl.vhd 

        /top/system_control/component_interconnect/measurement_interface/onboard_ad_control/onboard_ad_control_pkg.vhd 
        /top/system_control/component_interconnect/measurement_interface/onboard_ad_control/onboard_ad_control_internal_pkg.vhd 
        /top/system_control/component_interconnect/measurement_interface/onboard_ad_control/onboard_ad_control.vhd 
        /top/system_control/component_interconnect/measurement_interface/measurement_interface_pkg.vhd 
        /top/system_control/component_interconnect/measurement_interface/measurement_interface.vhd 
        /top/system_control/component_interconnect/measurement_interface/psu_measurement_interface_pkg.vhd 

        /top/system_control/led_driver/led_driver_pkg.vhd 
        /top/system_control/led_driver/led_driver.vhd 

            /top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/deadtime_pkg.vhd
            /top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/deadtime.vhd
            /top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/phase_modulator_pkg.vhd
            /top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/phase_modulator.vhd
            /top/system_control/component_interconnect/power_supply_control/dhb_control/dhb_control_pkg.vhd
            /top/system_control/component_interconnect/power_supply_control/dhb_control/dhb_control.vhd

            /top/system_control/component_interconnect/power_supply_control/llc_control/llc_modulator/llc_modulator_pkg.vhd
            /top/system_control/component_interconnect/power_supply_control/llc_control/llc_modulator/llc_modulator.vhd
            /top/system_control/component_interconnect/power_supply_control/llc_control/llc_control_pkg.vhd
            /top/system_control/component_interconnect/power_supply_control/llc_control/llc_control_internal_pkg.vhd
            /top/system_control/component_interconnect/power_supply_control/llc_control/arch_llc_pi_control.vhd
            /top/system_control/component_interconnect/power_supply_control/llc_control/llc_control.vhd

            /top/system_control/component_interconnect/power_supply_control/pfc_control/pfc_modulator/pfc_modulator_pkg.vhd
            /top/system_control/component_interconnect/power_supply_control/pfc_control/pfc_modulator/pfc_modulator.vhd
            /top/system_control/component_interconnect/power_supply_control/pfc_control/pfc_control_pkg.vhd
            /top/system_control/component_interconnect/power_supply_control/pfc_control/arch_pfc_current_control.vhd
            /top/system_control/component_interconnect/power_supply_control/pfc_control/arch_pfc_voltage_control.vhd
            /top/system_control/component_interconnect/power_supply_control/pfc_control/pfc_control.vhd

        /top/system_control/component_interconnect/power_supply_control/power_supply_control_pkg.vhd
        /top/system_control/component_interconnect/power_supply_control/power_supply_control.vhd

        /top/system_control/component_interconnect/component_interconnect_pkg.vhd 
        /top/system_control/component_interconnect/component_interconnect.vhd 

        /top/system_control/system_control_pkg.vhd 
        /top/system_control/system_control_internal_pkg.vhd 
        /top/system_control/system_control.vhd 

        /top/top.vhd
    }
}
