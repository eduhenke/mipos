library ieee;
use ieee.std_logic_1164.all;

entity registers_tst is
end registers_tst;

architecture beh of registers_tst is
	signal sel_reg1, sel_reg2: std_logic_vector(4 downto 0);
	signal reg1, reg2: std_logic_vector(31 downto 0);
	signal reg_t0, reg_t1: out std_logic_vector(DATA_WIDTH-1 downto 0);
	signal wr_data: std_logic_vector(31 downto 0);
	signal wr_reg: std_logic_vector(4 downto 0);
	signal wr_en: std_logic;
	--  Declaration of the component that will be instantiated.
	component registers is
	port (
		sel_reg1, sel_reg2: in std_logic_vector(4 downto 0);
		reg1, reg2: out std_logic_vector(31 downto 0);
		reg_t0, reg_t1: out std_logic_vector(31 downto 0);
		wr_data: in std_logic_vector(31 downto 0);
		wr_reg: in std_logic_vector(4 downto 0);
		wr_en: in std_logic
	);
	end component;
begin
	REG_BLK : registers port map (
		sel_reg1 => sel_reg1,
		sel_reg2 => sel_reg2,
		reg1 => reg1,
		reg2 => reg2,
		reg_t0 => reg_t0,
		reg_t1 => reg_t1,
		wr_data => wr_data,
		wr_reg => wr_reg,
		wr_en => wr_en
	);

    --  This process does the real job.
    process
		type pattern_type is record
			--  The inputs of the RegFile.
			sel_reg1, sel_reg2, wr_reg: std_logic_vector(4 downto 0); 
			wr_en: std_logic;
			--  The expected outputs of the RegFile.
			wr_data, reg1, reg2 : std_logic_vector (31 downto 0);
		end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
        constant patterns : pattern_array := (
			--  sel_reg1 sel_reg2 wr_reg  wr_en   wr_data      reg1          reg2
				("00000", "00000", "00000", '0', x"00000000", x"00000000", x"00000000"),
			-- register 1 test
				("00000", "00000", "00001", '1', x"00000001", x"00000000", x"00000000"),
				("00001", "00001", "00000", '0', x"00000000", x"00000001", x"00000001"),
			-- register 7 test
				("00000", "00000", "00111", '1', x"00000007", x"00000000", x"00000000"),
				("00111", "00111", "00000", '0', x"00000000", x"00000007", x"00000007"),
			-- register 31 test
				("00000", "00000", "11111", '1', x"00000031", x"00000000", x"00000000"),
				("11111", "11111", "00000", '0', x"00000000", x"00000031", x"00000031"),
				("00000", "00000", "00000", '0', x"00000000", x"00000000", x"00000000"),
			-- register 1/7 test
				("00001", "00111", "00000", '0', x"00000000", x"00000001", x"00000007"),
			-- register 1 write and read test
				("00001", "00000", "00001", '1', x"00000002", x"00000002", x"00000000"),
				("00001", "00000", "00001", '0', x"00000000", x"00000002", x"00000000")
		);
	begin
		--  Check each pattern.
		for x in patterns'range loop
			--  Set the inputs.
			sel_reg1 <= patterns(x).sel_reg1;
			sel_reg2 <= patterns(x).sel_reg2;
			wr_reg <= patterns(x).wr_reg;
			wr_en <= patterns(x).wr_en;
			wr_data <= patterns(x).wr_data;
			--  Wait for the results.
			wait for 1 ns;
			assert reg1 = patterns(x).reg1 report "reg1 is not equal to test vector" severity error;
			assert reg2 = patterns(x).reg2 report "reg2 is not equal to test vector" severity error;
		end loop;
		std.env.stop;
	end process;
end beh;
