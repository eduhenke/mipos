from parser.data.instructions import instructions
from parser.data.registers import registers_dict

print('Add your SINGLE assembly line(like: \'sub $t0, $t1, $t2\') here:')
assembly_line = 'add $t0, $t1, $t2'


token_delimiter = ' '


tokens = [r.strip(',') for r in assembly_line.split(token_delimiter)]
mnemonic = tokens[0]
instruction = instructions[mnemonic]

if instruction["type"] == 'R':
    raw_registers = tokens[1:]
    registers = [registers_dict[r] for r in raw_registers]
    bin_registers = [bin(r)[2:].zfill(5) for r in registers]
    shift_amount = '00000' # TODO: not always '00000'
    #                              opcode	           rs, rt, rd      shift (shamt)	funct
    bin_instruction = instruction["opcode"] + ''.join(bin_registers) + shift_amount + instruction["funct"]
    dec_instruction = int(bin_instruction, 2)

print('----',mnemonic,'----') 
print("meaning:", instruction["meaning"])
print("type:", instruction["type"])

print('-------------')
print('Instruction in Binary:', bin_instruction)
print('Instruction in Decimal:', dec_instruction)