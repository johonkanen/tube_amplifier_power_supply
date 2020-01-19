library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;


entity multiplier_18x18 IS
    PORT
        (
            clock		: IN STD_LOGIC ;
            dataa		: IN STD_LOGIC_VECTOR (17 DOWNTO 0);
            datab		: IN STD_LOGIC_VECTOR (17 DOWNTO 0);
            result		: OUT STD_LOGIC_VECTOR (35 DOWNTO 0)
        );
END entity;

architecture sim of multiplier_18x18 is

    signal dataa_buf : std_logic_vector(17 downto 0); 
    signal datab_buf : std_logic_vector(17 downto 0); 
    signal result_buf : std_logic_vector(35 downto 0);
    signal result1_buf : std_logic_vector(35 downto 0);

begin

    multiply : process(clock)
    begin
        if rising_edge(clock) then
            dataa_buf <= dataa;
            datab_buf <= datab;
            -- result_buf <= std_logic_vector(signed(dataa) * signed(datab));
            -- result1_buf <= (result_buf);
            result_buf <= std_logic_vector(signed(dataa) * signed(datab));
            result1_buf <= result_buf;
            result <= result1_buf;
        end if; --rising_edge
    end process multiply;	


end sim;
