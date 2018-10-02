library ieee;                                               
use ieee.std_logic_1164.all;                                

entity mipos_vhd_tst is
end mipos_vhd_tst;

architecture mipos_arch of mipos_vhd_tst is
-- constants
constant T : time := 10 ns;
-- signals                                                   
signal clk : std_logic := '0';
signal rst : std_logic;
component mipos
	port (
	clk : in std_logic;
	rst : in std_logic
	);
end component;
begin
	clk <= not clk after T/2;
	rst <= '0';
	
	i1 : mipos port map(
		clk => clk,
		rst => rst
	);
  
end mipos_arch;
