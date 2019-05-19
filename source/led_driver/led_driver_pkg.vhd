library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package led_driver_pkg is

type led_counters is record
    u9_blu_duty : unsigned(8 downto 0);
    u9_grn_duty : unsigned(8 downto 0);
    u9_red_duty : unsigned(8 downto 0);
end record;

component led_driver is
    port(
			led_clk : in std_logic;
			po3_led1 : out std_logic_vector(2 downto 0);
			po3_led2 : out std_logic_vector(2 downto 0);
			po3_led3 : out std_logic_vector(2 downto 0);

            led1_ctrl : in led_counters;
            led2_ctrl : in led_counters;
            led3_ctrl : in led_counters
        );
end component;


constant led_color_red : led_counters := (9d"0", 9d"0", 9d"80");
constant led_color_grn : led_counters := (9d"0", 9d"50", 9d"0");
constant led_color_blu : led_counters := (9d"80", 9d"0", 9d"0");

end led_driver_pkg;
