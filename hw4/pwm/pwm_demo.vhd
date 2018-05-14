-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------------------------------
entity pwm_demo is
	generic (F_CLK: integer:=50;
		T_CLK_PWM: integer:=120;
		BITS_DUTY: integer:=3);
	PORT (clk: in std_logic;
			duty: in std_logic_vector(BITS_DUTY-1 downto 0);
			pwm_out: out std_logic;
			count: out std_logic_vector(BITS_DUTY-1 downto 0));
END ENTITY;
-------------------------------------------------------------------------
architecture pwm_demo of pwm_demo is
	signal pwm_clk: std_logic;
begin
	pwm: entity work.pwm(pwm) generic map(BITS_DUTY)
		port map(duty, pwm_clk, pwm_out, count);
	process(clk)
	
	constant CYCLES_MAX: integer := (T_CLK_PWM * F_CLK) / 2000 - 1;
	variable cycles: integer range 0 to CYCLES_MAX := CYCLES_MAX;
	begin
		if rising_edge(clk) then
			if cycles = CYCLES_MAX then
				cycles := 0;
			else
				cycles := cycles + 1;
			end if;
			if cycles = 0 then
				pwm_clk <= NOT(pwm_clk);
			end if;
		end if;	
	end process;
end architecture;
-------------------------------------------------------------------------
