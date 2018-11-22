library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU is
	generic (N: natural := 32);
	port (
		a, b: in std_logic_vector(N-1 downto 0);
		c: out std_logic_vector(N-1 downto 0);
		zero: out std_logic;
		op: in std_logic_vector(2 downto 0)
	);
end entity;

architecture beh of ALU is
	signal result: std_logic_vector(N-1 downto 0) := (others => '0'); -- problem in synthesis? it's just for testbenches
begin
	zero <= '1' when unsigned(result)=0 else
			  '0';
	c <= a + b when op="010" else
		  a - b when op="110" else
		  (0=>'1', others=>'0') when (op="111" and a < b) else
		  a or b when op="001" else
		  a and b;
end architecture;