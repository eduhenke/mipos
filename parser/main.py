from data.instructions import instructions
from data.registers import registers_dict

print('Add your SINGLE assembly line(like: \'sub $t0, $t1, $t2\') here:')
assembly_line = input() 


token_delimiter = ' '


tokens = [r.strip(',') for r in assembly_line.split(token_delimiter)]
mnemonic = tokens[0]
instruction = instructions[mnemonic]

def to_bin(num, padding):
    return bin(num)[2:].zfill(padding)    

def lookup_registers(raw_registers):
    registers = [registers_dict[r] for r in raw_registers]
    bin_registers = [to_bin(r, 5) for r in registers]
    return bin_registers


if instruction["type"] == 'R':
    raw_registers = tokens[1:]
    bin_registers = lookup_registers(raw_registers)
    shift_amount = '00000' # TODO: not always '00000'
    #                              opcode	           rs, rt, rd      shift (shamt)	funct
    bin_instruction = instruction["opcode"] + ''.join(bin_registers) + shift_amount + instruction["funct"]
elif instruction["type"] == 'I':
    raw_registers = tokens[1:2]
    bin_registers = lookup_registers(raw_registers)
    immediate = int(tokens[3])
    bin_immediate = to_bin(immediate, 16)
    #                              opcode	           rs, rt          immediate
    bin_instruction = instruction["opcode"] + ''.join(bin_registers) + bin_immediate

print('----',mnemonic,'----') 
print("meaning:", instruction["meaning"])
print("type:", instruction["type"])

print('-------------')
print('Instruction in Binary:', bin_instruction)
print('Instruction in Decimal:', int(bin_instruction, 2))
