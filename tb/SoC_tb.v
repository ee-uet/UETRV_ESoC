/***********************************************************************
* A simple testbench for SoC functional testing. The processor starts
* execution on reset from on chip integrated boot memroy. The boot 
* memory is preconfigured with a simple bootloader. The bootloader
* loads the user application program from an external (off-chip) flash
* memory using SPI interface. Once the application program is loaded
* to the instruction memory, the bootloader hands over the control of  
* execution to the loaded user program. 
* 
* This test bench mimics the behavior of an external SPI flash memory
* and responds to the read requestes from the boot loader. The pre-
* compiled user program is loaded from "flash.txt" in ascii format by
* the testbench. The testbench is finished after booting and executing 
* the user program for few iterations. The bootloader and user 
* application program are available in separate git repos. 
*
* Author:   Muhammad Tahir
*
* Date:     Mar 2, 2022
************************************************************************/ 

`timescale 1 ns / 100 ps

module SoC_tb();
reg clk, reset;
reg [31:0] loop_count, wdata;
reg [7:0]  bdata;

reg [31:0] buffer [0:255];  // buffer for SPI flash memory
reg [7:0] count, index;
reg bit_data;

  wire io_uart_tx; // @[:@12640.4]
  reg   io_uart_rx; // @[:@12640.4]
  wire  io_spi_cs; // @[:@12640.4]
  wire  io_spi_clk; // @[:@12640.4]
  wire  io_spi_mosi; // @[:@12640.4]
  reg   io_spi_miso; // @[:@12640.4]
  reg   io_qei_ch_a; // @[:@12640.4]
  reg   io_qei_ch_b; // @[:@12640.4]
  wire  io_pwm_high; // @[:@12640.4]
  wire  io_pwm_low; // @[:@12640.4]

SoC_Tile dut (
.clock             (clk),
.reset             (reset),
.io_uart_tx        (io_uart_tx),
.io_uart_rx        (io_uart_rx),
.io_spi_cs        (io_spi_cs),
.io_spi_clk        (io_spi_clk),
.io_spi_mosi        (io_spi_mosi),
.io_spi_miso        (io_spi_miso),
.io_qei_ch_a        (io_qei_ch_a),
.io_qei_ch_b        (io_qei_ch_b),
.io_pwm_high        (io_pwm_high),
.io_pwm_low        (io_pwm_low)
); 


initial #0 begin 
clk=0;
forever #5 clk=~clk;
end

initial #0 begin
reset=1;
io_spi_miso = 0;
#20;
reset=0;
end

initial #0 
 begin

    $dumpfile("SoC_tb.vcd");
    $dumpvars(0, SoC_tb);
	
    $readmemh("imem.txt", buffer);

    index = 0;

    for (loop_count = 0; loop_count < 19000; loop_count = loop_count + 1)
    begin
        repeat (1) @ (posedge clk);

	
	if(io_spi_mosi == 1)
	begin
		wdata = buffer[index++];
		bdata = wdata[7:0];
		repeat (499) @ (posedge clk);
		for (count = 0; count < 8; count++) 
		begin
        		io_spi_miso = bdata[7-count];
			repeat (8) @ (posedge clk);
       
		end
		repeat (1) @ (posedge clk);
		io_spi_miso = 0;

		bdata = wdata[15:8];
		repeat (68) @ (posedge clk);
		for (count = 0; count < 8; count++) 
		begin
        		io_spi_miso = bdata[7-count];
			repeat (8) @ (posedge clk);
       
		end
		repeat (1) @ (posedge clk);
		io_spi_miso = 0;

		bdata = wdata[23:16];
		repeat (68) @ (posedge clk);
		for (count = 0; count < 8; count++) 
		begin
        		io_spi_miso = bdata[7-count];
			repeat (8) @ (posedge clk);
       
		end
		repeat (1) @ (posedge clk);
		io_spi_miso = 0;

		bdata = wdata[31:24];
		repeat (68) @ (posedge clk);
		for (count = 0; count < 8; count++) 
		begin
        		io_spi_miso = bdata[7-count];
			repeat (8) @ (posedge clk);
       
		end
		repeat (1) @ (posedge clk);
		io_spi_miso = 0;
	end
    


    end
    
    $display("End of simulation");
    $finish; 
 end


endmodule