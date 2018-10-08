library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
USE ieee.numeric_std.all;



entity registers is
	generic (
		DATA_WIDTH: natural := 32;
		N_REG: natural := 32
	);
	port (
		sel_reg1, sel_reg2: in std_logic_vector(integer(ceil(log2(real(N_REG))))-1 downto 0);
		reg1, reg2: out std_logic_vector(DATA_WIDTH-1 downto 0);
		wr_data: in std_logic_vector(DATA_WIDTH-1 downto 0);
		wr_reg: in std_logic_vector(integer(ceil(log2(real(N_REG))))-1 downto 0);
		wr_en: in std_logic
	);
end entity;

architecture beh of registers is
	type REGISTERS is array(N_REG-1 downto 0) of std_logic_vector(DATA_WIDTH-1 downto 0);
	signal regs : REGISTERS;
begin
	reg1 <= regs(to_integer(unsigned(sel_reg1)));
	reg2 <= regs(to_integer(unsigned(sel_reg2)));
	process(wr_en, wr_reg, wr_data)
	begin
		if wr_en='1' then
			regs(to_integer(unsigned(wr_reg))) <= wr_data;
		end if;
	end process;
end architecture;
