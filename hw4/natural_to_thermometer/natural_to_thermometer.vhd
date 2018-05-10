-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------------------------
PACKAGE natural_to_thermometer is
	constant IN_BITS: integer := 7;
	function natural_to_thermometer(signal num: natural) return std_logic_vector;
END natural_to_thermometer;
-------------------------------------------------------------------------
package body natural_to_thermometer is
	function natural_to_thermometer(signal num: natural) return std_logic_vector is
		constant OUT_BITS: integer := 2**IN_BITS;
		variable thermometer: std_logic_vector(OUT_BITS - 1 downto 0);
	begin
		for i in 0 to OUT_BITS - 1 loop
			if i < num then
				thermometer(i) := '1';
			else
				thermometer(i) := '0';
			end if;
		end loop;
		return thermometer;
	end function;
end package body;
-------------------------------------------------------------------------
