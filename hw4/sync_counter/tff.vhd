-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------------------------------
entity tff is
	port (a, b, clk: in std_logic;
			q, x: out std_logic);
end entity;
-------------------------------------------------------------------------
architecture tff of tff is
begin
	process(clk)
	x := a and b
	begin
		if rising_edge(clk) then
			q <= (a and b) xor q
		end if
	end process;
end architecture;