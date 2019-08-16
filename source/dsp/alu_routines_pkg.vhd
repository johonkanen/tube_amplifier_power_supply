library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package alu_routines_pkg is

type int16 is record
    data : integer range -32768 to 32767;
end record;

type uint16 is record
    data : integer range 0 to 65535;
end record;
 
subtype int18 is 
    integer range -131072 to 131071;

subtype uint18 is 
    integer range 0 to 262143;


    procedure sum_a_b
    (
        signal data_a : in signed(17 downto 0); 
        signal data_b : in signed(17 downto 0); 
        signal result : out signed(17 downto 0)
    );
end;

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

    procedure alu_mult
    (
        rstn : in boolean;
        data1 : in int18;
        data2 : in int18;
        start_mult : out boolean;
        mult_rdy : in boolean;
        result : inout int18
    ) is
        type t_mult_wait is (idle,done);
        variable st_mult_wait : t_mult_wait;
    begin
        if mult_rdy then
        end if;
    end alu_mult;

end package body;
