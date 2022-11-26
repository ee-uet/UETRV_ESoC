FPGA_SRCS_DIR=../../FPGA/launching_vivado/RVProc_Final/RVProc_Final.srcs/sources_1/new
SCALA_SRC_DIR=../../src/main/scala
SCALA_SRC_FILES=$(find ${SCALA_SRC_DIR})
RTL_DIR=../../rtl
VLSI_DIR=/home/uetlhr/Documents/SermoPlot_backend/draft_SRAM_blackbox
CHIPYARD_DIR=/home/uetlhr/Desktop/chipyard/chipyard/vlsi/generated-src/chipyard.TestHarness.SoCTileConfig
CHIPYARD_TOP=${CHIPYARD_DIR}/chipyard.TestHarness.SoCTileConfig.top.v
CHIPYARD_MEMS=${CHIPYARD_DIR}/chipyard.TestHarness.SoCTileConfig.top.mems.v
RV64AS=riscv64-unknown-elf-as
RV64CC=riscv64-unknown-elf-gcc
RV64OBJCOPY=riscv64-unknown-elf-objcopy
RV64OBJDUMP=riscv64-unknown-elf-objdump
CFLAGS=-march=rv32i -mabi=ilp32
LDFLAGS=-T linker.ld -nostartfiles

all:	build/imem.scala build/imem.c ${FPGA_SRCS_DIR}/main.mem

sim:	all

run:	all
	cd ${FPGA_SRCS_DIR} && cd ../../../.. && make
	# gnome-terminal -- ./receive_pos.py

fpga:	${FPGA_SRCS_DIR}/ProcFinal.v

${FPGA_SRCS_DIR}/ProcFinal.v:	${RTL_DIR}/SoC_Tile_fpga.v
	mv --force ${FPGA_SRCS_DIR}/ProcFinal.v ${FPGA_SRCS_DIR}/ProcFinal.v.old
	cp --force ${RTL_DIR}/SoC_Tile_fpga.v ${FPGA_SRCS_DIR}/ProcFinal.v

${RTL_DIR}/SoC_Tile_fpga.v:	${RTL_DIR}/SoC_Tile.v
	../../util/fpga/get_verilog_module_from_file.py ${RTL_DIR}/SoC_Tile.v IMem ../../util/fpga/IMem_vlsi.txt
	cd ../../util/fpga && ./replace_in_file.py ${RTL_DIR}/SoC_Tile.v ${RTL_DIR}/SoC_Tile_temp.v IMem_vlsi.txt IMem_fpga.txt
	cd ../../util/fpga && ./replace_in_file.py ${RTL_DIR}/SoC_Tile_temp.v ${RTL_DIR}/SoC_Tile_fpga.v PC_START_vlsi.txt PC_START_fpga.txt

${RTL_DIR}/SoC_Tile.v:	$(shell find ${SCALA_SRC_DIR})
	cd ../.. && sbt run
	cp --force ${RTL_DIR}/SoC_Tile.v ${RTL_DIR}/SoC_Tile_for_backend.v

vlsi:	${VLSI_DIR}/rtl/SoC_Tile_for_backend.v

${VLSI_DIR}/rtl/SoC_Tile_for_backend.v: ${RTL_DIR}/SoC_Tile.v ${CHIPYARD_TOP} ${CHIPYARD_MEMS}
	cp --force ${RTL_DIR}/SoC_Tile_for_backend.v ${VLSI_DIR}/../draft/rtl/SoC_Tile_for_backend.v
	cp --force ${RTL_DIR}/SoC_Tile_for_backend.v ${VLSI_DIR}/rtl/SoC_Tile_for_backend_without_SRAM.v
	cd ${VLSI_DIR}/rtl && make

${FPGA_SRCS_DIR}/main.mem: build/imem.txt
	echo "@0" > $@
	cat $< >> $@

build/imem.scala:	build/imem.txt
	../../util/imem_content_scala.py $< $@

build/imem.c:	build/imem.txt
	../../util/imem_content_c.py $< $@

build/imem.txt:	build/imem.bin
	../../util/make_txt_imem.py $< > $@
	cp -u $@ ../../tb

build/imem.bin:	build/imem.elf
	${RV64OBJCOPY} -O binary --only-section=.data* --only-section=.text* $< $@
	${RV64OBJDUMP} -S -s $< > build/imem.dump

build/imem.elf:	build/startup.o build/uart.o build/main.o build/isr.o
	${RV64CC} -o $@ $^ ${LDFLAGS} ${CFLAGS}

build/startup.o:	main/startup.s
	mkdir -p $(@D)
	${RV64AS} -c -o $@ $< ${CFLAGS}

build/isr.o:	main/isr.s
	mkdir -p $(@D)
	${RV64AS} -c -o $@ $< ${CFLAGS}

build/uart.o:	interfaces/uart.c interfaces/uart.h
	mkdir -p $(@D)
	${RV64CC} -c -o $@ $< ${CFLAGS}

build/main.o:	main/main.c main/defs.h
	mkdir -p $(@D)
	${RV64CC} -c -o $@ $< ${CFLAGS}

build:
	mkdir build

clean:
	# if [ -d 'build' ]; then gio trash build; fi
	rm -rf build


