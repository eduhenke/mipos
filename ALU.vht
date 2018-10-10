library ieee;
use ieee.std_logic_1164.all;

entity ALU_tst is
end ALU_tst;

architecture beh of ALU_tst is
	signal a: std_logic_vector(31 downto 0) := (others => '0');
	signal b: std_logic_vector(31 downto 0) := (others => '0');
	signal c: std_logic_vector(31 downto 0) := (others => '0');
	signal zero: std_logic := '0';
	signal op: std_logic_vector(2 downto 0) := (others => '0');
	--  Declaration of the component that will be instantiated.
	component ALU is
	port (
		a, b: in std_logic_vector(31 downto 0);
		c: out std_logic_vector(31 downto 0);
		zero: out std_logic;
		op: in std_logic_vector(2 downto 0)
	);
	end component;
begin
	ALU_BLK : ALU port map (a, b, c, zero, op);

    --  This process does the real job.
    process
		type pattern_type is record
			--  The inputs of the RegFile.
			a, b, c: std_logic_vector(31 downto 0);
			zero: std_logic;
			--  The expected outputs of the RegFile.
			op: std_logic_vector (2 downto 0);
		end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
        constant patterns : pattern_array := (
			--   a 				b				 c				 zero op
				(x"00000000", x"00000000", x"00000000", '1', "000"),
			-- add test
				(x"000000F0", x"00000010", x"00000100", '0', "010"),
				(x"00000001", x"00000000", x"00000001", '0', "010"),
				(x"00000000", x"00000000", x"00000000", '1', "010"),
				(x"FFFFFFFF", x"00000001", x"00000000", '1', "010"),
				
			-- sub test
				(x"000000F0", x"00000010", x"000000E0", '0', "110"),
				(x"00000001", x"00000000", x"00000001", '0', "110"),
				(x"00000000", x"00000000", x"00000000", '1', "110"),
				(x"00000001", x"00000003", x"FFFFFFFE", '0', "110")
		);
	begin
		--  Check each pattern.
		for x in patterns'range loop
			--  Set the inputs.
			a <= patterns(x).a;
			b <= patterns(x).b;
			op <= patterns(x).op;
			--  Wait for the results.
			wait for 1 ns;
			assert c = patterns(x).c report "c is not equal to test vector" severity error;
			assert zero = patterns(x).zero report "zero is not equal to test vector" severity error;

		end loop;
		std.env.stop;
	end process;
end beh;
