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
  input         io_spi_miso,
  input         io_uart_rx
//,  input         io_qei_ch_a,
// input         io_qei_ch_b
//  (* mark_debug = "true" *) output        io_pwm_high,
//  (* mark_debug = "true" *) output        io_pwm_low
,  output        step1step,
  output        io_pwm_low,
  input         homing_switch_1,
  input         homing_switch_2,
  output        led1,
  output        led2,
  output        step2step,
//  output        io_pwm_low_m2,
  output        io_dir_m1,
  output        io_dir_m2,
  output        pen_servo_control
//  , output      io_pwm_low_m3
);
    
  reg [31:0] counter;
  wire x_homed, y_homed;
  wire clk_div_by_8;
  wire clk_div_by_2;
  wire soc_clock;
  wire manual_step1step;
 
  assign clk_div_by_8 = counter[2];
  assign clk_div_by_2 = counter[0];
 
  assign soc_clock = clk_div_by_8;
 
  assign led1 = step1step;
  assign led2 = x_homed;
 
  initial begin
    counter = 0;
  end
 
  always@(posedge clock)
  begin
    counter = counter + 1;
  end
  
  
  SoC_Tile soc(
    .clock(soc_clock),
    .reset(reset),
    .io_uart_tx(io_uart_tx),
    .io_spi_cs(io_spi_cs),
    .io_spi_clk(io_spi_clk),
    .io_spi_mosi(io_spi_mosi),
    .io_spi_miso(io_spi_miso),
    .io_uart_rx(io_uart_rx),
//    .io_uart_rx(io_uart_tx),    // loopback to test UART interrupt
//    .io_m1_io_qei_ch_a(io_qei_ch_a),
//    .io_m1_io_qei_ch_b(io_qei_ch_b),
//    .io_m2_io_x_homed(x_homed),
//    .io_m2_io_y_homed(y_homed),
    .io_m2_io_x_homed(homing_switch_1),    // bypass debouncer
    .io_m2_io_y_homed(homing_switch_2),    // bypass debouncer
//    .io_m1_io_step1step(step1step),
//    .io_m1_io_step2step(step2step),
    .io_m2_io_step1dir(io_dir_m1), 
    .io_m2_io_step2dir(io_dir_m2),
    .io_m1_io_pwm_high(pen_servo_control),
//    .io_m1_io_pwm_low(io_pwm_low),
    .io_m2_io_pwm_low(step1step),
    .io_m3_io_pwm_low(step2step)
    );
    
//    my_ila ila0 (
//        .clk(soc_clock), // input wire clk
    
    
//        .probe0(io_pwm_high), // input wire [0:0]  probe0  
//        .probe1(io_pwm_low) // input wire [0:0]  probe1
//    );

//  assign led1 = homing_switch_1;
//  assign led2 = step1homed;
 
  debounce step1(
    .clk(clock),
    .reset(reset),
    .original_signal(homing_switch_1),
    .debounced_signal(x_homed)
  );
 
//  assign led1 = homing_switch_2;
//  assign led2 = step2homed;
  
  debounce step2(
    .clk(clock),
    .reset(reset),
    .original_signal(homing_switch_2),
    .debounced_signal(y_homed)
  );

endmodule


module debounce(    // untested
  input      clk,
  input      reset,
  input      original_signal,
  output reg debounced_signal
);

  wire in_toggled;
  reg waiting, in, in_old, in_before_wait;
  reg [31:0] counter;
 
  assign in_toggled = in ^ in_old;
 
  always@(posedge clk) begin
    
    if (reset) begin
        waiting <= 0;
        in_before_wait <= 0;
        debounced_signal <= 0;
        counter <= 0;
      end
    else if (!waiting) begin
        if (in_toggled) begin
            counter <= 0;
            waiting <= 1;
            in_before_wait <= in;
          end
      end
    else begin   // waiting
        counter <= counter + 1;
        if (counter == 2000000) begin
            waiting <= 0;
            if (in == in_before_wait)
              debounced_signal <= !debounced_signal;
          end
      end
  end
 
  always@(posedge clk)  begin
    if (reset) in <= 0;
    else       in <= original_signal;
  end
      
  always@(posedge clk)  begin
    if (reset) in_old <= 0;
    else       in_old <= in;
  end

endmodule


