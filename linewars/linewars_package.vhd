LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------
PACKAGE linewars_package IS
	constant BOARD_W: INTEGER := 2;
	constant BOARD_H: INTEGER := 2;
	type t_buffer is array (0 to BOARD_H - 1) of std_logic_vector(0 to BOARD_W - 1);
END PACKAGE;