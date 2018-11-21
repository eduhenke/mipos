library ieee;
use ieee.std_logic_1164.all;

entity clock_mips_generator is
	port (
		clk_in_avalon: in std_logic;
		clk_out_mips: out std_logic
	);
end clock_mips_generator;

architecture beh of clock_mips_generator is
begin
	clk_out_mips <= clk_in_avalon;
end beh;