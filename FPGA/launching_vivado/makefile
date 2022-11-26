MEMFILE=RVProc_Final/RVProc_Final.srcs/sources_1/new/main.mem
IMPL_DIR=RVProc_Final/RVProc_Final.runs/impl_1
TOP_NAME=wrapperProc
BITFILE=${IMPL_DIR}/${TOP_NAME}.bit

run:	${BITFILE}
	cd vivado_logs && vivado -mode tcl -source ../program_FPGA.tcl

${BITFILE}:	${MEMFILE}
	cd updatemem_logs && updatemem -force -debug -meminfo ../${IMPL_DIR}/${TOP_NAME}.mmi -data ../${MEMFILE} -bit ../${BITFILE} -proc soc/wb_inter_connect/imem/imem/IM/xpm_memory_spram_inst/xpm_memory_base_inst -out ../${BITFILE}

