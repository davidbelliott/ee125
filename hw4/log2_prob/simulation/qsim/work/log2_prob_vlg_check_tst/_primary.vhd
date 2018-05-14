library verilog;
use verilog.vl_types.all;
entity log2_prob_vlg_check_tst is
    port(
        y               : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end log2_prob_vlg_check_tst;
