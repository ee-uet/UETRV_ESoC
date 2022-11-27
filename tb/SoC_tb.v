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

reg VDD, VSS;

reg clk, reset;
reg homing_switch_1, homing_switch_2;
reg [31:0] loop_count, wdata;
reg [7:0]  bdata;

reg [31:0] buffer [0:511];  // buffer for SPI flash memory
reg [31:0] index, byte_no, bit_index;
reg bit_data;

  wire  io_uart_tx; // @[:@12640.4]
  reg   io_uart_rx; // @[:@12640.4]
  wire  io_spi_cs; // @[:@12640.4]
  wire  io_spi_clk; // @[:@12640.4]
  wire  io_spi_mosi; // @[:@12640.4]
  reg   io_spi_miso; // @[:@12640.4]
  reg   io_qei_ch_a; // @[:@12640.4]
  reg   io_qei_ch_b; // @[:@12640.4]
  wire  io_pwm_high; // @[:@12640.4]
  wire  io_pwm_low; // @[:@12640.4]
  wire  io_dir_m1;
  wire  io_dir_m2;
  wire  step1step;
  wire  step2step;
  wire  pen_servo_control;

SoC_Tile dut (
.clock             (clk),
.reset             (reset),
.io_uart_tx        (io_uart_tx),
//.io_uart_rx        (io_uart_rx),
.io_uart_rx        (io_uart_tx),    // loopback
.io_spi_cs         (io_spi_cs),
.io_spi_clk        (io_spi_clk),
.io_spi_mosi       (io_spi_mosi),
.io_spi_miso       (io_spi_miso),
.io_m1_io_qei_ch_a (io_qei_ch_a),
.io_m1_io_qei_ch_b (io_qei_ch_b),
//.io_m1_io_pwm_high (io_pwm_high),
//.io_m1_io_pwm_low  (io_pwm_low),
.io_m2_io_x_homed  (homing_switch_1),
.io_m2_io_y_homed  (homing_switch_2),
.io_m2_io_step1dir (io_dir_m1),
.io_m2_io_step2dir (io_dir_m2),
.io_m1_io_pwm_high (pen_servo_control),
.io_m2_io_pwm_low  (step1step),
.io_m3_io_pwm_low  (step2step)
`ifdef TB_PINS_FOR_VDD_VSS
 ,.VDD(VDD),
  .VSS(VSS)
`endif
); 

//`ifdef SDF_TEST
//    initial begin
//        $sdf_annotate("../../synthesis/riscv_delays.sdf", RISCVCPU_tb.my_cpu,,"sdf.log","MAXIMUM");
//    end
//`endif
 

initial #0 begin 
clk=0;
forever #5 clk=~clk;
end

initial #0 begin
VDD = 1;
VSS = 0;
reset=1;
io_spi_miso = 0;
io_uart_rx = 1;
homing_switch_1 = 0;
homing_switch_2 = 0;
io_qei_ch_a = 0;
io_qei_ch_b = 0;
#20;
reset=0;
end

always@(*)	$display("Time: %d \t index = %d ", $time, index);

initial #0 
 begin

    $dumpfile("SoC_tb.vcd");
    //$dumpvars(0, SoC_tb);
    $dumpvars(1, SoC_tb.index, SoC_tb.dut.wb_inter_connect.uart.tx_data_r, SoC_tb.io_dir_m1, SoC_tb.io_dir_m2, SoC_tb.pen_servo_control, SoC_tb.step1step, SoC_tb.step2step);
    //$monitor("t=%9d \t index = %d \t PC = %h \t IMem[127] = %h \t IMem[128] = %h", $time, index, dut.core.dpath.pc, dut.wb_inter_connect.imem.imem.imem[127], dut.wb_inter_connect.imem.imem.imem[128] );
	
    $readmemh(
        `ifndef GATELEVEL
            "imem.txt"
        `else
            "../../sim/imem.txt"
        `endif
        , buffer);

    index = 0;

    for (loop_count = 0; loop_count < 300000; loop_count = loop_count + 1)
    begin
        //$display("Loop count = %d\n", loop_count);
        @ (posedge clk);

        // transmit the instruction memory contents byte by byte over SPI
        //if (index < 512)
        //begin
    	if (io_spi_mosi == 1)
    	begin
    	    wdata = buffer[index];
    	    index = index + 1;  // increment byte index
    	    repeat (431) @ (posedge clk);
    	    for (byte_no = 0; byte_no < 4; byte_no = byte_no + 1) 
            begin
                case (byte_no)
                    0:  bdata = wdata[7:0];
                    1:  bdata = wdata[15:8];
                    2:  bdata = wdata[23:16];
                    3:  bdata = wdata[31:24];
                endcase
    	        repeat (68) @ (posedge clk);
                // transmit the selected byte bit by bit over SPI
	    	for (bit_index = 0; bit_index < 8; bit_index = bit_index + 1) 
	    	begin
            	    io_spi_miso = bdata[7 - bit_index];
	    	    repeat (8) @ (posedge clk);
	    	end
	    	@ (posedge clk);
	    	io_spi_miso = 0;
        end
	end
	//end
    end
    
    $display("%c[1;31m",27);
    $display("Testbench failed.");
    $display("%c[0m",27);
    $finish; 
 end

 initial        // logic has been verified through practical demonstration using FPGA, hence this testbench is only checking connections by applying inputs and observing that the outputs are toggling as a result of the inputs
 begin
    wait(SoC_tb.dut.wb_inter_connect.uart.tx_data_r == 8'd0);   // wait till program transmits the coordinates (0, 0)
    repeat(2)       // wait for 2 pulses of pen_servo_control output
    begin
        @ (posedge pen_servo_control);
        @ (negedge pen_servo_control);
    end
    wait(SoC_tb.dut.wb_inter_connect.uart.tx_data_r == 8'd100);         // wait for d i.e. the down command
    @ (posedge io_dir_m2);          // current coordinates are (0, 0) so no movement occurs i.e. no step pulses to motors; just check for change of direction output
    wait(SoC_tb.dut.wb_inter_connect.uart.tx_data_r == 8'd108);         // wait for l i.e. the left command
    wait(step1step == 1'b0);
    wait(step2step == 1'b0);
    @ (negedge io_dir_m1);
    wait(step1step == 1'b1);
    wait(step2step == 1'b1);
    @ (negedge step1step);
    wait(step2step == 1'b0);
    #1000
    
    $display("Testbench passed.");
    $finish;
 end

endmodule

