-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-------------------------------------------------------------------------
entity log2_prob is
	generic (BITS: natural := 8);
	port (x: in std_logic_vector(BITS - 1  downto 0);
			-- generically:
			-- y: out std_logic_vector(ceil(log2(BITS)) downto 0); not synthesizeable
			-- for simulation:
			y: out std_logic_vector(3 downto 0));
end entity;
-------------------------------------------------------------------------
architecture problem_one of log2_prob is
	function ceil_log2 (input: positive) return integer is
		variable i: integer := 0;
	begin
		while (2 ** i < input and i <= BITS) loop
			i := i + 1;
		end loop;
		return i;
	end function ceil_log2;
	
	signal x_int: integer;
begin
	x_int <= positive(to_integer(unsigned(x)));
	-- generically:
	-- y <= std_logic_vector(to_unsigned(ceil_log2(x_int), ceil_log2(BITS));
	-- for simulation:
	y <= std_logic_vector(to_unsigned(ceil_log2(x_int), 4));
end architecture;
-------------------------------------------------------------------------