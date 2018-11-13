instructions = {
    'add': {
        'funct': '100000',
        'meaning': 'Add',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'addi': {
        'funct': 'NA',
        'meaning': 'Add Immediate',
        'opcode': '001000',
        'type': 'I',
        'branch': False
    },
    'addiu': {
        'funct': 'NA',
            'meaning': 'Add Unsigned Immediate',
            'opcode': '001001',
            'type': 'I',
            'branch': False
        },
    'addu': {
        'funct': '100001',
        'meaning': 'Add Unsigned',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'and': {
        'funct': '100100',
        'meaning': 'Bitwise AND',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'andi': {
        'funct': 'NA',
        'meaning': 'Bitwise AND Immediate',
        'opcode': '001100',
        'type': 'I',
        'branch': False
    },
    'beq': {
        'funct': 'NA',
        'meaning': 'Branch if Equal',
        'opcode': '000100',
        'type': 'I',
        'branch': True
    },
    'blez': {
        'funct': 'NA',
        'meaning': 'Branch if Less Than or Equal to Zero',
        'opcode': '000110',
        'type': 'I',
        'branch': True
    },
    'bne': {
        'funct': 'NA',
        'meaning': 'Branch if Not Equal',
        'opcode': '000101',
        'type': 'I',
        'branch': True
    },
    'div': {
        'funct': '011010',
        'meaning': 'Divide',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'divu': {
        'funct': '011011',
        'meaning': 'Unsigned Divide',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'j': {
        'funct': 'NA',
        'meaning': 'Jump to Address',
        'opcode': '000010',
        'type': 'J',
        'branch': False
    },
    'jal': {
        'funct': 'NA',
        'meaning': 'Jump and Link',
        'opcode': '000011',
        'type': 'J',
        'branch': False
    },
    'jr': {
        'funct': '001000',
        'meaning': 'Jump to Address in Register',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'lbu': {
        'funct': 'NA',
        'meaning': 'Load Byte Unsigned',
        'opcode': '100100',
        'type': 'I',
        'branch': False
    },
    'lhu': {
        'funct': 'NA',
        'meaning': 'Load Halfword Unsigned',
        'opcode': '100101',
        'type': 'I',
        'branch': False
    },
    'lui': {
        'funct': 'NA',
        'meaning': 'Load Upper Immediate',
        'opcode': '001111',
        'type': 'I',
        'branch': False
    },
    'lw': {
        'funct': 'NA',
        'meaning': 'Load Word',
        'opcode': '100011',
        'type': 'I',
        'branch': False
    },
    'mfc0': {
        'funct': 'NA',
        'meaning': 'Move from Coprocessor 0',
        'opcode': '010000',
        'type': 'R',
        'branch': False
    },
    'mfhi': {
        'funct': '010000',
        'meaning': 'Move from HI Register',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'mflo': {
        'funct': '010010',
        'meaning': 'Move from LO Register',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'mult': {
        'funct': '011000',
        'meaning': 'Multiply',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'multu': {
        'funct': '011001',
            'meaning': 'Unsigned Multiply',
            'opcode': '000000',
            'type': 'R',
            'branch': False
        },
    'nor': {
        'funct': '100111',
        'meaning': 'Bitwise NOR (NOT-OR)',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'noop': {
        'funct': '000000',
        'meaning': 'No operation',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'or': {
        'funct': '100101',
        'meaning': 'Bitwise OR',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'ori': {
        'funct': 'NA',
        'meaning': 'Bitwise OR Immediate',
        'opcode': '001101',
        'type': 'I',
        'branch': False
    },
    'sb': {
        'funct': 'NA',
        'meaning': 'Store Byte',
        'opcode': '101000',
        'type': 'I',
        'branch': False
    },
    'sh': {
        'funct': 'NA',
        'meaning': 'Store Halfword',
        'opcode': '101001',
        'type': 'I',
        'branch': False
    },
    'sll': {
        'funct': '000000',
        'meaning': 'Logical Shift Left',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'slt': {
        'funct': '101010',
        'meaning': 'Set to 1 if Less Than',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'slti': {
        'funct': 'NA',
        'meaning': 'Set to 1 if Less Than Immediate',
        'opcode': '001010',
        'type': 'I',
        'branch': False
    },
    'sltiu': {
        'funct': 'NA',
            'meaning': 'Set to 1 if Less Than Unsigned Immediate',
            'opcode': '001011',
            'type': 'I',
            'branch': False
        },
    'sltu': {
        'funct': '101011',
        'meaning': 'Set to 1 if Less Than Unsigned',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'sra': {
        'funct': '000011',
        'meaning': 'Arithmetic Shift Right (sign-extended)',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'srl': {
        'funct': '000010',
        'meaning': 'Logical Shift Right (0-extended)',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'sub': {
        'funct': '100010',
        'meaning': 'Subtract',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'subu': {
        'funct': '100011',
        'meaning': 'Unsigned Subtract',
        'opcode': '000000',
        'type': 'R',
        'branch': False
    },
    'sw': {
        'funct': 'NA',
        'meaning': 'Store Word',
        'opcode': '101011',
        'type': 'I',
        'branch': False
    },
    'xor': {
        'funct': '100110',
        'meaning': 'Bitwise XOR (Exclusive-OR)',
        'opcode': '000000',
        'branch': False
    }
}