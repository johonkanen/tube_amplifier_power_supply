-- VHDL module instantiation generated by SCUBA Diamond (64-bit) 3.11.0.396.4
-- Module  Version: 4.9
-- Mon Jul 22 08:12:06 2019

-- parameterized module component declaration
component pipelined_multiplier
    port (Clock: in  std_logic; ClkEn: in  std_logic; 
        Aclr: in  std_logic; DataA: in  std_logic_vector(17 downto 0); 
        DataB: in  std_logic_vector(17 downto 0); 
        Result: out  std_logic_vector(35 downto 0));
end component;

-- parameterized module component instance
__ : pipelined_multiplier
    port map (Clock=>__, ClkEn=>__, Aclr=>__, DataA(17 downto 0)=>__, 
        DataB(17 downto 0)=>__, Result(35 downto 0)=>__);
