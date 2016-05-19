import re
matcher = re.compile('^inserted unique force: (\d*\.\d*)$')
with open('pasted_log_file.txt', 'r') as lf:
    lines = lf.readlines()
forces = set()
for line in lines:
    match = matcher.search(line)
    if match:
        groups = match.groups()
        force = groups[0]
        forces.add(float(force))
sorted_forces = sorted(forces)
