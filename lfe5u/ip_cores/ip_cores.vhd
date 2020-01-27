



--
-- Verific VHDL Description of module ip_cores
--

library ieee ;
use ieee.std_logic_1164.all ;

entity ip_cores is
    port (multiplier_18x18_DataA: in std_logic_vector(17 downto 0);
        multiplier_18x18_DataB: in std_logic_vector(17 downto 0);
        multiplier_18x18_Result: out std_logic_vector(35 downto 0);
        adc_clock_CLKI: in std_logic;
        adc_clock_CLKOP: out std_logic;
        adc_clock_LOCK: out std_logic;
        main_pll_CLKI: in std_logic;
        main_pll_CLKOP: out std_logic;
        main_pll_CLKOS: out std_logic;
        main_pll_LOCK: out std_logic;
        multiplier_18x18_Aclr: in std_logic;
        multiplier_18x18_ClkEn: in std_logic;
        multiplier_18x18_Clock: in std_logic
    );
    
end entity ip_cores; -- sbp_module=true 

architecture ip_cores of ip_cores is 
    component adc_clock is
        port (CLKI: in std_logic;
            CLKOP: out std_logic;
            LOCK: out std_logic
        );
        
    end component adc_clock; -- not_need_bbox=true 
    
    
    component main_pll is
        port (CLKI: in std_logic;
            CLKOP: out std_logic;
            CLKOS: out std_logic;
            LOCK: out std_logic
        );
        
    end component main_pll; -- not_need_bbox=true 
    
    
    component multiplier_18x18 is
        port (DataA: in std_logic_vector(17 downto 0);
            DataB: in std_logic_vector(17 downto 0);
            Result: out std_logic_vector(35 downto 0);
            Aclr: in std_logic;
            ClkEn: in std_logic;
            Clock: in std_logic
        );
        
    end component multiplier_18x18; -- not_need_bbox=true 
    
    
    
begin
    adc_clock_inst: component adc_clock port map (CLKI=>adc_clock_CLKI,CLKOP=>adc_clock_CLKOP,
            LOCK=>adc_clock_LOCK);
    main_pll_inst: component main_pll port map (CLKI=>main_pll_CLKI,CLKOP=>main_pll_CLKOP,
            CLKOS=>main_pll_CLKOS,LOCK=>main_pll_LOCK);
    multiplier_18x18_inst: component multiplier_18x18 port map (DataA(17)=>multiplier_18x18_DataA(17),
            DataA(16)=>multiplier_18x18_DataA(16),DataA(15)=>multiplier_18x18_DataA(15),
            DataA(14)=>multiplier_18x18_DataA(14),DataA(13)=>multiplier_18x18_DataA(13),
            DataA(12)=>multiplier_18x18_DataA(12),DataA(11)=>multiplier_18x18_DataA(11),
            DataA(10)=>multiplier_18x18_DataA(10),DataA(9)=>multiplier_18x18_DataA(9),
            DataA(8)=>multiplier_18x18_DataA(8),DataA(7)=>multiplier_18x18_DataA(7),
            DataA(6)=>multiplier_18x18_DataA(6),DataA(5)=>multiplier_18x18_DataA(5),
            DataA(4)=>multiplier_18x18_DataA(4),DataA(3)=>multiplier_18x18_DataA(3),
            DataA(2)=>multiplier_18x18_DataA(2),DataA(1)=>multiplier_18x18_DataA(1),
            DataA(0)=>multiplier_18x18_DataA(0),DataB(17)=>multiplier_18x18_DataB(17),
            DataB(16)=>multiplier_18x18_DataB(16),DataB(15)=>multiplier_18x18_DataB(15),
            DataB(14)=>multiplier_18x18_DataB(14),DataB(13)=>multiplier_18x18_DataB(13),
            DataB(12)=>multiplier_18x18_DataB(12),DataB(11)=>multiplier_18x18_DataB(11),
            DataB(10)=>multiplier_18x18_DataB(10),DataB(9)=>multiplier_18x18_DataB(9),
            DataB(8)=>multiplier_18x18_DataB(8),DataB(7)=>multiplier_18x18_DataB(7),
            DataB(6)=>multiplier_18x18_DataB(6),DataB(5)=>multiplier_18x18_DataB(5),
            DataB(4)=>multiplier_18x18_DataB(4),DataB(3)=>multiplier_18x18_DataB(3),
            DataB(2)=>multiplier_18x18_DataB(2),DataB(1)=>multiplier_18x18_DataB(1),
            DataB(0)=>multiplier_18x18_DataB(0),Result(35)=>multiplier_18x18_Result(35),
            Result(34)=>multiplier_18x18_Result(34),Result(33)=>multiplier_18x18_Result(33),
            Result(32)=>multiplier_18x18_Result(32),Result(31)=>multiplier_18x18_Result(31),
            Result(30)=>multiplier_18x18_Result(30),Result(29)=>multiplier_18x18_Result(29),
            Result(28)=>multiplier_18x18_Result(28),Result(27)=>multiplier_18x18_Result(27),
            Result(26)=>multiplier_18x18_Result(26),Result(25)=>multiplier_18x18_Result(25),
            Result(24)=>multiplier_18x18_Result(24),Result(23)=>multiplier_18x18_Result(23),
            Result(22)=>multiplier_18x18_Result(22),Result(21)=>multiplier_18x18_Result(21),
            Result(20)=>multiplier_18x18_Result(20),Result(19)=>multiplier_18x18_Result(19),
            Result(18)=>multiplier_18x18_Result(18),Result(17)=>multiplier_18x18_Result(17),
            Result(16)=>multiplier_18x18_Result(16),Result(15)=>multiplier_18x18_Result(15),
            Result(14)=>multiplier_18x18_Result(14),Result(13)=>multiplier_18x18_Result(13),
            Result(12)=>multiplier_18x18_Result(12),Result(11)=>multiplier_18x18_Result(11),
            Result(10)=>multiplier_18x18_Result(10),Result(9)=>multiplier_18x18_Result(9),
            Result(8)=>multiplier_18x18_Result(8),Result(7)=>multiplier_18x18_Result(7),
            Result(6)=>multiplier_18x18_Result(6),Result(5)=>multiplier_18x18_Result(5),
            Result(4)=>multiplier_18x18_Result(4),Result(3)=>multiplier_18x18_Result(3),
            Result(2)=>multiplier_18x18_Result(2),Result(1)=>multiplier_18x18_Result(1),
            Result(0)=>multiplier_18x18_Result(0),Aclr=>multiplier_18x18_Aclr,
            ClkEn=>multiplier_18x18_ClkEn,Clock=>multiplier_18x18_Clock);
    
end architecture ip_cores; -- sbp_module=true 

