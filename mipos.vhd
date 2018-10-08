------------------------------------------------------
-- This is the mipos script that is run when simulating
-- in modelsim.
------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mipos is
	port(
		clk, clk_mem, rst: in std_logic
	);
end mipos;

architecture beh of mipos is
	signal curr_address: std_logic_vector(31 downto 0); -- Address of the instruction to run
	signal next_address: std_logic_vector(31 downto 0); -- Next address to be loaded into PC
	signal instruction: std_logic_vector(31 downto 0); -- Next address to be loaded into PC
	-- Control signals
	signal reg_dst, reg_write, branch,
		mem_read, mem_to_reg, mem_write,
		alu_src : std_logic;
	signal alu_op : std_logic_vector(1 downto 0);
	signal reg1, reg2: std_logic_vector(31 downto 0);
	signal wr_data: std_logic_vector(31 downto 0);
	signal wr_reg: std_logic_vector(4 downto 0);
	signal wr_en: std_logic;



	component PC
		port (
			clk, rst: in std_logic;
			next_address: in std_logic_vector(31 downto 0);
			curr_address: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component adder 
		generic (N: natural := 32);
		port (
			a,b: in std_logic_vector(31 downto 0);
			c: out std_logic_vector(31 downto 0)
		);		
	end component;
	
	component memory
		port (
			address		: in std_logic_vector (9 DOWNTO 0); 
			clock		: in std_logic  := '1';
			q		: out std_logic_vector (31 DOWNTO 0)
		);
	end component;

	component control is
		port (
			opcode: in std_logic_vector(5 downto 0);
			reg_dst, reg_write, branch,
			mem_read, mem_to_reg, mem_write,
			alu_src : out std_logic;
			alu_op : out std_logic_vector(1 downto 0)
	);
	end component;

	component registers is
		port (
			sel_reg1, sel_reg2: in std_logic_vector(4 downto 0);
			reg1, reg2: out std_logic_vector(31 downto 0);
			wr_data: in std_logic_vector(31 downto 0);
			wr_reg: in std_logic_vector(4 downto 0);
			wr_en: in std_logic
		);
	end component;

begin
	PROG_CTR: PC port map (
		clk, rst, next_address, curr_address
	); 

	PC_ADDER: adder
		port map (
		a => curr_address,
		b => "00000000000000000000000000000100",
		c => next_address
	);

	ROM : memory port map (
		-- the last two bits of the address are discarded so that the
		-- +4 increment turns into a +1 increment to use the entire memory
		address	 => curr_address(11 downto 2),
		clock	 => clk_mem,
		q	 => instruction
	);

	CONTROL_BLK : control port map (
		opcode => instruction(31 downto 26),
		reg_dst => reg_dst,
		reg_write => reg_write,
		branch => branch,
		mem_read => mem_read,
		mem_to_reg => mem_to_reg,
		mem_write => mem_write,
		alu_op => alu_op,
		alu_src => alu_src
	);


	wr_reg <= instruction(20 downto 16) when reg_dst='1' else
				 instruction(15 downto 11);
	REG_BLK : registers port map (
		sel_reg1 => instruction(25 downto 21),
		sel_reg2 => instruction(20 downto 16),
		reg1 => reg1,
		reg2 => reg2,
		wr_data => wr_data,
		wr_reg => wr_reg,
		wr_en => reg_write
	);
	


end beh;
