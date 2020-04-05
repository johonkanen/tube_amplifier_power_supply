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

end package typedefines_pkg;
