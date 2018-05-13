library verilog;
use verilog.vl_types.all;
entity sync_counter is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        clk             : in     vl_logic;
        q_vec           : out    vl_logic_vector(0 to 3)
    );
end sync_counter;
