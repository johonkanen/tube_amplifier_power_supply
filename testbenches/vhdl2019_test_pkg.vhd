library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    
package test_interface_pkg is
    type comm_bus_record is record
        data_to_entity              : std_ulogic_vector(15 downto 0);
        write_data_to_entity_with_1 : std_ulogic;

        data_from_entity              : std_ulogic_vector(15 downto 0);
        write_data_from_entity_with_1 : std_ulogic;
    end record comm_bus_record;

    view comm_bus_cview of comm_bus_record is
        data_to_entity              : in;
        write_data_to_entity_with_1 : in;

        data_from_entity              : out;
        write_data_from_entity_with_1 : out;
    end view;
    alias comm_bus_view is comm_bus_cview'converse;

    procedure init_tx (
        signal self : view comm_bus_view);

    procedure write_data (
        signal self : view comm_bus_view;
        data : in std_ulogic_vector);

    procedure write_data (
        signal self : view comm_bus_view;
        data : in integer);

    procedure init_rx (
        signal self : view comm_bus_cview);

    procedure loopback_interface (
        signal self : view comm_bus_cview);

    function bus_feedback_is_ready ( self : comm_bus_record)
        return boolean;


end package test_interface_pkg;


package body test_interface_pkg is
    procedure init_tx
    (
        signal self : view comm_bus_view
    ) is
    begin
        self.data_to_entity <= (others => '0');
        self.write_data_to_entity_with_1 <= '0';
    end init_tx;

    procedure init_rx
    (
        signal self : view comm_bus_cview
    ) is
    begin
        self.data_from_entity <= (others => '0');
        self.write_data_from_entity_with_1 <= '0';
    end init_rx;

    procedure write_data
    (
        signal self : view comm_bus_view;
        data : in std_ulogic_vector
    ) is
    begin
        self.data_to_entity <= data;
        self.write_data_to_entity_with_1 <= '1';
    end write_data;

    procedure write_data
    (
        signal self : view comm_bus_view;
        data : in integer
    ) is
    begin
        self.data_to_entity <= std_ulogic_vector(to_signed(data,self.data_from_entity'length));
        self.write_data_to_entity_with_1 <= '1';
    end write_data;

    procedure loopback_interface
    (
        signal self : view comm_bus_cview
    ) is
    begin
        if self.write_data_to_entity_with_1 = '1' then
            self.data_from_entity <= self.data_to_entity;
            self.write_data_from_entity_with_1 <= '1';
        end if;
        
    end loopback_interface;

    function bus_feedback_is_ready
    (
        self : comm_bus_record
    )
    return boolean
    is
    begin
        return self.write_data_from_entity_with_1 = '1';
    end bus_feedback_is_ready;

end package body test_interface_pkg;
------------------------------------------------
