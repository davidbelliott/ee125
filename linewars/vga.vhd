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
		Vd: INTEGER := 525; --Vpulse+VBP+Vactive+VFP
		GAME_PIXEL_W: INTEGER := 8;
		GAME_PIXEL_H: INTEGER := 8);
	PORT (
		clk: IN STD_LOGIC; --50MHz in our board
		Hsync, Vsync: BUFFER STD_LOGIC;
		R, G, B: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END vga;
----------------------------------------------------------
ARCHITECTURE vga OF vga IS
	SIGNAL Hactive, Vactive, dena: STD_LOGIC;
	SIGNAL pixel_clk: STD_LOGIC;
	shared variable display_buffer: memory_t;
BEGIN
	PROCESS (clk)
	variable slow_clk: std_logic := '1';
	variable count: integer range 0 to 50e6 - 1 := 0;
	BEGIN
		if rising_edge(clk) then
			count := count + 1;
			if count = 50e6 - 1 then
				count := 0;
				if display_buffer(3)(3) = '0' then
					display_buffer(3)(3) := '1';
				else
					display_buffer(3)(3) := '0';
				end if;
			end if;
  		end if;
--		FOR i in 0 to (BOARD_H - 1) / 2 LOOP
--			FOR j in 0 to (BOARD_W - 1) / 2 LOOP
--				display_buffer(i*2)(j*2) := '1';
--			END LOOP;
--		END LOOP;
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
			IF (display_buffer(row / GAME_PIXEL_H)(col / GAME_PIXEL_W) = '1') THEN
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
