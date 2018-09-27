library ieee;
use ieee.std_logic_1164.all;

entity PC is
	port (
		clk, rst: in std_logic;
		next_address: in std_logic_vector(31 downto 0);
		curr_address: out std_logic_vector(31 downto 0)
	);
end entity;

architecture beh of PC is
begin
	process(clk, rst) is
	begin
		if rst='1' then
			curr_address <= (others => '0');
		elsif rising_edge(clk) then
			curr_address <= next_address;
		end if;
	end process;
end architecture;