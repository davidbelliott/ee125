library verilog;
use verilog.vl_types.all;
entity absolute_difference_vlg_sample_tst is
    port(
        a0              : in     vl_logic_vector(4 downto 0);
        a1              : in     vl_logic_vector(4 downto 0);
        a2              : in     vl_logic_vector(4 downto 0);
        a3              : in     vl_logic_vector(4 downto 0);
        a4              : in     vl_logic_vector(4 downto 0);
        a5              : in     vl_logic_vector(4 downto 0);
        b0              : in     vl_logic_vector(4 downto 0);
        b1              : in     vl_logic_vector(4 downto 0);
        b2              : in     vl_logic_vector(4 downto 0);
        b3              : in     vl_logic_vector(4 downto 0);
        b4              : in     vl_logic_vector(4 downto 0);
        b5              : in     vl_logic_vector(4 downto 0);
        sampler_tx      : out    vl_logic
    );
end absolute_difference_vlg_sample_tst;
