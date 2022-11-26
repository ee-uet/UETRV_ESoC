#!/usr/bin/env python3
#
#  * Filename :    Boot_Mem_script.py

#  * Date     :    1-1-2022

#  *

#  *

#  * Description:  Loading the machine code from .txt file into Boot Memory

#  *

#  *********************************************************************/


# Place this script and main.txt file in the same directory or specify the path of main.txt file

import sys
binfile = sys.argv[-2]
cfile   = sys.argv[-1]

src_file = open(binfile , "r")

des_file = open(cfile , "w")


des_file.write("package riscv_uet \n \n" + "object IM { \n")

des_file.write("var im_arr = Array( Array(0x55, 0xaa, 0x33, 0xcc), \n")
des_file.write(" "*20 +"Array(0x00, 0x00, 0x01, 0x48), \n")


index = 0

for line in src_file:

    i = str(index)

    des_file.write(" "*20+"Array(0x"+ line[0] + line[1] +  ", 0x" + line[2] + line[3] +  ", 0x" + line[4] + line[5] + ", 0x" + line[6] + line[7] + ")," + "\n")

    index+=1

des_file.write(" ) \n }")

des_file.close()

src_file.close()
