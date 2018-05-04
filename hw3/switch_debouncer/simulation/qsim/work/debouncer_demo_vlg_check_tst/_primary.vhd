library verilog;
use verilog.vl_types.all;
entity debouncer_demo_vlg_check_tst is
    port(
        ssd_bounced_pins: in     vl_logic_vector(6 downto 0);
        ssd_debounced_pins: in     vl_logic_vector(6 downto 0);
        sampler_rx      : in     vl_logic
    );
end debouncer_demo_vlg_check_tst;
