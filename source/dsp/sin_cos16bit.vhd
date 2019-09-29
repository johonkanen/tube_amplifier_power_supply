library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

library work;
    use work.alu_routines_pkg.all;
    use work.sin_cos16bit_pkg.all;

entity sin_cos16bit is
    port (
        core_clk : in std_logic;
        rstn : in std_logic;

        si_start_sin_cos : in boolean;
        s16_angle : in signed(17 downto 0);

        mpy1_control : inout alu_control_signals;
        mpy2_control : inout alu_control_signals;

        so_sincos_busy : out std_logic;
        so_sincos_rdy : out std_logic;
        so18_sincos_out : out signed(17 downto 0)
    );
end entity sin_cos16bit;

architecture rtl of sin_cos16bit is

-- sin constants s1 51472 s3 84635 s5 40720
-- cos constants c0 16384 c2 80805 c4 64473

-- +/- pi/4 range sine and cosine approximation
--   z = angle^2;
--
--   prod = z*s5;
--   prod = z*(s3) - prod);
--   sin16 = (s1-prod)*angle;
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


    signal input_angle : int18;
    signal alu_ctrl : alu_control_signals;
    signal alu_ctrl2 : alu_control_signals;

begin
        input_angle <= to_integer(s16_angle);

sin_cos : process(core_clk)
    variable program_counter : integer range 0 to 7;
    variable mult1_result : sign36;
    variable angle2 : sign36;

    impure function "*"(a : integer := 0; b : integer := 0) return signed is
    begin
       alu_mult(a, b, alu_ctrl, mult1_result, program_counter);
    end function;

    impure function "*"(a : signed; b : integer := 0) return signed is
    begin
       alu_mult(to_integer(a), b, alu_ctrl, mult1_result, program_counter);
    end function;

begin
    if rising_edge(core_clk) then
        CASE program_counter is 
            WHEN 0 =>
                so_sincos_rdy <= '0';
                so18_sincos_out <= (others => '0');

                idle_mpy(mpy1_control); 
                idle_mpy(mpy2_control); 
                so_sincos_rdy <= '0';

                if si_start_sin_cos then
                    -- square input
                    angle2 := input_angle * input_angle;
                else
                    program_counter := 0;
                end if;
            WHEN 1 =>
                mult1_result := angle2(33 downto 16) * sin_factors.s5; 
                so_sincos_rdy <= '0';
            WHEN 2 =>
                mult1_result := angle2(33 downto 16) * (sin_factors.s3 - (mult1_result(30 downto 13))); 
                so_sincos_rdy <= '0';
            WHEN 3 =>
                mult1_result := (sin_factors.s1 - mult1_result(30 downto 13)) * input_angle; 
                so_sincos_rdy <= '0';
            WHEN 4 =>
                so18_sincos_out <= mult1_result(30 downto 13);
                so_sincos_rdy <= '1';
            WHEN others => 
                program_counter := 0;
        end CASE;

        if rstn = '0' then
            program_counter := 0;
        end if; -- rstn
    end if; --rising_edge
end process sin_cos;	

end rtl;
