library ieee;
    use ieee.std_logic_1164.all;
        use ieee.numeric_std.all;

entity combi_mult_18x18 is
    port (
    CLK : in std_logic;
    A : in std_logic_vector(17 downto 0);
    B : in std_logic_vector(17 downto 0);
    P : out std_logic_vector(35 downto 0)
    );
end combi_mult_18x18;

architecture rtl of combi_mult_18x18 is

COMPONENT mult_sign18x18
  PORT (
    clk : IN STD_LOGIC;
    a : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    p : OUT STD_LOGIC_VECTOR(35 DOWNTO 0)
  );
END COMPONENT;

begin
    multiplier_wrapper : mult_sign18x18
    port map(CLK, A, B, P);



end rtl;
