library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package sw_supply_ctrl_pkg is

    type sw_supply_control_clock_group is record
        core_clock : std_logic;
        modulator_clock : std_logic;
        modulator_clock2 : std_logic;
        reset_n : std_logic;
    end record;
    
    type sw_supply_control_FPGA_output_group is record
        -- PFC pwm
	    po2_pfc_pwm : std_logic_vector(1 downto 0);
        -- heater pwm
	    po2_ht_pri_pwm : std_logic_vector(1 downto 0);
	    po2_ht_sec_pwm : std_logic_vector(1 downto 0);
        -- DBH pwm
	    po2_DHB_pri_pwm : std_logic_vector(1 downto 0);
	    po2_DHB_sec_pwm : std_logic_vector(1 downto 0);
    end record;
    
    type sw_supply_control_data_input_group is record
        -- onboard ad data in
	    ada_bus : std_logic_vector(16 downto 0);
	    adb_bus : std_logic_vector(16 downto 0);
    end record;
    
    type sw_supply_control_data_output_group is record
	    ada_triggers       : work.ad_bus_pkg.t_ad_triggers;
	    adb_triggers       : work.ad_bus_pkg.t_ad_triggers;
	    ext_ad1_start      : std_logic;
	    ext_ad2_start      : std_logic;
	    std18_test_data : std_logic_vector(17 downto 0);
        test_data_rdy   : std_logic;
	    uart_ready_event	: std_logic;
	    uart_rx_data	: std_logic_vector(15 downto 0);
    end record;
    
    component sw_supply_control is
        port (
            sw_supply_control_clocks : in sw_supply_control_clock_group;
    
            sw_supply_control_FPGA_out : out sw_supply_control_FPGA_output_group;
    
            sw_supply_control_data_in : in sw_supply_control_data_input_group;
            sw_supply_control_data_out : out sw_supply_control_data_output_group
        );
    end component sw_supply_control;

end sw_supply_ctrl_pkg;
