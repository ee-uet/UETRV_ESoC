FPGA_SRCS_DIR	:= $(shell pwd)/FPGA/launching_vivado/RVProc_Final/RVProc_Final.srcs/sources_1/new
RTL_DIR		:= $(shell pwd)/rtl
SCALA_SRC_DIR	:= $(shell pwd)/src/main/scala
SCALA_SRC_FILES	:= $(shell find ${SCALA_SRC_DIR})
RISCVBIN	:= $(shell pwd)/util/riscv_gcc_v10_1_ubuntu/bin
PATH		:= $(PATH):$(RISCVBIN)
SHELL		:= env PATH=$(PATH) /bin/bash

SBT	:= $(shell which sbt)
ifeq ($(SBT), )
	SBT	:= /usr/bin/sbt
endif

IVERILOG	:= $(shell which iverilog)
ifeq ($(IVERILOG), )
	IVERILOG	:= /usr/bin/iverilog
endif

firmware:	$(RISCVBIN)
	cd examples/motor && make

setup:	$(SBT)	$(IVERILOG)

$(IVERILOG):
	@ echo -e "\n\nInstalling iverilog..."
	sudo apt install iverilog -y

$(SBT):
	@ echo -e "\n\nInstalling sbt..."
	sudo apt-get update
	sudo apt-get install apt-transport-https curl gnupg -yqq
	echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
	echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
	curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo -H gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import
	sudo chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg
	sudo apt-get update
	sudo apt-get install sbt -y

$(RISCVBIN):
	@ echo -e "\n\nInstalling riscv_gcc..."
	wget -q $(shell cat riscv-gcc-url.txt)
	mkdir -p temp
	tar -xf riscv64-unknown-elf-gcc-10.1.0-2020.08.2-x86_64-linux-ubuntu14.tar.gz -C temp
	rm riscv64-unknown-elf-gcc-10.1.0-2020.08.2-x86_64-linux-ubuntu14.tar.gz
	mv temp/riscv64-unknown-elf-gcc-10.1.0-2020.08.2-x86_64-linux-ubuntu14 util/riscv_gcc_v10_1_ubuntu

fpga:	$(FPGA_SRCS_DIR)/ProcFinal.v

$(FPGA_SRCS_DIR)/ProcFinal.v:	$(RTL_DIR)/SoC_Tile_fpga.v
	cp --force $< $@

$(RTL_DIR)/SoC_Tile_fpga.v:	$(RTL_DIR)/SoC_Tile.v
	cd util/fpga &&	./get_verilog_module_from_file.py $< IMem IMem_vlsi.txt && \
			./replace_in_file.py $< $(RTL_DIR)/SoC_Tile_temp.v IMem_vlsi.txt IMem_fpga.txt && \
			./replace_in_file.py $(RTL_DIR)/SoC_Tile_temp.v $@ PC_START_vlsi.txt PC_START_fpga.txt
	rm $(RTL_DIR)/SoC_Tile_temp.v

run_tb:	fpga	$(IVERILOG)
	@ echo -e "\n\nRunning testbench..."
	cd tb && make
	
$(RTL_DIR)/SoC_Tile.v:	$(SCALA_SRC_FILES)
	sbt run
