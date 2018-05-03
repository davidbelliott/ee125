-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------------------------------
entity debouncer_demo is
	generic (t_debounce: integer := 5);
	PORT (x: in std_logic;
			clk: in std_logic;
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
	process(x, y)
	begin
			if rising_edge(x) then
				num_bounced <= num_bounced + 1;
			end if;
			if rising_edge(y) then
				num_debounced <= num_debounced + 1;
			end if;
	end process;
end architecture;
-------------------------------------------------------------------------
