library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;

package psu_measurement_interface_pkg is
--------------------------------------------------
    function pfc_I1_is_ready( adc : in onboard_ad_control_data_output_group) return boolean;
--------------------------------------------------
    function pfc_I2_is_ready( adc : in onboard_ad_control_data_output_group) return boolean;
--------------------------------------------------
    function DHB_current_is_ready( adc : in onboard_ad_control_data_output_group) return boolean;
--------------------------------------------------
    function LLC_current_is_ready( adc : in onboard_ad_control_data_output_group) return boolean;
--------------------------------------------------
    function dc_link_is_ready( adc : in onboard_ad_control_data_output_group) return boolean;
--------------------------------------------------
    function vac_is_ready( adc : in onboard_ad_control_data_output_group) return boolean;
--------------------------------------------------
------------------------------------------------------------------------
    procedure get_pfc_I1 (
        signal adc_data : in onboard_ad_control_data_output_group; signal pfc_I1 : out integer);
------------------------------------------------------------------------
    procedure get_pfc_I2 (
        signal adc_data : in onboard_ad_control_data_output_group; signal pfc_I2 : out integer);
------------------------------------------------------------------------
    procedure get_pfc_current (
        signal adc_data : in onboard_ad_control_data_output_group; signal pfc_current : out integer);
------------------------------------------------------------------------
    procedure get_DHB_current (
        signal adc_data : in onboard_ad_control_data_output_group; signal DHB_current : out integer);
------------------------------------------------------------------------
    procedure get_LLC_current (
        signal adc_data : in onboard_ad_control_data_output_group; signal LLC_current : out integer);
------------------------------------------------------------------------
    procedure get_vac (
        signal adc_data : in onboard_ad_control_data_output_group; signal vac : out integer);
------------------------------------------------------------------------
    procedure get_dc_link (
        signal adc_data : in onboard_ad_control_data_output_group; signal dc_link : out integer);
------------------------------------------------------------------------
end package psu_measurement_interface_pkg;





package body psu_measurement_interface_pkg is
------------------------------------------------------------------------
    function pfc_I1_is_ready ( adc : in onboard_ad_control_data_output_group) return boolean
    is 
    begin 
        return ad_channel_is_ready(adc.adb_measurements,3); 
    end pfc_I1_is_ready;
--------------------------------------------------
    function pfc_I2_is_ready( adc : in onboard_ad_control_data_output_group) return boolean
    is
    begin
        return ad_channel_is_ready(adc.ada_measurements,3);
    end;
------------------------------
    function DHB_current_is_ready( adc : in onboard_ad_control_data_output_group) return boolean
    is
    begin
        return ad_channel_is_ready(adc.adb_measurements,6);
    end;
------------------------------
    function LLC_current_is_ready( adc : in onboard_ad_control_data_output_group) return boolean
    is
    begin
        return ad_channel_is_ready(adc.adb_measurements,2);
    end;
------------------------------
    function vac_is_ready( adc : in onboard_ad_control_data_output_group) return boolean
    is
    begin
        return ad_channel_is_ready(adc.adb_measurements,1);
    end;
------------------------------
    function dc_link_is_ready( adc : in onboard_ad_control_data_output_group) return boolean
    is
    begin
        return ad_channel_is_ready(adc.adb_measurements,4);
    end;
--------------------------------------------------
    procedure get_pfc_I1
    (
        signal adc_data : in onboard_ad_control_data_output_group;
        signal pfc_I1 : out integer
    )
    is
    begin
        if ad_channel_is_ready(adc_data.adb_measurements,3) then
            pfc_I1 <= get_ad_measurement(adc_data.adb_measurements);
        end if;
    end get_pfc_I1;
------------------------------------------------------------------------
    procedure get_pfc_I2
    (
        signal adc_data : in onboard_ad_control_data_output_group;
        signal pfc_I2 : out integer
    )
    is
    begin
        if ad_channel_is_ready(adc_data.ada_measurements,3) then
            pfc_I2 <= get_ad_measurement(adc_data.adb_measurements);
        end if;
    end get_pfc_I2;
------------------------------------------------------------------------
    procedure get_pfc_current
    (
        signal adc_data : in onboard_ad_control_data_output_group;
        signal pfc_current : out integer
    )
    is
    begin
        if ad_channel_is_ready(adc_data.adb_measurements,5) then
            pfc_current <= get_ad_measurement(adc_data.adb_measurements);
        end if;
    end get_pfc_current;
------------------------------------------------------------------------
    procedure get_DHB_current
    (
        signal adc_data : in onboard_ad_control_data_output_group;
        signal DHB_current : out integer
    )
    is
    begin
        if ad_channel_is_ready(adc_data.adb_measurements,6) then
            DHB_current <= get_ad_measurement(adc_data.adb_measurements);
        end if;
    end get_DHB_current;
------------------------------------------------------------------------
    procedure get_LLC_current
    (
        signal adc_data : in onboard_ad_control_data_output_group;
        signal LLC_current : out integer
    )
    is
    begin
        if ad_channel_is_ready(adc_data.adb_measurements,2) then
            LLC_current <= get_ad_measurement(adc_data.adb_measurements);
        end if;
    end get_LLC_current;
------------------------------------------------------------------------
    procedure get_vac
    (
        signal adc_data : in onboard_ad_control_data_output_group;
        signal vac : out integer
    )
    is
    begin
        if ad_channel_is_ready(adc_data.adb_measurements,1) then
            vac <= get_ad_measurement(adc_data.adb_measurements);
        end if;
    end get_vac;
------------------------------------------------------------------------
    procedure get_dc_link
    (
        signal adc_data : in onboard_ad_control_data_output_group;
        signal dc_link : out integer
    )
    is
    begin
        if ad_channel_is_ready(adc_data.adb_measurements,4) then
            dc_link <= get_ad_measurement(adc_data.adb_measurements);
        end if;
    end get_dc_link;
------------------------------------------------------------------------
end package body psu_measurement_interface_pkg;
