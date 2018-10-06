library ieee;                                               
use ieee.std_logic_1164.all;                                

entity mipos_tst is
end mipos_tst;

architecture mipos_arch of mipos_tst is
-- constants
constant T : time := 10 ns;
-- signals                                                   
signal clk : std_logic := '0';                               
signal clk_mem : std_logic := '0';
signal rst : std_logic := '1';
component mipos
	port (
	clk, clk_mem : in std_logic;
	rst : in std_logic
	);
end component;
begin
	-- clock generation
	clk <= not clk after T/2;
	clk_mem <= not clk_mem after T/4;
	
	reset: process
	begin
		wait for T;
		rst <= '0';
	end process;
	
	
	
	mipos_component : mipos port map(
		clk => clk,
		clk_mem => clk_mem,
		rst => rst
	);
  
end mipos_arch;
