library ieee;                                               
use ieee.std_logic_1164.all;                                

entity mipos_wrapper_tst is
end mipos_wrapper_tst;

architecture mipos_arch of mipos_wrapper_tst is
-- constants
constant T : time := 5 ns;
-- signals
signal clk : std_logic := '0';
signal rst : std_logic := '1';
signal PC, reg_t0, reg_t1: std_logic_vector(31 downto 0);

component mipos_wrapper is
	port (
		clk, rst : in std_logic;
		address: in std_logic_vector(1 downto 0);
		readdata: out std_logic_vector(31 downto 0)
	);
end component;
begin
	-- clock generation
	clk <= not clk after T/2;
	
	reset: process
	begin
		wait for 2*T;
		rst <= '0';
	end process;
	
	wrapper_for_PC : mipos_wrapper port map(
		clk => clk,
		rst => rst,
		address => "00",
		readdata => PC
	);
  
	wrapper_for_t0 : mipos_wrapper port map(
		clk => clk,
		rst => rst,
		address => "01",
		readdata => reg_t0
	);
	
	wrapper_for_t1 : mipos_wrapper port map(
		clk => clk,
		rst => rst,
		address => "10",
		readdata => reg_t1
	);

end mipos_arch;
