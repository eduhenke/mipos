import pprint
pp = pprint.PrettyPrinter(indent=4)

# taken from https://en.wikibooks.org/wiki/MIPS_Assembly/Instruction_Formats
raw_instructions = {
    "add": {"meaning": "Add", type: 'R', "opcode": '0x00', "funct": '0x20' },
    "addu": {"meaning": "Add Unsigned", type: 'R', "opcode": '0x00', "funct": '0x21' },
    "and": {"meaning": "Bitwise AND", type: 'R', "opcode": '0x00', "funct": '0x24' },
    "div": {"meaning": "Divide", type: 'R', "opcode": '0x00', "funct": '0x1A' },
    "divu": {"meaning": "Unsigned Divide", type: 'R', "opcode": '0x00', "funct": '0x1B' },
    "jr": {"meaning": "Jump to Address in Register", type: 'R', "opcode": '0x00', "funct": '0x08' },
    "mfhi": {"meaning": "Move from HI Register", type: 'R', "opcode": '0x00', "funct": '0x10' },
    "mflo": {"meaning": "Move from LO Register", type: 'R', "opcode": '0x00', "funct": '0x12' },
    "mfc0": {"meaning": "Move from Coprocessor 0", type: 'R', "opcode": '0x10', "funct": 'NA' },
    "mult": {"meaning": "Multiply", type: 'R', "opcode": '0x00', "funct": '0x18' },
    "multu": {"meaning": "Unsigned Multiply", type: 'R', "opcode": '0x00', "funct": '0x19' },
    "nor": {"meaning": "Bitwise NOR (NOT-OR)", type: 'R', "opcode": '0x00', "funct": '0x27' },
    "xor": {"meaning": "Bitwise XOR (Exclusive-OR)", type: 'R', "opcode": '0x00', "funct": '0x26' },
    "or": {"meaning": "Bitwise OR", type: 'R', "opcode": '0x00', "funct": '0x25' },
    "slt": {"meaning": "Set to 1 if Less Than", type: 'R', "opcode": '0x00', "funct": '0x2A' },
    "sltu": {"meaning": "Set to 1 if Less Than Unsigned", type: 'R', "opcode": '0x00', "funct": '0x2B' },
    "sll": {"meaning": "Logical Shift Left", type: 'R', "opcode": '0x00', "funct": '0x00' },
    "srl": {"meaning": "Logical Shift Right (0-extended)", type: 'R', "opcode": '0x00', "funct": '0x02' },
    "sra": {"meaning": "Arithmetic Shift Right (sign-extended)", type: 'R', "opcode": '0x00', "funct": '0x03' },
    "sub": {"meaning": "Subtract", type: 'R', "opcode": '0x00', "funct": '0x22' },
    "subu": {"meaning": "Unsigned Subtract", type: 'R', "opcode": '0x00', "funct": '0x23' },
    "j": {"meaning": "Jump to Address", type: 'J', "opcode": '0x02', "funct": 'NA' },
    "jal": {"meaning": "Jump and Link", type: 'J', "opcode": '0x03', "funct": 'NA' },
    "addi": {"meaning": "Add Immediate", type: 'I', "opcode": '0x08', "funct": 'NA' },
    "addiu": {"meaning": "Add Unsigned Immediate", type: 'I', "opcode": '0x09', "funct": 'NA' },
    "andi": {"meaning": "Bitwise AND Immediate", type: 'I', "opcode": '0x0C', "funct": 'NA' },
    "beq": {"meaning": "Branch if Equal", type: 'I', "opcode": '0x04', "funct": 'NA' },
    "blez": {"meaning": "Branch if Less Than or Equal to Zero", type: 'I', "opcode": '0x06', "funct": 'NA' },
    "bne": {"meaning": "Branch if Not Equal", type: 'I', "opcode": '0x05', "funct": 'NA' },
    "lbu": {"meaning": "Load Byte Unsigned", type: 'I', "opcode": '0x24', "funct": 'NA' },
    "lhu": {"meaning": "Load Halfword Unsigned", type: 'I', "opcode": '0x25', "funct": 'NA' },
    "lui": {"meaning": "Load Upper Immediate", type: 'I', "opcode": '0x0F', "funct": 'NA' },
    "lw": {"meaning": "Load Word", type: 'I', "opcode": '0x23', "funct": 'NA' },
    "ori": {"meaning": "Bitwise OR Immediate", type: 'I', "opcode": '0x0D', "funct": 'NA' },
    "sb": {"meaning": "Store Byte", type: 'I', "opcode": '0x28', "funct": 'NA' },
    "sh": {"meaning": "Store Halfword", type: 'I', "opcode": '0x29', "funct": 'NA' },
    "slti": {"meaning": "Set to 1 if Less Than Immediate", type: 'I', "opcode": '0x0A', "funct": 'NA' },
    "sltiu": {"meaning": "Set to 1 if Less Than Unsigned Immediate", type: 'I', "opcode": '0x0B', "funct": 'NA' },
    "sw": {"meaning": "Store Word", type: 'I', "opcode": '0x2B', "funct": 'NA' }
}

def update(d, k):
    d[k]["opcode"] = bin(int(d[k]["opcode"], 16))[2:].zfill(6)
    if d[k]["funct"] != "NA":
        d[k]["funct"] = bin(int(d[k]["funct"], 16))[2:].zfill(6)
    return d[k]

parsed_instructions = {k: update(raw_instructions, k) for k in raw_instructions}
pp.pprint(parsed_instructions)

# taken from http://www.cs.uwm.edu/classes/cs315/Bacon/Lecture/HTML/ch05s03.html
registers = [
    "$zero",
    "$at",
    "$v0", "$v1",
    "$a0", "$a1", "$a2", "$a3",
    "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
    "$s0", "$s1", "$s2", "$s3", "$s4", "$s5", "$s6", "$s7",
    "$t8", "$t9",
    "$k0", "$k1",
    "$gp",
    "$sp",
    "$fp",
    "$ra"
] 
registers_dict = {r: i for i, r in enumerate(registers)}
pp.pprint(registers_dict)
