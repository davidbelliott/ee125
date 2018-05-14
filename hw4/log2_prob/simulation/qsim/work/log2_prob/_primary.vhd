library verilog;
use verilog.vl_types.all;
entity log2_prob is
    port(
        x               : in     vl_logic_vector(7 downto 0);
        y               : out    vl_logic_vector(3 downto 0)
    );
end log2_prob;
