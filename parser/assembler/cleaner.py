from parser.data.instructions import instructions

def uncomment(lines):
    for line in lines:
        uncommented = line.split("#")[0].strip()
        if len(uncommented) > 0:
            yield uncommented

def translate_labels(lines):
    # {label: address} => {'loop': 8000}
    labels = {}
    # get labels
    for i, line in enumerate(lines):
        if ':' in line:
            label = line.split(':')[0]
            labels[label] = i
    
    for i, line in enumerate(lines):
        line_labels = [label for label in labels if label in line]
        has_label = len(line_labels) > 0
        if not has_label:
            yield line
        else:
            for label in line_labels:
                line = line.replace(label+':', '').strip()
            if len(line) == 0:
                continue
            for label in line_labels:
                token = line.split(' ')[0]
                branch_type = instructions[token]['branch']
                addr = labels[label]
                if branch_type:
                    line = line.replace(label, str(addr-(i+1)))
                else:
                    line = line.replace(label, str(addr))
            yield line