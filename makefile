RISCVBIN=$(shell pwd)/util/riscv_gcc_v10_1_ubuntu/bin
PATH  := $(PATH):$(RISCVBIN)
SHELL := env PATH=$(PATH) /bin/bash

all:	setup
	cd examples/motor && make

setup:	sbt	riscv_gcc

sbt:
	echo "installing sbt"
	echo RISCVBIN is ${RISCVBIN}

riscv_gcc:	${RISCVBIN}

${RISCVBIN}:
	echo "Installing riscv_gcc..."
	wget https://static.dev.sifive.com/dev-tools/freedom-tools/v2020.08/riscv64-unknown-elf-gcc-10.1.0-2020.08.2-x86_64-linux-ubuntu14.tar.gz && \
	tar -xvf riscv64-unknown-elf-gcc-10.1.0-2020.08.2-x86_64-linux-ubuntu14.tar.gz && \
	rm riscv64-unknown-elf-gcc-10.1.0-2020.08.2-x86_64-linux-ubuntu14.tar.gz && \
	mv riscv64-unknown-elf-gcc-10.1.0-2020.08.2-x86_64-linux-ubuntu14 util/riscv_gcc_v10_1_ubuntu

fpga:	FORCE
	cd examples/motor && make fpga

vlsi:	FORCE
	cd examples/motor && make vlsi

FORCE:
	


