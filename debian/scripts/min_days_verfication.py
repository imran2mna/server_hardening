import sys

arg = sys.argv

print(len(arg))

file_name = arg[1]
search_term = arg[2]
valid_period = int(arg[3])

splitter = None
if len(arg) == 5:
    splitter = arg[4]


lines = []
with open(file_name, 'r') as f:
    for line in f.readlines():
        if search_term in line:
            lines.append(line)

for line in lines:
    if splitter is None:
        out = line.split()
    else:
        out = line.split(splitter)
    try:
        num = int(out[1])
        break
    except ValueError:
        continue
    
if "#" in out[0] or num != valid_period:
    sys.exit(1)
