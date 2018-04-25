-------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use IEEE.math_real.all;
-------------------------------------------------------------------------
ENTITY leading_ones IS
	GENERIC (N: INTEGER :=8 );	--number of input bits
	PORT (x: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			ssd: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
			y: buffer integer);
END ENTITY;
-------------------------------------------------------------------------
ARCHITECTURE leading_ones OF leading_ones IS
	--signed representations of inputs and outputs
	type int_vector is array(N-1 downto 0) of integer;
	signal first_ones: std_logic_vector(N-1 downto 0);
	signal ones_count: int_vector;
BEGIN
	first_ones(N-1)<= x(N-1);
	ones_count(N-1)<=1 when x(N-1)='1' else 0;
	gen: for i in N-2 downto 0 generate
		first_ones(i)<=first_ones(i+1) and x(i);
		ones_count(i)<=ones_count(i+1) + 1 when(first_ones(i)='1') else ones_count(i+1);
	end generate;
	y<=ones_count(0);
	with y select
		ssd <= "0000001" when 0,
				 "1001111" when 1,
				 "0010010" when 2,
			    "0000110" when 3,
			    "1001100" when 4,
		       "0100100" when 5,
		       "0100000" when 6,
		       "0001111" when 7,
		       "0000000" when 8,
		       "0000100" when 9,
	          "0110000" when others;
END ARCHITECTURE;
-------------------------------------------------------------------------