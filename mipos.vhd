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
		clk, rst: in std_logic
	);
end mipos;

architecture beh of mipos is
	signal curr_address: std_logic_vector(31 downto 0); -- Address of the instruction to run
	signal next_address: std_logic_vector(31 downto 0); -- Next address to be loaded into PC
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
	
begin
	Prog: PC port map (clk, rst, next_address, curr_address); 

	ADD1: adder port map (
		a => curr_address,
		b => "00000000000000000000000000000100",
		c => next_address
	);


end beh;
