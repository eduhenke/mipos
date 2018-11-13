from parser.assembler.assembler import assemble
from parser.assembler.cleaner import uncomment, translate_labels
from parser.io.file import to_mif

print('Check your ROM.mif file')
assembly = """
start:  addi $t0, $zero, 0  # a = 0
        addi $t1, $zero, 30 # b = 30

                                # do {
loop:   addi $t0, $t0, 2        #   a += 2
        addi $t1, $t1, 1        #   b += 1
        slt $s0, $t1, $t0       #   temp = b < a
        beq $s0, $zero, loop    # } while(temp = 0) => while(b >= a)
end:
"""


lines = list(uncomment(assembly.splitlines()))
lines = list(translate_labels(lines))
print(lines)
instructions = [assemble(line)["decimal"] for line in lines]
print(instructions)
to_mif(instructions)
