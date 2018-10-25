from parser.assembler.assembler import assemble
from parser.io.file import to_mif

print('Check your ROM.mif file')
assembly = """
addi $s3, $zero, 3  # i = 3
addi $s4, $zero, 4  # j = 4

addi $s1, $zero, 10 # b = 10
addi $s2, $zero, 8  # c = 8

slt $t0, $s3, $s4   # temp = i < j
beq $t0, $zero, 2   # if(temp)
sub $s0, $s1, $s2   # then { a = b - c }
j 9 
add $s0, $s1, $s2   # else { a = b + c }
noop
"""


lines = assembly.splitlines()
lines = [l.split("#")[0].strip() for l in lines]
lines = list(filter(lambda line : line, lines))
instructions = [assemble(line)["decimal"] for line in lines]
print(instructions)
to_mif(instructions)
