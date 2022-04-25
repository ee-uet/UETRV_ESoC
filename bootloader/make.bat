@echo on

DEL /s .\build\*.*
set GNU_AS=riscv64-unknown-elf-as
set GNU_CC=riscv64-unknown-elf-gcc
set GNU_OBJCOPY=riscv64-unknown-elf-objcopy
set GNU_OBJDUMP=riscv64-unknown-elf-objdump
 
%GNU_AS% -c -o build/startup.o main/startup.s -march=rv32i -mabi=ilp32

%GNU_CC% -c -o build/uart.o interfaces/uart.c -march=rv32i -mabi=ilp32
%GNU_CC% -c -o build/spi.o interfaces/spi.c -march=rv32i -mabi=ilp32
%GNU_CC% -c -o build/bootloader.o main/bootloader.c -march=rv32i -mabi=ilp32
%GNU_CC% -o build/bmem.elf build/startup.o build/uart.o build/spi.o build/bootloader.o -T linker.ld -nostartfiles -march=rv32i -mabi=ilp32

%GNU_OBJCOPY% -O binary --only-section=.data* --only-section=.text* build/bmem.elf build/bmem.bin
%GNU_OBJDUMP% -S -s build/bmem.elf > build/bmem.dump

python ../util/make_txt_bmem.py build/bmem.bin >> build/bmem.txt
python ../util/bmem_content_scala.py build/bmem.txt build/bmem.scala

xcopy .\build\bmem.scala ..\src\main\scala\memory /y

@echo off





