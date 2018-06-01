LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------
ENTITY linewars IS
	GENERIC (
		BOARD_W: INTEGER := 80;
		BOARD_H: INTEGER := 60;
	PORT (
		clk: IN STD_LOGIC; --50MHz in our board
		p1lswitch, p1rswitch, p2lswitch, p2rswitch: IN STD_LOGIC;
		Hsync, Vsync: BUFFER STD_LOGIC;
		R, G, B: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END linewars;
type t_buffer is array (0 to BOARD_H - 1) of std_logic_vector(0 to BOARD_W - 1);
----------------------------------------------------------
ARCHITECTURE linewars OF linewars IS
	SIGNAL display_buffer: t_buffer;
BEGIN
	vga: entity work.vga(vga) port map(clk, Hsync, Vsync,	R, G, B, display_buffer);
	--game: entity work.game(game) port map(clk, p1lswitch, p1rswitch, p2lswitch, p2rswitch, display_buffer);
END linewars;
----------------------------------------------------------
