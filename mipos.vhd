------------------------------------------------------
-- This is the mipos script that is run when simulating
-- in modelsim.
------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mipos is
	port(
		clk, clk_mem, rst: in std_logic;
		PC_out, reg_t0, reg_t1: out std_logic_vector(31 downto 0)
	);
end mipos;

architecture beh of mipos is
	signal curr_address: std_logic_vector(31 downto 0); -- Address of the instruction to run
	signal next_address: std_logic_vector(31 downto 0); -- Next address to be loaded into PC
	signal PC_added: std_logic_vector(31 downto 0); -- PC = PC + 4
	signal beq_address: std_logic_vector(31 downto 0); -- beq $t0, $t1, 0x300
	signal jump_address: std_logic_vector(31 downto 0); -- j 0x300
	signal instruction: std_logic_vector(31 downto 0); -- Next address to be loaded into PC
	-- Control signals
	signal reg_dst, reg_write, jump, branch,
		mem_read, mem_to_reg, mem_write,
		ALU_src : std_logic;
	signal ALU_op : std_logic_vector(1 downto 0);
	signal reg1, reg2: std_logic_vector(31 downto 0);
	signal wr_data: std_logic_vector(31 downto 0); -- for data memory
	signal wr_reg_data: std_logic_vector(31 downto 0);
	signal wr_reg: std_logic_vector(4 downto 0);
	signal op: std_logic_vector(2 downto 0);
	signal ALU_result: std_logic_vector(31 downto 0);
	signal ALU_b_in: std_logic_vector(31 downto 0);
	signal data_mem_out: std_logic_vector(31 downto 0);
	signal opcode: std_logic_vector(5 downto 0); -- immediate for I-type instructions
	signal rs: std_logic_vector(4 downto 0); -- immediate for I-type instructions
	signal rt: std_logic_vector(4 downto 0); -- immediate for I-type instructions
	signal immediate: std_logic_vector(15 downto 0); -- immediate for I-type instructions
	signal immediate_ext: std_logic_vector(31 downto 0); -- immediate converted to 32-bits(sign extended)
	signal immediate_ext_shifted: std_logic_vector(31 downto 0); -- immediate converted to 32-bits(sign extended and shifted by 2-bits)
	signal zero: std_logic;



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
	
	component ROM
		port (
			address		: in std_logic_vector (9 downto 0); 
			clock		: in std_logic  := '1';
			q		: out std_logic_vector (31 downto 0)
		);
	end component;
	
	component RAM
		port (
			address	: in std_logic_vector (9 downto 0);
			clock	: in std_logic ;
			data	: in std_logic_vector (31 downto 0);
			wren	: in std_logic ;
			q	: out std_logic_vector (31 downto 0)
		);
	end component;

	component control is
		port (
			opcode: in std_logic_vector(5 downto 0);
			reg_dst, reg_write, jump, branch,
			mem_read, mem_to_reg, mem_write,
			ALU_src : out std_logic;
			ALU_op : out std_logic_vector(1 downto 0)
	);
	end component;
	
	component ALU_Control is
		port (
			op: out std_logic_vector(2 downto 0);
			ALU_op : in std_logic_vector(1 downto 0);
			funct : in std_logic_vector(5 downto 0)
		);
	end component;

	component ALU is
		port (
			a, b: in std_logic_vector(31 downto 0);
			c: out std_logic_vector(31 downto 0);
			zero: out std_logic;
			op: in std_logic_vector(2 downto 0)
		);
	end component;

	
	component registers is
		port (
			clk: in std_logic;
			sel_reg1, sel_reg2: in std_logic_vector(4 downto 0);
			reg1, reg2: out std_logic_vector(31 downto 0);
			reg_t0, reg_t1: out std_logic_vector(31 downto 0);
			wr_data: in std_logic_vector(31 downto 0);
			wr_reg: in std_logic_vector(4 downto 0);
			wr_en: in std_logic
		);
	end component;

begin
	-- output signals
	PC_out <= curr_address;
	
	
	opcode <= instruction(31 downto 26);
	rs <= instruction(25 downto 21);
	rt <= instruction(20 downto 16);
	immediate <= instruction(15 downto 0);
	
	immediate_ext_shifted <= immediate_ext(29 downto 0) & "00";
	jump_address <= PC_added(31 downto 28) & instruction(25 downto 0) & "00";
	next_address <= jump_address when jump='1' else
						 beq_address when (branch='1' and zero='1') else
						 PC_added;
	PROG_CTR: PC port map (
		clk, rst, next_address, curr_address
	); 

	PC_ADDER: adder port map (
		a => curr_address,
		b => "00000000000000000000000000000100",
		c => PC_added
	);
	
	BEQ_ADDER: adder port map (
		a => PC_added,
		b => immediate_ext_shifted,
		c => beq_address
	);


	INSTR_MEM : ROM port map (
		-- the last two bits of the address are discarded so that the
		-- +4 increment turns into a +1 increment to use the entire ROM
		address	 => curr_address(11 downto 2),
		clock	 => clk_mem,
		q	 => instruction
	);
	
	wr_data <= reg2;
	DATA_MEM : RAM port map (
			address => ALU_result(9 downto 0),
			clock => clk_mem,
			data => wr_data,
			wren => mem_write,
			q => data_mem_out
	);

	CONTROL_BLK : control port map (
		opcode => instruction(31 downto 26),
		reg_dst => reg_dst,
		reg_write => reg_write,
		jump => jump,
		branch => branch,
		mem_read => mem_read,
		mem_to_reg => mem_to_reg,
		mem_write => mem_write,
		ALU_op => ALU_op,
		ALU_src => ALU_src
	);
	
	-- sign-extend
	immediate_ext <= std_logic_vector(resize(signed(immediate), immediate_ext'length)); -- X"0000" & immediate;
	ALU_b_in <= reg2 when ALU_src='0' else
					immediate_ext;
					
	ALU_BLK : ALU port map (
		a => reg1,
		b => ALU_b_in,
		c => ALU_result,
		zero => zero,
		op => op
	);
	
	ALU_CONTROL_BLK : ALU_Control port map (
		op => op,
		ALU_op => ALU_op,
		funct => instruction(5 downto 0)
	);


	wr_reg <= instruction(20 downto 16) when reg_dst='0' else
				 instruction(15 downto 11);
	wr_reg_data <= ALU_result when mem_to_reg='0' else
				  data_mem_out;
				 
	REG_BLK : registers port map (
		clk => clk,
		sel_reg1 => instruction(25 downto 21),
		sel_reg2 => instruction(20 downto 16),
		reg1 => reg1,
		reg2 => reg2,
		reg_t0 => reg_t0,
		reg_t1 => reg_t1,
		wr_data =>  wr_reg_data,
		wr_reg => wr_reg,
		wr_en => reg_write
	);
	


end beh;
