#!/usr/bin/env python3
#
# Usage: source_file    module_name    dest_file

import sys

with open(sys.argv[-3], 'r') as f1:
    source_file = f1.read().rstrip()

module_start_location = source_file.find('module ' + sys.argv[-2] + '(')
if module_start_location < 0:
    print("\n\nError: Module not found...")
    exit(1)

word_end_module = 'endmodule'
module_end_location = source_file[module_start_location:-1].find(word_end_module) + module_start_location + len(word_end_module)
module = source_file[module_start_location : module_end_location]

with open(sys.argv[-1], 'w') as new_file:
    new_file.write(module)
