library verilog;
use verilog.vl_types.all;
entity absolute_difference is
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
        final_diff      : out    vl_logic_vector(7 downto 0)
    );
end absolute_difference;
