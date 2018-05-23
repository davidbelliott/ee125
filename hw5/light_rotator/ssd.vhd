-------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------------------------------------------
ENTITY ssd IS
	PORT (num: in integer;
			ssd: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END ENTITY;
-------------------------------------------------------------------------
ARCHITECTURE ssd OF ssd IS
BEGIN
	with num select
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
