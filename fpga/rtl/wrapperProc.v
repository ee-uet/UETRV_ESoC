`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2022 02:20:48 PM
// Design Name: 
// Module Name: wrapperProc
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


module wrapperProc(

  input         clock, // @[:@11492.4]
  input         reset, // @[:@11493.4]
  output        io_uart_tx, // @[:@11494.4]
  output        io_spi_cs,             // @[:@11494.4]
                io_spi_clk,            // @[:@11494.4]
                io_spi_mosi,           // @[:@11494.4]
   input        io_spi_miso,
   input         io_uart_rx,
   input         io_qei_ch_a,
   input         io_qei_ch_b,
   output        io_pwm_high,
   output        io_pwm_low,
   input   io_m2_io_qei_ch_a, // @[:@28797.4]
   input   io_m2_io_qei_ch_b, // @[:@28797.4]
   output  io_m2_io_pwm_high, // @[:@28797.4]
   output  io_m2_io_pwm_low, // @[:@28797.4]
   input   io_m3_io_qei_ch_a, // @[:@28797.4]
   input   io_m3_io_qei_ch_b, // @[:@28797.4]
   output  io_m3_io_pwm_high, // @[:@28797.4]
   output  io_m3_io_pwm_low // @[:@28797.4]
);

  
  reg [31:0] counter;
  initial begin
    counter = 0;
  end
  
  always@(posedge clock)
  begin
    counter = counter + 1;
  end   
                    
SoC_Tile proc(  .clock(counter[1]), 
                .reset(reset), 
                .io_uart_tx(io_uart_tx), 
                .io_uart_rx(io_uart_rx), 
                .io_spi_cs(io_spi_cs), 
                .io_spi_clk(io_spi_clk),
                .io_spi_mosi(io_spi_mosi), 
                .io_spi_miso(io_spi_miso), 
                .io_m1_io_qei_ch_a(io_qei_ch_a),
                .io_m1_io_qei_ch_b(io_qei_ch_b), 
                .io_m1_io_pwm_high(io_pwm_high), 
                .io_m1_io_pwm_low(io_pwm_low), // @[:@28797.4]
                .io_m2_io_qei_ch_a(io_m2_io_qei_ch_a), 
                .io_m2_io_qei_ch_b(io_m2_io_qei_ch_b),
                .io_m3_io_qei_ch_a(io_m3_io_qei_ch_a),
                .io_m3_io_qei_ch_b(io_m3_io_qei_ch_a),
                .io_m2_io_pwm_high(io_m2_io_pwm_high),
                .io_m2_io_pwm_low(io_m2_io_pwm_low),
                .io_m3_io_pwm_high(io_m3_io_pwm_high),
                .io_m3_io_pwm_low(io_m3_io_pwm_low)
             );
                  
endmodule
