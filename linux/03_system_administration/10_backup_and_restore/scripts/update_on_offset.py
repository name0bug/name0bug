#!/usr/bin/env python3

import sys
path = sys.argv[1]
offset = int(sys.argv[2])
char = sys.argv[3]
file = open(path, 'rb+')
file.seek(offset)
file.write(char.encode())
file.close()
