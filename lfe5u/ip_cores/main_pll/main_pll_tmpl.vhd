-- VHDL module instantiation generated by SCUBA Diamond (64-bit) 3.11.1.441
-- Module  Version: 5.7
-- Fri Jan 17 00:27:27 2020

-- parameterized module component declaration
component main_pll
    port (CLKI: in  std_logic; CLKOP: out  std_logic; 
        CLKOS: out  std_logic; LOCK: out  std_logic);
end component;

-- parameterized module component instance
__ : main_pll
    port map (CLKI=>__, CLKOP=>__, CLKOS=>__, LOCK=>__);
