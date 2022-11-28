@echo on

DEL /s .\build\*.*
set GNU_AS=riscv64-unknown-elf-as
set GNU_CC=riscv64-unknown-elf-gcc
set GNU_OBJCOPY=riscv64-unknown-elf-objcopy
set GNU_OBJDUMP=riscv64-unknown-elf-objdump
 
%GNU_AS% -c -o build/startup.o main/startup.s -march=rv32i -mabi=ilp32

%GNU_CC% -c -o build/uart.o interfaces/uart.c -march=rv32i -mabi=ilp32
%GNU_CC% -c -o build/main.o main/main.c -march=rv32i -mabi=ilp32
%GNU_CC% -o build/imem.elf build/startup.o build/uart.o build/main.o -T linker.ld -nostartfiles -march=rv32i -mabi=ilp32

%GNU_OBJCOPY% -O binary --only-section=.data* --only-section=.text* build/imem.elf build/imem.bin
%GNU_OBJDUMP% -S -s build/imem.elf > build/imem.dump

python ../../util/make_txt_imem.py build/imem.bin >> build/imem.txt
python ../../util/imem_content_c.py build/imem.txt build/imem.c
python ../../util/imem_content_scala.py build/imem.txt build/imem.scala

xcopy .\build\imem.txt ..\..\tb /y

@echo off


