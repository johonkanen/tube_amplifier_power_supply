library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package ram_control_pkg is

------------------------------------------------------------------------
    component ram_2_port IS
	PORT
	(
		clock     : IN STD_LOGIC;
		data      : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdaddress : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		wraddress : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		wren      : IN STD_LOGIC;
		q         : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
    END component;

------------------------------------------------------------------------
    type ram_2_port_input_group is record
		wren      : STD_LOGIC;
		data      : STD_LOGIC_VECTOR (15 DOWNTO 0);
		wraddress : STD_LOGIC_VECTOR (10 DOWNTO 0);
		rdaddress : STD_LOGIC_VECTOR (10 DOWNTO 0);
    end record;

------------------------------------------------------------------------
    type ram_2_port_output_group is record
		q         : STD_LOGIC_VECTOR (15 DOWNTO 0);
    end record;

------------------------------------------------------------------------
    procedure enable_ram_write_control (
        signal ram : out ram_2_port_input_group);

--------------------------------------------------
    function get_data_from_ram ( ram : ram_2_port_output_group)
        return integer;

--------------------------------------------------
    procedure load_data_from_ram (
        signal ram : out ram_2_port_input_group;
        address : in natural);

--------------------------------------------------
    procedure write_data_to_ram (
        signal ram : out ram_2_port_input_group;
        address : in natural;
        data : in integer);

--------------------------------------------------
end package ram_control_pkg;

    -- signal ram_input : ram_2_port_input_group;
    -- signal ram_output : ram_2_port_output_group;

    -- ram_2_port_inst : ram_2_port PORT MAP (
	-- 	clock     => core_clock,
	-- 	data      => ram_input.data,
	-- 	rdaddress => ram_input.rdaddress,
	-- 	wraddress => ram_input.wraddress,
	-- 	wren      => ram_input.wren,
	-- 	q         => ram_output.q
	-- );

package body ram_control_pkg is

------------------------------------------------------------------------
    procedure enable_ram_write_control
    (
        signal ram : out ram_2_port_input_group
    ) is
    begin
        ram.wren <= '0';
    end enable_ram_write_control;
------------------------------------------------------------------------
    function get_data_from_ram
    (
        ram : ram_2_port_output_group
    )
    return integer
    is
    begin
        return to_integer(signed(ram.q));
    end get_data_from_ram;

------------------------------------------------------------------------
    procedure load_data_from_ram
    (
        signal ram : out ram_2_port_input_group;
        address : in natural
    ) is
    begin
        ram.rdaddress <= std_logic_vector(to_unsigned(address,11));
    end load_data_from_ram;

------------------------------------------------------------------------
    procedure write_data_to_ram
    (
        signal ram : out ram_2_port_input_group;
        address : in natural;
        data : in integer
    ) is
    begin
        ram.wren <= '1';
        ram.wraddress <= std_logic_vector(to_unsigned(address,11));
        ram.data <= std_logic_vector(to_signed(data,16));
    end write_data_to_ram;
end package body ram_control_pkg;

