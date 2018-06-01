library verilog;
use verilog.vl_types.all;
entity light_rotator is
    port(
        stp             : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        dir             : in     vl_logic;
        spd             : in     vl_logic;
        ssd             : out    vl_logic_vector(6 downto 0)
    );
end light_rotator;
