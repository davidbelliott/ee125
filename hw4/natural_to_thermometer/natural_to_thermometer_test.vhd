-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.natural_to_thermometer.all;
-------------------------------------------------------------------------
entity natural_to_thermometer_test is
	generic(IN_BITS: integer := 7);
	PORT (num: in std_logic_vector(IN_BITS-1 downto 0);
			thermometer: out std_logic_vector(2**IN_BITS - 1 downto 0));
END ENTITY;
-------------------------------------------------------------------------
architecture test of natural_to_thermometer_test is
begin
	thermometer <= natural_to_thermometer(to_integer(unsigned(num)));
end architecture;
-------------------------------------------------------------------------
