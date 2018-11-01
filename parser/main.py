from parser.assembler.assembler import assemble
from parser.io.file import to_mif

print('Check your ROM.mif file')
assembly = """
addi $t0, $zero, 0  # a = 0
addi $t1, $zero, 30 # b = 30

addi $t0, $t0, 2    # a += 2
addi $t1, $t1, 1    # b += 1
slt $s0, $t1, $t0   # temp = b < a
beq $s0, $zero, -4  # if(temp = 0) => if(b >= a)
"""


lines = assembly.splitlines()
lines = [l.split("#")[0].strip() for l in lines]
lines = list(filter(lambda line : line, lines))
instructions = [assemble(line)["decimal"] for line in lines]
print(instructions)
to_mif(instructions)
