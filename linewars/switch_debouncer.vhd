-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------------------------------
entity switch_debouncer is
	PORT (x: in std_logic;
			y: out std_logic;
			clk: in std_logic);
END ENTITY;
-------------------------------------------------------------------------
architecture switch_debouncer of switch_debouncer is
begin
	y <= x;
--	process(clk)
--		variable btn_down: std_logic;
--		begin
--			if rising_edge(clk) then
--				if x = '0' then
--					if btn_down = '0' then
--						y <= '1';
--						btn_down := '1';
--					else
--						y <= '0';
--					end if;
--				else
--					btn_down := '0';
--					y <= '0';
--				end if;
--			end if;
--		end process;
end architecture;
-------------------------------------------------------------------------
