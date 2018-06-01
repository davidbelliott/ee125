-----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
-----------------------------------------------------------
entity light_rotator is
	port (
	stp, clk, rst, dir, spd: in std_logic;
	ssd: out std_logic_vector(6 downto 0));
end entity;
-----------------------------------------------------------
architecture moore_fsm of light_rotator is

--FSM-related declarations:
type state is (A, AB, B, BC, C, CD, D, DE, E, EF, F, FA);
signal pr_state, nx_state: state;

--Timer-related declarations:
type int_array is array (integer range <>) of integer;
constant T1_TABLE: int_array(0 to 5) := (12_500_000, -- 250ms @fclk=50Mhz
													   9_000_000, -- 180ms @fclk=50Mhz
														6_500_000, -- 130ms @fclk=50Mhz
														5_000_000, -- 100ms @fclk=50Mhz
														3_500_000, --  70ms @fclk=50Mhz
														2_000_000); -- 40ms @fclk=50Mhz
signal T1: natural := T1_TABLE(0); --120ms @ fclk=50MHz
constant T2: natural := 1_000_000; --20ms @ fclk=50MHz
constant tmax: natural := T1-1; --tmax ≥ max(T1,T2)-1
signal t: natural range 0 to tmax;
signal debounced: std_logic := '0'; --signal for debounced spd switch press
signal T1_index: integer := 0; --index for table of T1

begin	
	debouncer: entity work.switch_debouncer(switch_debouncer) port map(spd, debounced, clk);
	
	--Timer (using strategy #1):
	process (clk, rst, stp)
		begin
		if rst='0' then
			t <= 0;
		elsif rising_edge(clk) and stp='0' then
			if pr_state /= nx_state then
				t <= 0;
			elsif t /= tmax then
				t <= t + 1;
			end if;
		end if;
	end process;
	
	--Speed controller
	process (debounced, spd, clk)
		begin
		if falling_edge(debounced) then
			T1_index <= T1_index + 1;
			if T1_index = 5 then
				T1_index <= 0;
			end if;
			T1 <=T1_TABLE(T1_index);
		end if;
	end process;
	
	--FSM state register:
	process (clk, rst)
		begin
		if rst='0' then
			pr_state <= A;
		elsif rising_edge(clk) then
			pr_state <= nx_state;
		end if;
	end process;

	--FSM combinational logic:
	process (all)
		begin
		case pr_state is
			when A =>
				ssd <= "0111111";
				if dir = '1' then 
					if t >= T1-1 then -- or t=T1-1
						nx_state <= AB;
					else
						nx_state <= A;
					end if;
				else
					if t >= T1-1 then -- or t=T1-1
						nx_state <= FA;
					else
						nx_state <= A;
					end if;
				end if;
			when AB =>
				ssd <= "0011111";
				if dir = '1' then 
					if t >= T2-1 then -- or t=T2-1
						nx_state <= B;
					else
						nx_state <= AB;
					end if;
				else
					if t >= T2-1 then -- or t=T2-1
						nx_state <= A;
					else
						nx_state <= AB;
					end if;
				end if;
			when B =>
				ssd <= "1011111";
				if dir = '1' then 
					if t >= T1-1 then -- or t=T1-1
						nx_state <= BC;
					else
						nx_state <= B;
					end if;
				else
					if t >= T1-1 then -- or t=T1-1
						nx_state <= AB;
					else
						nx_state <= B;
					end if;
				end if;
			when BC =>
				ssd <= "1001111";
				if dir = '1' then 
					if t >= T2-1 then -- or t=T2-1
						nx_state <= C;
					else
						nx_state <= BC;
					end if;
				else
					if t >= T2-1 then -- or t=T2-1
						nx_state <= B;
					else
						nx_state <= BC;
					end if;
				end if;
			when C =>
				ssd <= "1101111";
				if dir = '1' then 
					if t >= T1-1 then -- or t=T1-1
						nx_state <= CD;
					else
						nx_state <= C;
					end if;
				else
					if t >= T1-1 then -- or t=T1-1
						nx_state <= BC;
					else
						nx_state <= C;
					end if;
				end if;
			when CD =>
				ssd <= "1100111";
				if dir = '1' then 
					if t >= T2-1 then -- or t=T2-1
						nx_state <= D;
					else
						nx_state <= CD;
					end if;
				else
					if t >= T2-1 then -- or t=T2-1
						nx_state <= C;
					else
						nx_state <= CD;
					end if;
				end if;
			when D =>
				ssd <= "1110111";
				if dir = '1' then 
					if t >= T1-1 then -- or t=T1-1
						nx_state <= DE;
					else
						nx_state <= D;
					end if;
				else
					if t >= T1-1 then -- or t=T1-1
						nx_state <= CD;
					else
						nx_state <= D;
					end if;
				end if;
			when DE =>
				ssd <= "1110011";
				if dir = '1' then 
					if t >= T2-1 then -- or t=T2-1
						nx_state <= E;
					else
						nx_state <= DE;
					end if;
				else
					if t >= T2-1 then -- or t=T2-1
						nx_state <= D;
					else
						nx_state <= DE;
					end if;
				end if;
			when E =>
				ssd <= "1111011";
				if dir = '1' then 
					if t >= T1-1 then -- or t=T1-1
						nx_state <= EF;
					else
						nx_state <= E;
					end if;
				else
					if t >= T1-1 then -- or t=T1-1
						nx_state <= DE;
					else
						nx_state <= E;
					end if;
				end if;
			when EF =>
				ssd <= "1111001";
				if dir = '1' then 
					if t >= T2-1 then -- or t=T2-1
						nx_state <= F;
					else
						nx_state <= EF;
					end if;
				else
					if t >= T2-1 then -- or t=T2-1
						nx_state <= E;
					else
						nx_state <= EF;
					end if;
				end if;
			when F =>
				ssd <= "1111101";
				if dir = '1' then 
					if t >= T1-1 then -- or t=T1-1
						nx_state <= FA;
					else
						nx_state <= F;
					end if;
				else
					if t >= T1-1 then -- or t=T1-1
						nx_state <= EF;
					else
						nx_state <= F;
					end if;
				end if;
			when FA =>
				ssd <= "0111101";
				if dir = '1' then 
					if t >= T2-1 then -- or t=T2-1
						nx_state <= A;
					else
						nx_state <= FA;
					end if;
				else
					if t >= T2-1 then -- or t=T2-1
						nx_state <= F;
					else
						nx_state <= FA;
					end if;
				end if;
		end case;
	end process;

end architecture;
-----------------------------------------------------------