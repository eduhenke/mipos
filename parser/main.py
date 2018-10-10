from parser.assembler.assembler import assemble
from parser.shell.prompt import print_instruction

print('Add your SINGLE assembly line(like: \'sub $t0, $t1, $t2\') here:')
assembly = """
addi $t0, $zero, 18
addi $t1, $zero, 12
add $t0, $t1, $t2
sw $t2, 300($zero)
lw $t5, 300($zero)
"""
for line in assembly.splitlines()[1:]:
    instr = assemble(line)
    print_instruction(instr)

# print('----',mnemonic,'----') 
# print("meaning:", instruction["meaning"])
# print("type:", instruction["type"])

