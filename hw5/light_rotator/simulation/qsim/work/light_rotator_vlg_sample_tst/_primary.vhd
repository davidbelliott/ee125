library verilog;
use verilog.vl_types.all;
entity light_rotator_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        dir             : in     vl_logic;
        rst             : in     vl_logic;
        spd             : in     vl_logic;
        stp             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end light_rotator_vlg_sample_tst;
