from parser.data.instructions import instructions
from parser.data.registers import registers_dict


def assemble(assembly_line):
    token_delimiter = ' '


    tokens = [r.strip(',') for r in assembly_line.split(token_delimiter)]
    mnemonic = tokens[0]
    instruction = instructions[mnemonic]

    def invert_bits(bin_num): # bin_num is str
        return bin_num.replace('0', 'X').replace('1', '0').replace('X', '1')

    def twos_complement(num, padding):
        abs_num = to_bin(abs(num), padding)
        inv_num = invert_bits(abs_num)
        return int(inv_num, 2) + 1


    def to_bin(num, padding):
        if isinstance(num, str):
            num = int(num)
        if num < 0:
            return to_bin(twos_complement(num, padding), padding)
        else:
            return bin(num)[2:].zfill(padding)    

    def lookup_registers(raw_registers):
        registers = [registers_dict[r] for r in raw_registers]
        bin_registers = [to_bin(r, 5) for r in registers]
        return bin_registers

    if mnemonic == 'noop':
        instr_parts = [to_bin(0, 32)]
    elif instruction["type"] == 'R':
        raw_registers = tokens[1:]
        bin_registers = lookup_registers(raw_registers) # rd, rs, rt
        bin_registers.append(bin_registers.pop(0)) # rd, rs, rt => rs, rt, rd
        shift_amount = '00000' # TODO: not always '00000'
        #                              opcode	           rs, rt, rd      shift (shamt)	funct
        instr_parts = [instruction["opcode"], ' '.join(bin_registers), shift_amount, instruction["funct"]]
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
        instr_parts = [instruction["opcode"], ' '.join(bin_registers), bin_immediate]
    elif instruction["type"] == 'J':
        address = tokens[1]
        bin_address = to_bin(address, 26)
        #                              opcode	  address
        instr_parts = [instruction["opcode"], bin_address]
    else:
        raise TypeError("Unknown instruction type")
    formatted = ' '.join(instr_parts)
    instruction["formatted"] = formatted
    instruction["binary"] = formatted.replace(' ','')
    instruction["decimal"] = int(instruction["binary"], 2)
    return instruction
