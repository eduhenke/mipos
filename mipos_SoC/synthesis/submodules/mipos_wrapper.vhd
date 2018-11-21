library ieee;                                               
use ieee.std_logic_1164.all;                                

entity mipos_wrapper is
	port (
		clk, rst : in std_logic;
		address: in std_logic_vector(1 downto 0);
		readdata: out std_logic_vector(31 downto 0)
	);
end mipos_wrapper;

architecture mipos_arch of mipos_wrapper is
-- signals
signal mips_clk : std_logic;                               
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
	
	process(clk, rst)
	begin
		if rst='1' then
			mips_clk <= '0';
		elsif rising_edge(clk) then
			mips_clk <= not mips_clk;
		end if;
	end process;
	
	readdata <= PC when address="00" else
					reg_t0 when address="01" else
					reg_t1 when address="10" else
					(others => '0');
end mipos_arch;
