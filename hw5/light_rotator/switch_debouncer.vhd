-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------------------------------
entity switch_debouncer is
	generic (t_debounce: integer := 1000000);
	PORT (x: in std_logic;
			y: buffer std_logic;
			clk: in std_logic);
END ENTITY;
-------------------------------------------------------------------------
architecture switch_debouncer of switch_debouncer is
begin
	process(clk)
		variable t: integer range 0 to t_debounce;
		begin
			if rising_edge(clk) then
				if t = t_debounce then
					y <= x;
				end if;
				if x /= y then
					t := t + 1;
				else
					t := 0;
				end if;
			end if;
		end process;
end architecture;
-------------------------------------------------------------------------
