library verilog;
use verilog.vl_types.all;
entity leading_ones is
    port(
        x               : in     vl_logic_vector(7 downto 0);
        ssd             : out    vl_logic_vector(6 downto 0);
        y               : out    vl_logic_vector(31 downto 0)
    );
end leading_ones;
