library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.vendor_specifics_pkg.all;

entity alu16bit is
    port (
        core_clk : in std_logic;
        rstn : in std_logic;

        alu_command : in std_logic;
        data1 : in signed(17 downto 0);
        data2 : in signed(17 downto 0);

        data_rdy : out std_logic;
        data_out : out signed(17 downto 0)
    );
end entity alu16bit;

architecture rtl of alu16bit is

    
    component combi_mult_18x18 is 
        port (
            CLK : in std_logic;
            A : in std_logic_vector(17 downto 0);
            B : in std_logic_vector(17 downto 0);
            P : out std_logic_vector(35 downto 0)
        );
    end component;
    signal mpy1_a : std_logic_vector(17 downto 0); 
    signal mpy1_b : std_logic_vector(17 downto 0); 
    signal mpy1_result : std_logic_vector(35 downto 0); 

    signal mpy2_a : std_logic_vector(17 downto 0); 
    signal mpy2_b : std_logic_vector(17 downto 0); 
    signal mpy2_result : std_logic_vector(35 downto 0); 
begin

mpy1 : combi_mult_18x18
    port map(core_clk, mpy1_a, mpy1_b, mpy1_result);

mpy2 : combi_mult_18x18
    port map(core_clk, mpy2_a, mpy2_b, mpy2_result);

alu_commands : process(core_clk)
        
    begin
        if rising_edge(core_clk) then
            if rstn = '0' then
            -- reset state
                mpy1_a <= (others => '0');
                mpy1_b <= (others => '0');
                mpy2_a <= (others => '0');
                mpy2_b <= (others => '0');
                data_rdy <= '0';
            else
    
            end if; -- rstn
        end if; --rising_edge
    end process ;	


end rtl;

