library ieee;                                               
use ieee.std_logic_1164.all;    

entity mipos_SoC_wrapper is
	port (
		CLOCK_50: in std_logic;
		SW : in std_logic_vector(16 downto 0);
		LEDR: out std_logic_vector(17 downto 0)
	);
end mipos_SoC_wrapper;                            

architecture mipos_arch of mipos_SoC_wrapper is
component mipos_SoC is
	  port (
			clk_clk         : in std_logic := 'X'; -- clk
			reset_reset_n   : in std_logic := 'X'; -- reset_n
			clk_mips_export : in std_logic := 'X'  -- export
	  );
 end component mipos_SoC;
 begin
  u0 : component mipos_SoC
	  port map (
			clk_clk         => CLOCK_50,         --      clk.clk
			reset_reset_n   => SW(1),   --    reset.reset_n
			clk_mips_export => SW(0)  -- clk_mips.export
	  );

end mipos_arch;


