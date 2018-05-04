-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------------------------
entity leading_ones_sequential is
	generic (N: integer := 8 );	--number of input bits
	port (x:   in std_logic_vector(N-1 downto 0);
			clk: in std_logic;
			ssd: out std_logic_vector(6 downto 0);
			cnt: buffer integer);
end entity;
-------------------------------------------------------------------------
architecture leading_ones_sequential of leading_ones_sequential is
begin
	process(x,clk)
		variable count: integer := 0;
		begin
			if rising_edge(clk) then
				count := 0;
				for i in N-1 downto 0 loop
					if (x(i) = '1') then
						count := count + 1;
					else
						exit;	
					end if;
				end loop;
				
				cnt <= count;
				
				--encode into ssd bits
				
				case count is
					when 0 => ssd <= "0000001";
					when 1 => ssd <= "1001111";
					when 2 => ssd <= "0010010";
					when 3 => ssd <= "0000110";
					when 4 => ssd <= "1001100";
					when 5 => ssd <= "0100100";
					when 6 => ssd <= "0100000";
					when 7 => ssd <= "0000001";
					when 8 => ssd <= "0000000";
					when 9 => ssd <= "0000100";
					when others => ssd <= "0110000";
				end case;
			end if;
	end process;
end architecture;
-------------------------------------------------------------------------
