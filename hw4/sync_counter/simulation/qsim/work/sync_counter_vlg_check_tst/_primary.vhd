library verilog;
use verilog.vl_types.all;
entity sync_counter_vlg_check_tst is
    port(
        q_vec           : in     vl_logic_vector(0 to 3);
        sampler_rx      : in     vl_logic
    );
end sync_counter_vlg_check_tst;
