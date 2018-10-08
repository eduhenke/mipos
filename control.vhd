library ieee;
use ieee.std_logic_1164.all;

entity control is
	port (
		opcode: in std_logic_vector(5 downto 0);
		reg_dst, reg_write, branch,
		mem_read, mem_to_reg, mem_write,
		alu_src : out std_logic;
		alu_op : out std_logic_vector(1 downto 0)
	);
end entity;

architecture beh of control is
begin
	-- http://fourier.eng.hmc.edu/e85_old/lectures/processor/node5.html
	reg_write 	<= '1' when (opcode="000000" and opcode="001000" and opcode="100011") else '0';
	reg_dst 		<= '1' when opcode="000000" else '0';
	branch 		<= '1' when opcode="000100" else '0';
	mem_read 	<= '1' when opcode="100011" else '0';
	mem_to_reg 	<= '1' when opcode="100011" else '0';
	mem_write 	<= '1' when opcode="101011" else '0';
	alu_src 		<= '1' when (opcode="001000" and opcode="100011" and opcode="101011") else '0';
	alu_op		<= "10" when opcode="000000" else
						"01" when opcode="000100" else
						"00";
end architecture;