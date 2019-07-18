library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package alu_routines_pkg is

    procedure sum_a_b
    (
        signal data_a : in signed(17 downto 0); 
        signal data_b : in signed(17 downto 0); 
        signal result : out signed(17 downto 0)
    );

    function sum_a_b
    (
        data_a : in signed(17 downto 0); 
        data_b : in signed(17 downto 0)
    )
    return signed;

    function sub_a_b
    (
        data_a : in signed(17 downto 0); 
        data_b : in signed(17 downto 0)
    )
    return signed;
end package;

package body alu_routines_pkg is

    procedure sum_a_b
    (
        signal data_a : in signed(17 downto 0); 
        signal data_b : in signed(17 downto 0); 
        signal result : out signed(17 downto 0)
    ) is
    begin
        result <= data_a + data_b;
    end sum_a_b;

    function sum_a_b
    (
        data_a : in signed(17 downto 0); 
        data_b : in signed(17 downto 0)
    )
    return signed
    is
    begin
        return data_a + data_b;
    end sum_a_b;

    function sub_a_b
    (
        data_a : in signed(17 downto 0); 
        data_b : in signed(17 downto 0)
    )
    return signed
    is
    begin
        return data_a - data_b;
    end sub_a_b;

end package body;
