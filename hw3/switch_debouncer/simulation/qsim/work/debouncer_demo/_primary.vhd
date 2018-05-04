library verilog;
use verilog.vl_types.all;
entity debouncer_demo is
    port(
        x               : in     vl_logic;
        clk             : in     vl_logic;
        ssd_debounced_pins: out    vl_logic_vector(6 downto 0);
        ssd_bounced_pins: out    vl_logic_vector(6 downto 0)
    );
end debouncer_demo;
