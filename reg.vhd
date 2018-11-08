library ieee;
use ieee.std_logic_1164.all;

entity reg is
	port (
		clk, rst: in std_logic;
		new_value: in std_logic_vector(31 downto 0);
		curr_value: out std_logic_vector(31 downto 0)
	);
end entity;

architecture beh of reg is
begin
	process(clk, rst) is
	begin
		if rst='1' then
			curr_value <= (others => '0');
		elsif rising_edge(clk) then
			curr_value <= new_value;
		end if;
	end process;
end architecture;