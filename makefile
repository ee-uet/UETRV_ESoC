all:	fpga
	cd examples/motor && make

fpga:	FORCE
	cd examples/motor && make fpga

vlsi:	FORCE
	cd examples/motor && make vlsi

FORCE:
	


