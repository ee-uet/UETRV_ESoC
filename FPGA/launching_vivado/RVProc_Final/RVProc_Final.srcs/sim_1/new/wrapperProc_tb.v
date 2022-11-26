`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2022 04:10:05 PM
// Design Name: 
// Module Name: wrapperProc_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module wrapperProc_tb;

reg clock, reset, io_spi_miso, io_uart_rx, h1, h2;
wire io_uart_tx, io_spi_cs, io_spi_clk, io_spi_mosi, io_pwm_high, io_pwm_low;

always begin
    #5 clock = ~clock;     // 1/100Mhz = 10ns
end

initial #43001000 $stop;

initial begin
    clock = 0; reset = 0; h1 = 0; h2 = 0;
    #80 #400 reset = 1;
    #80 #400 reset = 0;
    
    
    
    

end


wrapperProc inst_of_wrapperProc(

  .clock(clock), // @[:@11492.4]
  .reset(reset), // @[:@11493.4]
  .io_uart_tx(io_uart_tx), // @[:@11494.4]
  .io_spi_cs(io_spi_cs),             // @[:@11494.4]
  .io_spi_clk(io_spi_clk),            // @[:@11494.4]
  .io_spi_mosi(io_spi_mosi),           // @[:@11494.4]
  .io_spi_miso(io_spi_miso),
  .homing_switch_1(h1),
  .homing_switch_2(h2),
  .io_uart_rx(io_uart_rx)
     
);


    
endmodule
