--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.user_types.all;
--------------------------------------------------------------------------------
entity absolute_difference is
	--integer(ceil(log2(SIZE+1)))
	generic (
		EXTRABITS: natural := 0;
		SIZE: natural := 6;
		BITS: natural := 5);
	port (
		a, b: in slv_array(0 to SIZE - 1)(BITS - 1 downto 0);
		abs_diff: out std_logic_vector(BITS + EXTRABITS - 1 downto 0));
end entity;
--------------------------------------------------------------------------------
architecture generic_chain of absolute_difference is
	type signed_array is array (natural range <>) of signed;
	type signed_array is array (natural range <>) of signed;
	signal abs_diffs: signed_array(0 to SIZE)(BITS + EXTRABITS - 1 downto 0);
	signal sums: signed_array(0 to SIZE);
begin
	-- have a_sig and b_sig that are arrays of signed numbers
	-- loop through all SIZE elements and find difference from abs(signed(element) - signed(element))
	-- sum all differences and store in abs_diff using `std_logic(signed_sum)` signed_sum is the result from above
	-- actually might not need the a_sig and b_sig if doing it all element-wise

	-- puts absolute differences into a signed array
	sums(0) <= abs(signed(resize(a(0), BITS + EXTRABITS)) - signed(resize(b(0), BITS + EXTRABITS)));
	gen: for i in 1 to SIZE - 1 generate
		abs_diffs(i) <= abs(signed(resize(a(i), BITS + EXTRABITS)) - signed(resize(b(i), BITS + EXTRABITS)));
		sums(i) <= sums(i-1) + abs_diffs(i);
	end generate;



end architecture;
