WIDTH=32
DEPTH=1024

def format_content_line(line_num, instr):
    return "\t{}\t:\t{};\n".format(line_num, instr)

def to_mif(instructions):
    with open('ROM.mif', 'w') as f:
        f.write("WIDTH={};\n".format(WIDTH))
        f.write("DEPTH={};\n\n".format(DEPTH))
        f.write("ADDRESS_RADIX=UNS;\nDATA_RADIX=UNS;\n\n")
        f.write("CONTENT BEGIN\n")
        for i, instr in enumerate(instructions):
            f.write(format_content_line(i, instr))
        f.write(format_content_line('[{}..{}]'.format(len(instructions),DEPTH-1), 0))
        f.write("END;\n")
