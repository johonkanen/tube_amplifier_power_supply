proc read_sources {source_folder} \
{
    return \
    {
        /top/system_clocks_pkg.vhd
        /top/system_control/component_interconnect/ext_ad/spi3w_ads7056_driver.vhd 
        /top/system_control/component_interconnect/ext_ad/ext_ad_spi3w.vhd 
        /top/system_control/component_interconnect/ext_ad/ad_bus_pkg.vhd 

        /top/system_control/component_interconnect/uart/uart_pkg.vhd 
        /top/system_control/component_interconnect/uart/uart_tx.vhd 
        /top/system_control/component_interconnect/uart/uart_rx.vhd 
        /top/system_control/component_interconnect/uart/uart.vhd 
        /top/system_control/component_interconnect/uart/uart_event_ctrl.vhd 

        /top/system_control/component_interconnect/onboard_ad_control/onboard_ad_control_pkg.vhd 
        /top/system_control/component_interconnect/onboard_ad_control/onboard_ad_control_internal_pkg.vhd 
        /top/system_control/component_interconnect/onboard_ad_control/onboard_ad_control.vhd 

        /top/system_control/component_interconnect/component_interconnect_pkg.vhd 
        /top/system_control/component_interconnect/component_interconnect.vhd 

        /top/system_control/led_driver/led_driver_pkg.vhd 
        /top/system_control/led_driver/led_driver.vhd 

        /top/system_control/system_control_pkg.vhd 
        /top/system_control/system_control.vhd 

        /top/top.vhd
    }
}
