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
		clk: in std_logic;
		sel_reg1, sel_reg2: in std_logic_vector(integer(ceil(log2(real(N_REG))))-1 downto 0);
		reg1, reg2: out std_logic_vector(DATA_WIDTH-1 downto 0);
		reg_t0, reg_t1: out std_logic_vector(DATA_WIDTH-1 downto 0);
		wr_data: in std_logic_vector(DATA_WIDTH-1 downto 0);
		wr_reg: in std_logic_vector(integer(ceil(log2(real(N_REG))))-1 downto 0);
		wr_en: in std_logic
	);
end entity;

architecture beh of registers is
	type RegistersState is array(N_REG-1 downto 0) of std_logic_vector(DATA_WIDTH-1 downto 0);
	signal nextState, currentState : RegistersState;
begin
	-- next state logic (combinatorial)
	nextState(0) <= (others => '0');
	NSL: for i in 1 to N_REG-1 generate
		nextState(i) <= wr_data when (wr_en='1' and i=to_integer(unsigned(wr_reg))) else
							 currentState(i);
	end generate NSL;

	-- memory element (sequential)
	ME: process (clk) is
	begin
		if rising_edge(clk) then
			currentState <= nextState;
		end if;
	end process;
	
	-- output logic
	reg1 <= currentState(to_integer(unsigned(sel_reg1))) when to_integer(unsigned(sel_reg1))>0 else
			  (others => '0');
	reg2 <= currentState(to_integer(unsigned(sel_reg2))) when to_integer(unsigned(sel_reg2))>0 else
			  (others => '0');

	reg_t0 <= currentState(8);
	reg_t1 <= currentState(9); 
end architecture;
