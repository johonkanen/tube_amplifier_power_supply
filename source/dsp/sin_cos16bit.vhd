library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

library work;
    use work.alu16bit_pkg.all;

entity sin_cos16bit is
    port (
        core_clk : in std_logic;
        rstn : in std_logic;

        si_start_sin_cos : in std_logic;
        s16_angle : in signed(17 downto 0);

        si36_mpy1_result : in std_logic_vector(35 downto 0); 
        si36_mpy2_result : in std_logic_vector(35 downto 0); 
        si_mult_rdy : in std_logic;

        so18_sincos_mpy1_a : out std_logic_vector(17 downto 0); 
        so18_sincos_mpy1_b : out std_logic_vector(17 downto 0); 

        so18_sincos_mpy2_a : out std_logic_vector(17 downto 0); 
        so18_sincos_mpy2_b : out std_logic_vector(17 downto 0); 

        so_sincos_start_mpy : out std_logic; 

        so_sincos_busy : out std_logic;
        so_sincos_rdy : out std_logic;
        so18_sincos_out : out std_logic_vector(17 downto 0)
    );
end entity sin_cos16bit;

architecture rtl of sin_cos16bit is

    subtype int18 is integer range -2**17 to 2**17-1;
-- sin constants s1 51472 s3 84635 s5 40720
-- cos constants c0 16384 c2 80805 c4 64473


--   z = angle^2;
--
--   prod = (z*s5);
--   summ = s3 - prod;
--   prod = (z*summ);
--   summ = s1-prod;
--
--   sin16 = summ*angle;
--
--   prod = (z*c4);
--   summ = c2-prod;
--   prod = z*summ;
--
--   cos16 = c0-prod;

    type sin_chebyshev18bit is record
        s1 : int18;
        s3 : int18;
        s5 : int18;    
    end record;
    constant sin_factors : sin_chebyshev18bit := (s1 => 51472, s3=> 84635, s5=> 40720);

    type cos_chebyshev18bit is record
        c0 : int18;
        c2 : int18;
        c4 : int18;    
    end record;
    constant cos_factors : cos_chebyshev18bit := (c0 => 16384, c2=> 80805, c4=> 64473);

    function rounded_mpy
    (
        mpy_out : std_logic_vector(35 downto 0)
    )
    return std_logic_vector
    is
    begin
        if mpy_out(14) = '1' then
            return std_logic_vector((unsigned(mpy_out(30 downto 15)) + 1));
        else
            return mpy_out(30 downto 15);
        end if;
    end rounded_mpy;


    procedure alu_mult
    (
        signal a : in integer;
        signal b : in integer;
        signal start_alu_mpy : out std_logic;
        signal mult_a : out std_logic_vector(17 downto 0);
        signal mult_b : out std_logic_vector(17 downto 0);
        signal mult_result : in std_logic_vector(35 downto 0);
        signal mult_is_ready : in boolean;
        signal result : out integer;
        signal increment_counter : inout integer
    ) is
    begin
        mult_a <= std_logic_vector(to_signed(a,18));
        mult_b <= std_logic_vector(to_signed(b,18));
        start_alu_mpy <= '1';
        if mult_is_ready then
            increment_counter <= increment_counter + 1;
            result <= to_integer(signed(mult_result));
            start_alu_mpy <= '0';
        end if;
    end alu_mult;

begin

div : process(core_clk)
    variable program_counter : integer range 0 to 7;
begin
    if rising_edge(core_clk) then
        if rstn = '0' then
            program_counter := 0;
        else
            CASE program_counter is 
                WHEN 0 =>
                    so_sincos_rdy <= '0';
                    so18_sincos_out <= (others => '0');

                    so18_sincos_mpy2_a <= (others => '0');
                    so18_sincos_mpy2_b <= (others => '0');
                    if si_start_sin_cos = '1' then
                        program_counter := program_counter + 1;
                        -- calculate square of the input angle
                        so18_sincos_mpy1_a <= std_logic_vector(s16_angle);
                        so18_sincos_mpy1_b <= std_logic_vector(s16_angle);
                        so_sincos_start_mpy <= '1';
                    else
                        program_counter := 0;
                        so18_sincos_mpy1_a <= (others => '0');
                        so18_sincos_mpy1_b <= (others => '0');
                        so_sincos_start_mpy <= '0';
                    end if;
                WHEN 1 =>
                    program_counter := program_counter + 1;
                WHEN others => 
                    program_counter := 0;
            end CASE;
        end if; -- rstn
    end if; --rising_edge
end process div;	

end rtl;
