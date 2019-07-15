library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.vendor_specifics_pkg.all;
    use work.alu16bit_pkg.all;

entity alu16bit is
    port (
        core_clk : in std_logic;
        rstn : in std_logic;

        tg_cmd_rdy : in std_logic;
        alu_command : in t_alu_commands;
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
    signal r1_tg_cmd_rdy : std_logic;  
begin

mpy1 : combi_mult_18x18
    port map(core_clk, mpy1_a, mpy1_b, mpy1_result);

mpy2 : combi_mult_18x18
    port map(core_clk, mpy2_a, mpy2_b, mpy2_result);

    alu_commands : process(core_clk)
        type t_alu_states is (idle, add_out,sub_out,mpy_calc,mpy_out,div_d1,div_d2,div_out,sqrt_d1,sqrt_d2,sqrt_out);
        variable st_alu_states : t_alu_states;
        
    begin
        if rising_edge(core_clk) then
            if rstn = '0' then
            -- reset state
                mpy1_a <= (others => '0');
                mpy1_b <= (others => '0');
                mpy2_a <= (others => '0');
                mpy2_b <= (others => '0');
                data_rdy <= '0';
                data_out <= (others => '0');
                st_alu_states := idle;
                r1_tg_cmd_rdy <= '0';
            else
                r1_tg_cmd_rdy <= tg_cmd_rdy;

                CASE st_alu_states is 
                    WHEN idle =>
                        data_rdy <= '0';
                        if r1_tg_cmd_rdy = not tg_cmd_rdy then
                            CASE alu_command is
                                WHEN add => 
                                    data_out <= data1 + data2;
                                    st_alu_states := add_out;
                                WHEN sub => 
                                    data_out <= data1 - data2;
                                    st_alu_states := sub_out;
                                WHEN a_mpy_b => 
                                    mpy1_a <= std_logic_vector(data1);
                                    mpy1_b <= std_logic_vector(data2);
                                    st_alu_states := mpy_calc;
                                WHEN a_div_b => 
                                WHEN sqrt_a => 
                                WHEN others =>
                            end CASE;
                        end if;
                    WHEN add_out =>
                        data_rdy <= '1';
                        st_alu_states := idle;

                    WHEN sub_out =>
                        data_rdy <= '1';
                        st_alu_states := idle;
                        
                        -- delay of one clock to account for multiplier pipeline stage
                    WHEN mpy_calc =>
                        st_alu_states := mpy_out;
                    WHEN mpy_out =>
                        data_out <= signed(mpy1_result(34 downto 17));
                        data_rdy <= '1';
                        st_alu_states := idle;

                when others =>
                    st_alu_states := idle;
            end CASE;
            end if; -- rstn
        end if; --rising_edge
    end process ;	


end rtl;

