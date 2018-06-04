LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.linewars_package.all;
----------------------------------------------------------
ENTITY linewars IS
	--GENERIC ();
	PORT (
		clk: IN STD_LOGIC; --50MHz in our board
		p1lswitch, p1rswitch, p2lswitch, p2rswitch: IN STD_LOGIC;
		Hsync, Vsync: BUFFER STD_LOGIC;
		R, G, B: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END linewars;

----------------------------------------------------------
ARCHITECTURE linewars OF linewars IS
	SIGNAL display_buffer: t_buffer;
BEGIN
	vga: entity work.vga(vga) port map(clk, Hsync, Vsync,	R, G, B, display_buffer);
	--game: entity work.game(game) port map(clk, p1lswitch, p1rswitch, p2lswitch, p2rswitch, display_buffer);
END linewars;
----------------------------------------------------------