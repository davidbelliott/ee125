
library ieee;
use ieee.std_logic_1164.all;
entity guess_the_circuit is
port (
clk: in std_logic;
y: out std_logic);
end entity;
architecture code2 of guess_the_circuit is
signal i: integer range 0 to 7;
begin
process (clk)
begin
if rising_edge(clk) then

if i /= 5 then
i <= i + 1;
else
i <= 0;
end if;

if i=0 then
y <= '0';
else
y <= '1';
end if;

end if;
end process;
end architecture;