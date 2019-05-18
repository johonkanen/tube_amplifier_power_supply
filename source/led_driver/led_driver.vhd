library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    use ieee.numeric_std.all;

entity led_driver is
    port(
			led_clk : in std_logic;
			po3_led1 : out std_logic_vector(2 downto 0);
			po3_led2 : out std_logic_vector(2 downto 0);
			po3_led3 : out std_logic_vector(2 downto 0);

			u9_led1_blu : in unsigned(8 downto 0);	
			u9_led1_grn : in unsigned(8 downto 0);	
			u9_led1_red : in unsigned(8 downto 0);	
	
			u9_led2_blu : in unsigned(8 downto 0);	
			u9_led2_grn : in unsigned(8 downto 0);	
			u9_led2_red : in unsigned(8 downto 0);	
	
			u9_led3_blu : in unsigned(8 downto 0);	
			u9_led3_grn : in unsigned(8 downto 0);	
			u9_led3_red : in unsigned(8 downto 0)
        );
end led_driver;

architecture rtl of led_driver is

	alias aka_po_led1_blu : std_logic is po3_led1(2);
	alias aka_po_led1_grn : std_logic is po3_led1(1);
	alias aka_po_led1_red : std_logic is po3_led1(0);

	alias aka_po_led2_blu : std_logic is po3_led2(2);
	alias aka_po_led2_grn : std_logic is po3_led2(1);
	alias aka_po_led2_red : std_logic is po3_led2(0);

	alias aka_po_led3_blu : std_logic is po3_led3(2);
	alias aka_po_led3_grn : std_logic is po3_led3(1);
	alias aka_po_led3_red : std_logic is po3_led3(0);

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

			if carrier < u9_led1_blu then
				aka_po_led1_blu <= '0';
			else
				aka_po_led1_blu <= '1';
			end if;
			if carrier < u9_led1_grn then
				aka_po_led1_grn <= '0';
			else
				aka_po_led1_grn <= '1';
			end if;
			if carrier < u9_led1_red then
				aka_po_led1_red <= '0';
			else
				aka_po_led1_red <= '1';
			end if;
		end if;

		if rising_edge(led_clk) then

			if carrier < u9_led2_blu then
				aka_po_led2_blu <= '0';
			else
				aka_po_led2_blu <= '1';
			end if;
			if carrier < u9_led2_grn then
				aka_po_led2_grn <= '0';
			else
				aka_po_led2_grn <= '1';
			end if;
			if carrier < u9_led2_red then
				aka_po_led2_red <= '0';
			else
				aka_po_led2_red <= '1';
			end if;
		end if;
		
		if rising_edge(led_clk) then

			if carrier < u9_led3_blu then
				aka_po_led3_blu <= '0';
			else
				aka_po_led3_blu <= '1';
			end if;
			if carrier < u9_led3_grn then
				aka_po_led3_grn <= '0';
			else
				aka_po_led3_grn <= '1';
			end if;
			if carrier < u9_led3_red then
				aka_po_led3_red <= '0';
			else
				aka_po_led3_red <= '1';
			end if;
		end if;
	    end process;
	end rtl;
