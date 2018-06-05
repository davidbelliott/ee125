LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------
PACKAGE linewars_package IS

	constant SCREEN_W: INTEGER := 640;
	constant SCREEN_H: INTEGER := 480;
	constant BLOCK_W: INTEGER := 8;
	constant BLOCK_H: INTEGER := BLOCK_W;
	constant BOARD_W: INTEGER := SCREEN_W / BLOCK_W;
	constant BOARD_H: INTEGER := SCREEN_H / BLOCK_H;
	subtype word_t is std_logic_vector(0 to BOARD_W-1);
	type memory_t is array(0 to BOARD_H-1) of word_t;
END PACKAGE;