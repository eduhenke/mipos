from parser.assembler.assembler import assemble
from parser.io.file import to_mif

print('Check your ROM.mif file')
assembly = """
addi $t0, $zero, 1
addi $t1, $zero, 2
addi $t3, $zero, 9
noop
add $t0, $t1, $t2
add $t2, $t1, $t0
beq $t2, $t3, 2
j 3
addi $t0, $zero, 0
noop
"""


lines = assembly.splitlines()[1:]
instructions = [assemble(line)["decimal"] for line in lines]
print(instructions)
to_mif(instructions)
