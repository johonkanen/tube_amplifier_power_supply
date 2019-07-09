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

    component mpy18x18 is
    port (
        A: in  std_logic_vector(17 downto 0); 
        B: in  std_logic_vector(17 downto 0); 
        P: out  std_logic_vector(35 downto 0));
end component;

begin
    multiplier_wrapper : mpy18x18
    port map(A, B, P);



end rtl;
