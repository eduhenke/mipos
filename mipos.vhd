------------------------------------------------------
-- This is the mipos script that is run when simulating
-- in modelsim.
------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mipos is
	port(
		clk, clk_mem, rst: in std_logic
	);
end mipos;

architecture beh of mipos is
	signal curr_address: std_logic_vector(31 downto 0); -- Address of the instruction to run
	signal next_address: std_logic_vector(31 downto 0); -- Next address to be loaded into PC
	signal q_sig: std_logic_vector(31 downto 0); -- Next address to be loaded into PC
	component PC
		port (
			clk, rst: in std_logic;
			next_address: in std_logic_vector(31 downto 0);
			curr_address: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component adder 
		port (
			a,b: in std_logic_vector(31 downto 0);
			c: out std_logic_vector(31 downto 0)
		);		
	end component;
	
	component memory
		port (
			address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0); 
			clock		: IN STD_LOGIC  := '1';
			q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
begin
	Prog: PC port map (clk, rst, next_address, curr_address); 

	ADD1: adder port map (
		a => curr_address,
		b => "00000000000000000000000000000100",
		c => next_address
	);

	memory_inst : memory port map (
		-- the last two bits of the address are discarded so that the
		-- +4 increment turns into a +1 increment to use the entire memory
		address	 => curr_address(11 downto 2),
		clock	 => clk_mem,
		q	 => q_sig
	);


end beh;
