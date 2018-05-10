-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-------------------------------------------------------------------------
entity log2_prob is
	generic (BITS: natural := 8);
	port (a: in std_logic_vector(BITS downto 0);
			b: out std_logic_vector(BITS downto 0));
end entity;
-------------------------------------------------------------------------
architecture problem_one of log2_prob is
	function ceil_log2 (input: integer) return integer is
	begin
		return integer((ceil(log2(real(input)))));
	end function ceil_log2;
	
	signal a_int: integer;
begin
	a_int <= to_integer(unsigned(a));
	b <= std_logic_vector(to_unsigned(ceil_log2(a_int),BITS));
end architecture;
-------------------------------------------------------------------------
