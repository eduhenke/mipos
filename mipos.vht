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
signal PC_out, reg_t0, reg_t1: std_logic_vector(31 downto 0);

component mipos
	port (
	clk, clk_mem : in std_logic;
	rst : in std_logic;
	PC_out, reg_t0, reg_t1: out std_logic_vector(31 downto 0)
	);
end component;
begin
	-- clock generation
	clk <= not clk after T/2;
	clk_mem <= not clk_mem after T/4;
	
	reset: process
	begin
		wait for T/8;
		rst <= '0';
	end process;
	
	mipos_component : mipos port map(
		clk => clk,
		clk_mem => clk_mem,
		rst => rst,
		PC_out => PC_out,
		reg_t0 => reg_t0,
		reg_t1 => reg_t1
	);
  
end mipos_arch;
