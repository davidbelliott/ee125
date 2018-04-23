-------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-------------------------------------------------------------------------
ENTITY absolute_difference_calculator IS
	GENERIC (SIZE: INTEGER :=6 );	--number of input bits
	PORT (a, b: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		cin: IN STD_LOGIC;	--carry in bit
		sum: OUT STD_LOGIC_VECTOR(N DOWNTO 0));
END ENTITY;
-------------------------------------------------------------------------
ARCHITECTURE adder OF adder IS
	--signed representations of inputs and outputs
	SIGNAL a_sig, b_sig: SIGNED(N-1 DOWNTO 0);
	SIGNAL sum_sig: SIGNED(N DOWNTO 0);
BEGIN
	--convert std_logic_vector inputs to signed
	a_sig <= signed(a);
	b_sig <= signed(b);
	--sign-extend a_sig and b_sig to N+1 bits and add, with cin
	sum_sig <= (a_sig(N-1) & a_sig) + (b_sig(N-1) & b_sig) + ('0' & cin);
	--convert sum back to a std_logic_vector
	sum <= std_logic_vector(sum_sig);
END ARCHITECTURE;
-------------------------------------------------------------------------