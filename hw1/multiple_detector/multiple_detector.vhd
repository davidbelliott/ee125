--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------------------------------
entity multiple_detector is
	generic (
		NUM_BITS: positive := 5);
	port (
		a,b: in std_logic_vector(NUM_BITS-1 downto 0);
		is_multiple: out boolean;
		invalid_inp: out boolean);
end entity;
--------------------------------------------------------------------------------
architecture multiple_detector of multiple_detector is
	-- internal unsigned operands
	signal a_unsig, b_unsig: unsigned(NUM_BITS-1 downto 0);
begin
	a_unsig <= unsigned(a);
	b_unsig <= unsigned(b);
	
	is_multiple <= (a_unsig mod b_unsig = 0) and (b_unsig /= 0);
	invalid_inp <= b_unsig = 0;
	
end architecture;