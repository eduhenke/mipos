library ieee;
use ieee.std_logic_1164.all;

entity control is
	port (
		opcode: in std_logic_vector(5 downto 0);
		reg_dst, reg_write, branch,
		mem_read, mem_to_reg, mem_write,
		alu_op, alu_src : out std_logic
	);
end entity;

architecture beh of control is
begin
	reg_write 	<= '1' when opcode = "000000";
	reg_dst 		<= '1' when opcode = "000000";
	branch 		<= '0' when opcode = "000000";
	mem_read 	<= '0' when opcode = "000000";
	mem_to_reg 	<= '0' when opcode = "000000";
	mem_write 	<= '0' when opcode = "000000";
	alu_op 		<= '1' when opcode = "000000";
	alu_src 		<= '0' when opcode = "000000";
end architecture;