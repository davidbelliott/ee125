LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.linewars_package.all;
----------------------------------------------------------
ENTITY vga IS
	GENERIC (
		Ha: INTEGER := 96; --Hpulse
		Hb: INTEGER := 144; --Hpulse+HBP
		Hc: INTEGER := 784; --Hpulse+HBP+Hactive
		Hd: INTEGER := 800; --Hpulse+HBP+Hactive+HFP
		Va: INTEGER := 2; --Vpulse
		Vb: INTEGER := 35; --Vpulse+VBP
		Vc: INTEGER := 515; --Vpulse+VBP+Vactive
		Vd: INTEGER := 525); --Vpulse+VBP+Vactive+VFP
	PORT (
		clk: IN STD_LOGIC; --50MHz in our board
		rst: IN STD_LOGIC;
		Hsync, Vsync: BUFFER STD_LOGIC;
		R, G, B: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		p1lswitch: IN std_logic);
END vga;
----------------------------------------------------------
ARCHITECTURE vga OF vga IS
	SIGNAL Hactive, Vactive, dena: STD_LOGIC;
	SIGNAL pixel_clk: STD_LOGIC;
	signal game_clk: std_logic;
	signal display_buffer: memory_t := (others => (others => '0'));
	shared VARIABLE p1d: direction_t := 'D';
BEGIN

	
	PROCESS(p1lswitch)
	BEGIN
		if rst = '0' then
			p1d := 'D';
		elsif falling_edge(p1lswitch) then
			if(p1d = 'U') then
				p1d := 'L';
			elsif(p1d = 'D') then
				p1d := 'R';
			elsif(p1d = 'L') then
				p1d := 'D';
			elsif(p1d = 'R') then
				p1d := 'U';
			end if;
		end if;
	END PROCESS;
	
	PROCESS(clk)
	constant COUNTDOWN_MAX: integer := (CLOCK_FREQ / GAME_FREQ) / 2;
	VARIABLE countdown: integer range 0 to COUNTDOWN_MAX := COUNTDOWN_MAX;
	BEGIN
		countdown := countdown - 1;
		if countdown = 0 then
			countdown := COUNTDOWN_MAX;
			game_clk <= not game_clk;
		end if;
	END PROCESS;
	
	PROCESS(game_clk)
	VARIABLE p1x: integer range 0 to BOARD_W - 1 := 3;
	VARIABLE p1y: integer range 0 to BOARD_H - 1 := 3;
	BEGIN
		if rst = '0' then
			p1x := 3;
			p1y := 3;
			--display_buffer <= (others => (others => '0'));
		elsif(rising_edge(game_clk)) then
			if(p1d = 'U') then
				p1y := p1y - 1;
			elsif(p1d = 'D') then
				p1y := p1y + 1;
			elsif(p1d = 'L') then
				p1x := p1x - 1;
			elsif(p1d = 'R') then
				p1x := p1x + 1;
			end if;
			display_buffer(p1y)(p1x) <= '1';
		end if;
	END PROCESS;

	-------------------------------------------------------
	--Part 1: CONTROL GENERATOR
	-------------------------------------------------------
	--Create pixel clock (50MHz->25MHz):
	
	PROCESS (clk)
	BEGIN
	IF (clk'EVENT AND clk='1') THEN
		pixel_clk <= NOT pixel_clk;
	END IF;
	END PROCESS;
	--Horizontal signals generation:
	PROCESS (pixel_clk)
		VARIABLE Hcount: INTEGER RANGE 0 TO Hd;
	BEGIN
	IF (pixel_clk'EVENT AND pixel_clk='1') THEN
		Hcount := Hcount + 1;
		IF (Hcount=Ha) THEN
			Hsync <= '1';
		ELSIF (Hcount=Hb) THEN
			Hactive <= '1';
		ELSIF (Hcount=Hc) THEN
			Hactive <= '0';
		ELSIF (Hcount=Hd) THEN
			Hsync <= '0';
			Hcount := 0;
		END IF;
	END IF;

	END PROCESS;
	--Vertical signals generation:
	PROCESS (Hsync)
		VARIABLE Vcount: INTEGER RANGE 0 TO Vd;
	BEGIN
		IF (Hsync'EVENT AND Hsync='0') THEN
			Vcount := Vcount + 1;
		IF (Vcount=Va) THEN
			Vsync <= '1';
		ELSIF (Vcount=Vb) THEN
			Vactive <= '1';
		ELSIF (Vcount=Vc) THEN
			Vactive <= '0';
		ELSIF (Vcount=Vd) THEN
			Vsync <= '0';
			Vcount := 0;
		END IF;
		END IF;
	END PROCESS;
	---Display enable generation:
	dena <= Hactive AND Vactive;
	-------------------------------------------------------
	--Part 2: IMAGE GENERATOR
	-------------------------------------------------------
	PROCESS (Hsync, Vsync, Vactive, dena, pixel_clk)
		VARIABLE row: INTEGER RANGE -1 TO Vc - 1;
		VARIABLE col: INTEGER RANGE 0 TO Hc;
	BEGIN
		-- row updating
		IF (Vsync='0') THEN
			row := -1;
		ELSIF (Hsync'EVENT AND Hsync='1') THEN
			IF (Vactive='1') THEN
				row := row + 1;
			END IF;
		END IF;
		
		-- col updating
		IF (Hsync='0') THEN
			col := 0;
		ELSIF (pixel_clk'EVENT AND pixel_clk='1') THEN
			IF (Hactive='1') THEN
				col := col + 1;
			END IF;
		END IF;
		
		IF (dena='1') THEN
			IF (display_buffer(row / BLOCK_H)(col / BLOCK_W) = '1') THEN
				-- color if game pixel is on
				R <= (OTHERS => '1');
				G <= (OTHERS => '0');
				B <= (OTHERS => '0');
			ELSE
				-- color if game pixel is off
				R <= (OTHERS => '0');
				G <= (OTHERS => '0');
				B <= (OTHERS => '0');
			END IF;
		ELSE
			R <= (OTHERS => '0');
			G <= (OTHERS => '0');
			B <= (OTHERS => '0');
		END IF;
	END PROCESS;
END vga;
----------------------------------------------------------
