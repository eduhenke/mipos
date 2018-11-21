library ieee;                                               
use ieee.std_logic_1164.all;                                

entity mipos_wrapper_DE2 is
	port (
		SW : in std_logic_vector(16 downto 0);
		LEDR: out std_logic_vector(17 downto 0)
	);
end mipos_wrapper_DE2;

architecture mipos_arch of mipos_wrapper_DE2 is
-- signals
signal mips_clk, rst, clk : std_logic;                               
signal PC, reg_t0, reg_t1: std_logic_vector(31 downto 0);

component mipos
	port (
		clk, clk_mem : in std_logic;
		rst : in std_logic;
		PC_out, reg_t0, reg_t1: out std_logic_vector(31 downto 0)
	);
end component;
begin
	mipos_component : mipos port map(
		clk => mips_clk,
		clk_mem => clk,
		rst => rst,
		PC_out => PC,
		reg_t0 => reg_t0,
		reg_t1 => reg_t1
	);
	rst <= SW(1);
	clk <= SW(0);
	
	process(clk, rst)
	begin
		if rst='1' then
			mips_clk <= '0';
		elsif rising_edge(clk) then
			mips_clk <= not mips_clk;
		end if;
	end process;
	
	LEDR(2 downto 0) <= PC(4 downto 2);
	LEDR(6 downto 4) <= reg_t0(2 downto 0);
	LEDR(17 downto 15) <= reg_t1(2 downto 0);
	
end mipos_arch;
