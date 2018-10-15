#!/usr/bin/env python3
# Joshua Chen
# 2015-07-13
# Shenzhen
# Desc: backup the file one byte a time with a sleep period.

import sys, os
from time import sleep

interval = 1    # default interval is 0.2 seconds

if len(sys.argv) == 2:
    src = sys.argv[1]
elif len(sys.argv) == 3:
    interval = float(sys.argv[1])
    src = sys.argv[2]
else:
    print('Usage: %s [interval] file' % os.path.basename(sys.argv[0]))
    exit(1)

if not os.path.isfile(src):
    print('%s is not a regular file' % src)
    exit(1)

srcFile = open(src, 'rb')
with open(src, 'rb') as srcFile:
    while True:
        B = srcFile.read(1)
        if not B: break
        print(B.decode(), end='', flush=True)
        sleep(interval)

