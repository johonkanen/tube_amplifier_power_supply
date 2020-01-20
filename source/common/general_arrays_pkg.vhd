library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package common_types is

    subtype int18 is integer range -2**17 to 2**17-1;
    subtype std16 is std_logic_vector(15 downto 0);

    type integer_array is array (integer range <> ) of integer;
    type bool_array is array (integer range <> ) of boolean;
    type std16_vector_array is array (integer range <> ) of std16;

end package common_types;
