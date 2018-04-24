--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.user_types.all;
--------------------------------------------------------------------------------
entity absolute_difference is
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
	signal a_sig, b_sig: signed_array(0 to SIZE - 1)(BITS + EXTRABITS - 1 downto 0);
	signal abs_diff_sig: std_logic_vector(BITS + EXTRABITS - 1 downto 0);
begin
	-- have a_sig and b_sig that are arrays of signed numbers
	-- loop through all SIZE elements and find difference from abs(signed(element) - signed(element))
	-- sum all differences and store in abs_diff using `std_logic(signed_sum)` signed_sum is the result from above
	-- actually might not need the a_sig and b_sig if doing it all element-wise
end architecture;