LIBRARY ieee;
USE ieee.std_logic_1164.all;
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
		red_switch, green_switch, blue_switch: IN STD_LOGIC;
		pixel_clk: BUFFER STD_LOGIC;
		Hsync, Vsync: BUFFER STD_LOGIC;
		R, G, B: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		nblanck, nsync : OUT STD_LOGIC);
END vga;
----------------------------------------------------------
ARCHITECTURE vga OF vga IS
	SIGNAL Hactive, Vactive, dena: STD_LOGIC;
BEGIN
	-------------------------------------------------------
	--Part 1: CONTROL GENERATOR
	-------------------------------------------------------
	--Static signals for DACs:
	nblanck <= '1'; --no direct blanking
	nsync <= '0'; --no sync on green
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
	PROCESS (Hsync, Vsync, Vactive, dena, red_switch,
		green_switch, blue_switch,pixel_clk)
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
			IF (row=1) THEN
				R <= (OTHERS => '1');
				G <= (OTHERS => '0');
				B <= (OTHERS => '0');
			ELSIF (row>1 AND row<=100) THEN
				R <= (OTHERS => red_switch);
				G <= (OTHERS => green_switch);
				B <= (OTHERS => blue_switch);
			ELSE 
				R <= (OTHERS => '0');
				G <= (OTHERS => '1');
				B <= (OTHERS => '0');
			END IF;
			
			IF (col=639) THEN
				R <= (OTHERS => '1');
				G <= (OTHERS => '1');
				B <= (OTHERS => '0');
			END IF;
			IF (col=0) THEN
				R <= (OTHERS => '1');
				G <= (OTHERS => '1');
				B <= (OTHERS => '0');
			END IF;
			
			IF (row=0) THEN
				R <= (OTHERS => '1');
				G <= (OTHERS => '1');
				B <= (OTHERS => '0');
			END IF;
			IF (row=479) THEN
				R <= (OTHERS => '1');
				G <= (OTHERS => '1');
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
