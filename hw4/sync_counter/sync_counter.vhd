-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
----tflipflop:--------------------------------------------------------------
entity tflipflop is
	port (a, b, clk: in std_logic;
			x: out std_logic;
			q: buffer std_logic);
end entity;
-------------------------------------------------------------------------
architecture tflipflop of tflipflop is
begin
	process(clk)
	begin
		x <= a and b;
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
			q_vec: buffer std_logic_vector(BITS - 1 downto 0));
end entity;
-------------------------------------------------------------------------
architecture sync_counter of sync_counter is
	signal x_vec: std_logic_vector(BITS - 1 downto 0);
	
	component tflipflop is
		port (a, b, clk: in std_logic;
				x: out std_logic;
				q: buffer std_logic);
	end component;
	
begin
	cell: tflipflop PORT MAP (a, b, clk, x_vec(0), q_vec(0));
	gen: for i in 1 to BITS - 1 generate
		cells: tflipflop PORT MAP (x_vec(i-1), q_vec(i-1), clk, x_vec(i), q_vec(i));
	end generate gen;
	
end architecture;			
			