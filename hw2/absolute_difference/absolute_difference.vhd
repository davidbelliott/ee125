--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.user_types.all;
--------------------------------------------------------------------------------
entity absolute_difference is
	generic (
		SIZE: natural := 6;
		BITS: natural := 5;
		EXTRABITS: natural := 3); --integer(ceil(log2(SIZE+1))));
	port (
		-- a, b: in slv_array(0 to SIZE - 1)(BITS - 1 downto 0);
		-- for simulation:
		a0, a1, a2, a3, a4, a5, b0, b1, b2, b3, b4, b5: in std_logic_vector(BITS - 1 downto 0);
		final_diff: out std_logic_vector(BITS + EXTRABITS - 1 downto 0));
end entity;
--------------------------------------------------------------------------------
architecture generic_chain of absolute_difference is
	type unsigned_array is array (natural range <>) of unsigned;
	-- internal array of differences
	signal abs_diffs: unsigned_array(0 to SIZE - 1)(BITS + EXTRABITS - 1 downto 0);
	-- cumulative sum of differences
	signal sums: unsigned_array(0 to SIZE - 1)(BITS + EXTRABITS - 1 downto 0);
	-- for simulation, input arrays
	signal a : slv_array(0 to SIZE - 1)(BITS - 1 downto 0) := (a0,a1,a2,a3,a4,a5);
	signal b : slv_array(0 to SIZE - 1)(BITS - 1 downto 0) := (b0,b1,b2,b3,b4,b5);
begin
	-- initializing first element of internal arrays
	abs_diffs(0) <= unsigned(abs(resize(signed(a(0)), BITS + EXTRABITS) - 
										  resize(signed(b(0)), BITS + EXTRABITS)));
	sums(0) <= unsigned(abs_diffs(0));
	
	-- calculate each difference and cumulative sum
	gen: for i in 1 to SIZE - 1 generate
		abs_diffs(i) <= unsigned(abs(resize(signed(a(i)), BITS + EXTRABITS) - 
											  resize(signed(b(i)), BITS + EXTRABITS)));
		sums(i) <= sums(i-1) + unsigned(abs_diffs(i));
	end generate;
	
	-- final difference is last element of cumulative sum array
	final_diff <= std_logic_vector(sums(SIZE - 1));
	
end architecture;
