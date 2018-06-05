LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.linewars_package.all;
----------------------------------------------------------
ENTITY linewars IS
	--GENERIC ();
	PORT (
		clk: IN STD_LOGIC; --50MHz in our board
		rst: IN STD_LOGIC;
		p1lswitch, p1rswitch, p2lswitch, p2rswitch: IN STD_LOGIC;
		Hsync, Vsync: BUFFER STD_LOGIC;
		R, G, B: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END linewars;

----------------------------------------------------------
ARCHITECTURE linewars OF linewars IS
signal p1ldebounced: std_logic;
BEGIN
	vga: entity work.vga(vga) port map(clk, rst, Hsync, Vsync,	R, G, B, p1ldebounced);
	p1l_debouncer: entity work.switch_debouncer(switch_debouncer) port map(p1lswitch, p1ldebounced, clk);
	--game: entity work.game(game) port map(clk, p1lswitch, p1rswitch, p2lswitch, p2rswitch);
END linewars;
----------------------------------------------------------