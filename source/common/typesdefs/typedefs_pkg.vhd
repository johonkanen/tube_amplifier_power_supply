library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package typedefines_pkg is

    subtype uint8 is integer range 0 to 2**8-1;
    subtype uint9 is integer range 0 to 2**9-1;
    subtype uint10 is integer range 0 to 2**10-1;
    subtype uint11 is integer range 0 to 2**11-1;
    subtype uint12 is integer range 0 to 2**12-1;
    subtype uint13 is integer range 0 to 2**13-1;
    subtype uint14 is integer range 0 to 2**14-1;
    subtype uint15 is integer range 0 to 2**15-1;
    subtype uint16 is integer range 0 to 2**16-1;

    subtype int8 is integer range -2**7 to 2**7-1;
    subtype int9 is integer range -2**8 to 2**8-1;
    subtype int10 is integer range -2**9 to 2**9-1;
    subtype int11 is integer range -2**10 to 2**10-1;
    subtype int12 is integer range -2**11 to 2**11-1;
    subtype int13 is integer range -2**12 to 2**12-1;
    subtype int14 is integer range -2**13 to 2**13-1;
    subtype int15 is integer range -2**14 to 2**14-1;
    subtype int16 is integer range -2**15 to 2**15-1;

    type integer_array is array (integer range <> ) of integer;

    type uint8_array is array (integer range <> ) of uint8;
    type uint9_array is array (integer range <> ) of uint9;
    type uint10_array is array (integer range <> ) of uint10;
    type uint11_array is array (integer range <> ) of uint11;
    type uint12_array is array (integer range <> ) of uint12;
    type uint13_array is array (integer range <> ) of uint13;
    type uint14_array is array (integer range <> ) of uint14;
    type uint15_array is array (integer range <> ) of uint15;
    type uint16_array is array (integer range <> ) of uint16;

    type int8_array is array (integer range <> ) of int8;
    type int9_array is array (integer range <> ) of int9;
    type int10_array is array (integer range <> ) of int10;
    type int11_array is array (integer range <> ) of int11;
    type int12_array is array (integer range <> ) of int12;
    type int13_array is array (integer range <> ) of int13;
    type int14_array is array (integer range <> ) of int14;
    type int15_array is array (integer range <> ) of int15;
    type int16_array is array (integer range <> ) of int16;

end package typedefines_pkg;
