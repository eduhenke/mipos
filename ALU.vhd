library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU is
	generic (N: natural := 32);
	port (
		a, b: in std_logic_vector(N-1 downto 0);
		c: out std_logic_vector(N-1 downto 0);
		op: in std_logic_vector(2 downto 0)
	);
end entity;

architecture beh of ALU is
begin
	process
	begin
		if op="010" then
			c <= a + b;
		elsif (op="110" or op="111") then
			c <= a - b;
		elsif op="001" then
			c <= a or b;
		else
			c <= a and b;
		end if;
	end process;
end architecture;