from parser.data.instructions import instructions
from parser.data.registers import registers_dict


def assemble(assembly_line):
    token_delimiter = ' '


    tokens = [r.strip(',') for r in assembly_line.split(token_delimiter)]
    mnemonic = tokens[0]
    instruction = instructions[mnemonic]

    def to_bin(num, padding):
        if isinstance(num, str):
            num = int(num)
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
        if mnemonic in ['lw', 'sw']:
            rt = tokens[1]
            imm_and_rs = tokens[2]
            immediate, rs = imm_and_rs.strip(')').split('(')
            raw_registers = [rs, rt]
        else:
            raw_registers = tokens[1:3][::-1]
            immediate = tokens[3]
        bin_registers = lookup_registers(raw_registers)
        bin_immediate = to_bin(immediate, 16)
        #                              opcode	           rs, rt          immediate
        bin_instruction = instruction["opcode"] + ''.join(bin_registers) + bin_immediate
    else:
        raise TypeError("J-type instruction are not supported yet")
    return bin_instruction
