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
	SIGNAL addr: natural range 0 to 2**6 - 1;
	SIGNAL data: std_logic_vector((8 - 1) downto 0);
	SIGNAL we: std_logic;
	SIGNAL q: std_logic_vector(7 downto 0);
	
BEGIN
	vga: entity work.vga(vga) port map(clk, Hsync, Vsync,	R, G, B);
	--sdram: entity work.single_port_ram(rtl) port map(clk, addr, data, we, q);
	--game: entity work.game(game) port map(clk, p1lswitch, p1rswitch, p2lswitch, p2rswitch, display_buffer);
END linewars;
----------------------------------------------------------