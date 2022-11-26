#!/usr/bin/env python3

import sys

with open(sys.argv[-2], 'r') as f1:
    replace_this_text = f1.read().rstrip()

with open(sys.argv[-1], 'r') as f2:
    with_this_text = f2.read().rstrip()

with open(sys.argv[-4], 'r') as old_file:
    original_text = old_file.read().rstrip()

if original_text.find(replace_this_text) < 0:
    print("\n\nError: Text to be replaced not found...")
    exit(1)

new_text = original_text.replace(replace_this_text, with_this_text)

with open(sys.argv[-3], 'w') as new_file:
    new_file.write(new_text)
