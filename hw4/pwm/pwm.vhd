-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------------------------
entity pwm is
	generic (BITS_DUTY: integer := 3);
	PORT (duty: in std_logic_vector(BITS_DUTY-1 downto 0);
			pwm_clk: in std_logic;
			pwm: out std_logic;
			count_vec: out std_logic_vector(BITS_DUTY-1 downto 0));
END ENTITY;
-------------------------------------------------------------------------
architecture pwm of pwm is
	signal duty_int: integer range 0 to 2**BITS_DUTY - 1;
begin
	duty_int <= to_integer(unsigned(duty));
	process(pwm_clk)
		constant COUNT_MAX: integer := 2**BITS_DUTY - 2;
		variable count: integer range 0 to COUNT_MAX := COUNT_MAX;
		begin
			if rising_edge(pwm_clk) then
				if count = COUNT_MAX then
					count := 0;
				else
					count := count + 1;
				end if;
				if count = 0 then
					pwm <= '1';
				end if;
				if count = duty_int then
					pwm <= '0';
				end if;
			end if;
			count_vec <= std_logic_vector(to_unsigned(count, BITS_DUTY));
		end process;
end architecture;
-------------------------------------------------------------------------