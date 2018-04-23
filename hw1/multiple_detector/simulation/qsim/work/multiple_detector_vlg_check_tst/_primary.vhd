library verilog;
use verilog.vl_types.all;
entity multiple_detector_vlg_check_tst is
    port(
        invalid_inp     : in     vl_logic;
        is_multiple     : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end multiple_detector_vlg_check_tst;
