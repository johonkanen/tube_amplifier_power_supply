library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package onboard_ad_control_pkg is

type onboard_ad_control_clock_group is record
    core_clock : std_logic;
    ad_clock : std_logic;
    reset_n : std_logic;
end record;

type onboard_ad_control_FPGA_input_group is record
    ada_data : std_logic;
    adb_data : std_logic;
end record;

type onboard_ad_control_FPGA_output_group is record
    ada_clock : std_logic;
    ada_mux : std_logic_vector(2 downto 0);
    adb_clock : std_logic;
    adb_mux : std_logic_vector(2 downto 0);
end record;

type onboard_ad_control_data_input_group is record
    ada_start_request : boolean;
    ada_mux_position : integer;
    adb_start_request : boolean;
    adb_mux_position : integer;
end record;

type onboard_ad_control_data_output_group is record
    ada_conversion_data : integer;
    ada_channel : integer;
    adb_conversion_data : integer;
    adb_channel : integer;
end record;

component onboard_ad_control is
    port (
        onboard_ad_control_clocks : in onboard_ad_control_clock_group;

        onboard_ad_control_FPGA_in : in onboard_ad_control_FPGA_input_group;
        onboard_ad_control_FPGA_out : out onboard_ad_control_FPGA_output_group;

        onboard_ad_control_data_in : in onboard_ad_control_data_input_group;
        onboard_ad_control_data_out : out onboard_ad_control_data_output_group
    );
end component onboard_ad_control;
    
end package onboard_ad_control_pkg;
