library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    use ieee.numeric_std.all;

library work;
    use work.led_driver_pkg.all;
    use work.top_pkg.all;

entity led_driver is
    port(
			led_clk : in std_logic;
			po3_led1 : out rgb_led;
			po3_led2 : out rgb_led;
			po3_led3 : out rgb_led;

            led1_ctrl : in led_counters;
            led2_ctrl : in led_counters;
            led3_ctrl : in led_counters

        );
end led_driver;

architecture rtl of led_driver is

	signal carrier : unsigned(8 downto 0);

begin

	led_carrier : process(led_clk) 

	begin
	
		if rising_edge(led_clk) then
			carrier <= carrier + 1;
		end if;
	end process led_carrier;


	led1_pwm : process(led_clk) 

	begin
		if rising_edge(led_clk) then

			if carrier < led1_ctrl.u9_blu_duty then
				po3_led1.blue <= '0';
			else
				po3_led1.blue <= '1';
			end if;
			if carrier < led1_ctrl.u9_grn_duty then
				po3_led1.green <= '0';
			else
				po3_led1.green <= '1';
			end if;
			if carrier < led1_ctrl.u9_red_duty then
				po3_led1.red <= '0';
			else
				po3_led1.red <= '1';
			end if;
		end if;

		if rising_edge(led_clk) then

			if carrier < led2_ctrl.u9_blu_duty then
				po3_led2.blue <= '0';
			else
				po3_led2.blue <= '1';
			end if;
			if carrier < led2_ctrl.u9_grn_duty then
				po3_led2.green <= '0';
			else
				po3_led2.green <= '1';
			end if;
			if carrier < led2_ctrl.u9_red_duty then
				po3_led2.red <= '0';
			else
				po3_led2.red <= '1';
			end if;
		end if;
		
		if rising_edge(led_clk) then

			if carrier < led3_ctrl.u9_blu_duty then
				po3_led3.blue <= '0';
			else
				po3_led3.blue <= '1';
			end if;
			if carrier < led3_ctrl.u9_grn_duty then
				po3_led3.green <= '0';
			else
				po3_led3.green <= '1';
			end if;
			if carrier < led3_ctrl.u9_red_duty then
				po3_led3.red <= '0';
			else
				po3_led3.red <= '1';
			end if;
		end if;
	    end process;
	end rtl;
