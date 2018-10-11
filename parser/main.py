from parser.assembler.assembler import assemble
from parser.io.file import to_mif

print('Check your ROM.mif file')
assembly = """
noop
addi $t0, $zero, 1
addi $t1, $zero, 2
add $t0, $t1, $t2
noop
add $t2, $t1, $t0
j 2
"""


lines = assembly.splitlines()[1:]
instructions = [assemble(line)["decimal"] for line in lines]
print(instructions)
to_mif(instructions)
