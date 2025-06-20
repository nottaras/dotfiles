#!/usr/bin/python3
import os
import sys
from Alfred3 import Tools

f_path = Tools.getEnv('mypath')

if os.path.isdir(f_path):
    sys.stdout.write("DIR")
elif os.path.isfile(f_path):
    sys.stdout.write("FILE")
else:
    sys.stdout.write("UNKNOWN")