library verilog;
use verilog.vl_types.all;
entity leading_ones_vlg_check_tst is
    port(
        ssd             : in     vl_logic_vector(6 downto 0);
        y               : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end leading_ones_vlg_check_tst;
