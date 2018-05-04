-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------------------------------
entity debouncer_demo is
	generic (t_debounce: integer := 1000000);
	PORT (x: in std_logic;
			clk: in std_logic;
			rst: in std_logic;
			ssd_debounced_pins: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
			ssd_bounced_pins: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END ENTITY;
-------------------------------------------------------------------------
architecture debouncer_demo of debouncer_demo is
	signal y: std_logic;
	signal num_debounced: integer range 0 to integer'high;
	signal num_bounced: integer range 0 to integer'high;
begin
	debouncer: entity work.switch_debouncer(switch_debouncer) port map(x, y, clk);
	ssd_debounced : entity work.ssd(ssd) port map(num_debounced, ssd_debounced_pins);
	ssd_bounced : entity work.ssd(ssd) port map(num_bounced, ssd_bounced_pins);
	process(x, y, rst)
	begin
			if rst = '0' then	
				num_debounced <= 0;
				num_bounced <= 0;
			else
				if falling_edge(x) then
					num_bounced <= num_bounced + 1;
					if num_bounced = 9 then
						num_bounced <= 0;
					end if;
				end if;
				if falling_edge(y) then
					num_debounced <= num_debounced + 1;
					if num_debounced = 9 then
						num_debounced <= 0;
					end if;
				end if;
			end if;
	end process;
end architecture;
-------------------------------------------------------------------------
