from cmd import Cmd
from parser.data.instructions import instructions
from parser.data.registers import registers_dict

def print_instruction(instr):
    dec_parts = ' '.join([str(int(n, 2)) for n in instr["formatted"].split(' ')])
    print('-------------')
    print('Instruction Parts:', instr["formatted"])
    print('Instruction Parts(dec):', dec_parts)
    print('Instruction in Decimal:', int(instr["binary"], 2))


class AssemblerPrompt(Cmd):
    def __init__(self):
        super(AssemblerPrompt, self).__init__()
        self.instructions = instructions

    def __getattr__(self, attr):
        if attr.startswith('help_'):
            key = attr[5:]
            return lambda : print(self.instructions[key]["meaning"])
        if attr.startswith('do_'):
            key = attr[3:]
            return lambda x : print(key, x)
        if attr.startswith('complete_'):
            key = attr[9:]
            instruction = self.instructions[key]
            # print(instruction)
            if instruction["type"] != 'R':
                return lambda *args : ["Autocomplete doesn't work for non R-Type instructions"]
            else:
                registers = list(registers_dict.keys())
                # [r for r in registers if r.startswith(args[1])]
                # registers = ['asd', 'dsa']
                return lambda self2, text, caret, *args :(
                    # print('text:"{}" ; caret:"{}"'.format(text, caret), text[(len(key)+1):])
                    [r for r in registers if r.startswith(text[(len(key)+1):])]
                    if text else registers
                )
        return getattr(super(AssemblerPrompt, self), attr)

    def get_names(self):
        return self.__dir__()

    def __dir__(self):
        return super().__dir__() + \
            ['do_'+str(k) for k in self.instructions.keys()] + \
            ['help_'+str(k) for k in self.instructions.keys()] + \
            ['complete_'+str(k) for k in self.instructions.keys()]
 
if __name__ == "__main__":
    p = AssemblerPrompt()
    p.cmdloop()
