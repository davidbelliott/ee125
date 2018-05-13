-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
----tflipflop:--------------------------------------------------------------
entity tflipflop is
	port (a, b, clk: in std_logic;
			q: buffer std_logic;
			x: out std_logic);
end entity;
-------------------------------------------------------------------------
architecture tflipflop of tflipflop is
begin
	x <= a and b;
	process(clk)
	begin
		if rising_edge(clk) then
			q <= (a and b) xor q;
		end if;
	end process;
end architecture;
----Main code:-----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity sync_counter is
	generic (BITS: natural := 4);
	port (a, b, clk: in std_logic;
			q_vec: out std_logic_vector(0 to BITS - 1));
end entity;
-------------------------------------------------------------------------
architecture sync_counter of sync_counter is
	signal a_vec, b_vec: std_logic_vector(0 to BITS - 1);
	
	component tflipflop is
		port (a, b, clk: in std_logic;
				q: buffer std_logic;
				x: out std_logic);
	end component;
	
begin
	cell0: tflipflop PORT MAP (a, b, clk, b_vec(0), q_vec(0));
	gen: for i in 1 to BITS - 1 generate
		cells: tflipflop PORT MAP (a_vec(i-1), b_vec(i-1), clk, q_vec(i), b_vec(i));
	end generate gen;
	
end architecture;			
			