library ieee;
use ieee.std_logic_1164.all;

-- entity ALU_Control is
entity ALU_Control is
	port (
		op: out std_logic_vector(2 downto 0);
		ALU_op : in std_logic_vector(1 downto 0);
		funct : in std_logic_vector(5 downto 0)
	);
end entity;

architecture beh of ALU_Control is

begin
	-- http://people.sabanciuniv.edu/erkays/el310/mips32.pdf
	op <= "010" when ALU_op = "00" or (funct = "100000" and ALU_op = "10") else
			"110" when ALU_op = "01" or (funct = "100010" and ALU_op = "10") else
			"000" when (funct = "100100" and ALU_op = "10") else
			"001" when (funct = "100101" and ALU_op = "10") else
			"111";
end architecture;