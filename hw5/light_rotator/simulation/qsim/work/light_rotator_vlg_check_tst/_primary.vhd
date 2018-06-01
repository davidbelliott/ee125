library verilog;
use verilog.vl_types.all;
entity light_rotator_vlg_check_tst is
    port(
        ssd             : in     vl_logic_vector(6 downto 0);
        sampler_rx      : in     vl_logic
    );
end light_rotator_vlg_check_tst;
