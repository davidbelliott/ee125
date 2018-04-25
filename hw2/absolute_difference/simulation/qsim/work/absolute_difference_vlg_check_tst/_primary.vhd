library verilog;
use verilog.vl_types.all;
entity absolute_difference_vlg_check_tst is
    port(
        final_diff      : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end absolute_difference_vlg_check_tst;
