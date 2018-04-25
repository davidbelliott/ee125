library verilog;
use verilog.vl_types.all;
entity leading_ones_vlg_sample_tst is
    port(
        x               : in     vl_logic_vector(7 downto 0);
        sampler_tx      : out    vl_logic
    );
end leading_ones_vlg_sample_tst;
