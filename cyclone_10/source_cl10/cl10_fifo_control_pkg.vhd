library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package cl10_fifo_control_pkg is
--------------------------------------------------
    component uart_fifo IS
	PORT
	(
		clock        : IN STD_LOGIC ;
		data         : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdreq        : IN STD_LOGIC ;
		wrreq        : IN STD_LOGIC ;
		almost_empty : OUT STD_LOGIC ;
		almost_full  : OUT STD_LOGIC ;
		empty        : OUT STD_LOGIC ;
		full         : OUT STD_LOGIC ;
		q            : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		usedw        : OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
	);
    end component;

--------------------------------------------------
    type fifo_input_control_group is record
        data  : STD_LOGIC_VECTOR (15 DOWNTO 0);
        wrreq : STD_LOGIC ;
        rdreq : STD_LOGIC ;
    end record;

    type fifo_output_control_group is record
		almost_empty : STD_LOGIC ;
		almost_full  : STD_LOGIC ;
		empty        : STD_LOGIC ;
		full         : STD_LOGIC ;
		q            : STD_LOGIC_VECTOR (15 DOWNTO 0);
		usedw        : STD_LOGIC_VECTOR (11 DOWNTO 0);
    end record;

------------------------------------------------------------------------
    procedure enable_fifo_read_and_write (
        signal fifo_read_control : out fifo_input_control_group);
------------------------------------------------------------------------
    procedure write_data_to_fifo (
        signal fifo_in : out fifo_input_control_group;
        data_to_fifo   : in integer);
------------------------------------------------------------------------
    procedure load_data_from_fifo (
        signal fifo_in : out fifo_input_control_group);
------------------------------------------------------------------------
    function fifo_is_empty ( fifo_out : fifo_output_control_group)
        return boolean;
------------------------------------------------------------------------
    function fifo_is_full ( fifo_out : fifo_output_control_group)
        return boolean;

------------------------------------------------------------------------
end package cl10_fifo_control_pkg;

    -- signal fifo_output_control : fifo_output_control_group;
    -- signal fifo_control_input : fifo_input_control_group;

    -- uart_fifo_inst : uart_fifo 
    -- PORT MAP (
	-- 	clock        => core_clock,
	-- 	data         => fifo_control_input.data,
	-- 	rdreq        => fifo_control_input.rdreq,
	-- 	wrreq        => fifo_control_input.wrreq,
	-- 	almost_empty => fifo_output_control.almost_empty,
	-- 	almost_full  => fifo_output_control.almost_full,
	-- 	empty        => fifo_output_control.empty,
	-- 	full         => fifo_output_control.full,
	-- 	q            => fifo_output_control.q,
	-- 	usedw        => fifo_output_control.usedw
	-- );

package body cl10_fifo_control_pkg is
------------------------------------------------------------------------
    procedure enable_fifo_read_and_write
    (
        signal fifo_read_control : out fifo_input_control_group
    ) is
    begin
        fifo_read_control.rdreq <= '0';
        fifo_read_control.wrreq <= '0';
    end enable_fifo_read_and_write;

------------------------------------------------------------------------
    procedure write_data_to_fifo
    (
        signal fifo_in : out fifo_input_control_group;
        data_to_fifo   : in integer
    ) is
    begin
        fifo_in.wrreq <= '1';
        fifo_in.data <= std_logic_vector(to_signed(data_to_fifo,16));
    end write_data_to_fifo;

------------------------------------------------------------------------
    procedure load_data_from_fifo
    (
        signal fifo_in : out fifo_input_control_group
    ) is
    begin
        fifo_in.rdreq <= '1';
    end load_data_from_fifo;

------------------------------------------------------------------------
------------------------------------------------------------------------

    function fifo_is_empty
    (
        fifo_out : fifo_output_control_group
    )
    return boolean
    is
    begin
        return fifo_out.empty = '1';
    end fifo_is_empty;
------------------------------------------------------------------------
    function fifo_is_full
    (
        fifo_out : fifo_output_control_group
    )
    return boolean
    is
    begin
        return fifo_out.full = '1';
    end fifo_is_full;

end package body cl10_fifo_control_pkg;

