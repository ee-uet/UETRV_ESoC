/*********************************************************************
 * Filename :    motor_top.scala
 * Date     :    28-03-2020
 * Author   :    Muhammad Tahir
 *
 * Description:  Motor top module.
 *********************************************************************/

package MC_Module

import chisel3._
import wishbone.{WB_InterConnect, WishboneSlaveIO}

import chisel3.util.Cat

class MotorGPIO extends Bundle {
  // QEI IOs
  val qei_ch_a   = Input(Bool())
  val qei_ch_b   = Input(Bool())

  // PWM IOs
  val pwm_high    =  Output(Bool())
  val pwm_low     =  Output(Bool())

  // Stepper motor homing inputs
  val x_homed  = Input(Bool())
  val y_homed  = Input(Bool())

  // Stepper motor step pulse outputs (currently unused, motors are being stepped by PWM's low-side outputs instead of these flags)
  val step1step   =  Output(Bool())
  val step2step   =  Output(Bool())

  // Stepper motor direction outputs
  val step1dir    =  Output(Bool())
  val step2dir    =  Output(Bool())
}


class MotorIO extends Bundle {
  // Wishbone bus interface
  val wbs        = new WishboneSlaveIO
  val motor_gpio = new MotorGPIO
  // Motor module IO
  val motor_select = Input(Bool())
  val motor_irq   =  Output(Bool())
}

class Motor_Top extends Module{

  val io = IO(new MotorIO)

  // Interlink module and its IO connections
  val interlink  = Module(new Interlink_Module)

  // Input data and module base address matching signal
  val bus_dat_i             = io.wbs.m2s.data
  interlink.io.motor_select := io.motor_select

  // Wiring WB bus with interlink module
  interlink.io.bus_stb_i    := io.wbs.m2s.stb
  interlink.io.bus_cyc_i    := io.wbs.m2s.cyc
  interlink.io.bus_adr_i    := io.wbs.m2s.addr
  interlink.io.bus_sel_i    := io.wbs.m2s.sel
  interlink.io.bus_we_i     := io.wbs.m2s.we
  io.wbs.data_o             := interlink.io.bus_dat_o
  io.wbs.ack_o              := interlink.io.bus_ack_o

  /********* Timer module IO connections    *********/
  val pwm                   = Module(new PWM)

  pwm.io.x_homed            := io.motor_gpio.x_homed
  pwm.io.y_homed            := io.motor_gpio.y_homed

  pwm.io.reg_val_we         := interlink.io.tmr_val_we
  pwm.io.reg_val_di         := bus_dat_i
  interlink.io.tmr_val_do   :=  pwm.io.reg_val_do

  pwm.io.reg_cfg_we         := interlink.io.tmr_cfg_we
  pwm.io.reg_cfg_di         := bus_dat_i
  interlink.io.tmr_cfg_do   :=  pwm.io.reg_cfg_do

  pwm.io.reg_step_we        := interlink.io.tmr_step_we
  pwm.io.reg_step_di        := bus_dat_i
  interlink.io.tmr_step_do  :=  pwm.io.reg_step_do

  pwm.io.reg_dat_we         := interlink.io.tmr_dat_we
  pwm.io.reg_dat_di         := bus_dat_i
  interlink.io.tmr_dat_do   :=  pwm.io.reg_dat_do
  pwm.io.reg_duty_we        := interlink.io.tmr_duty_we
  pwm.io.reg_duty_di        := bus_dat_i
  interlink.io.tmr_duty_do  :=  pwm.io.reg_duty_do

  io.motor_gpio.step1step   := pwm.io.reg_step_do(5)
  io.motor_gpio.step1dir    := pwm.io.reg_step_do(4)
  io.motor_gpio.step2step   := pwm.io.reg_step_do(3)
  io.motor_gpio.step2dir    := pwm.io.reg_step_do(2)

  // PID output
  val pid_out               = Wire(SInt(16.W))

  pwm.io.reg_pid_out        := pid_out
  io.motor_irq              :=  pwm.io.irq_out

  // pwm IO connections
  io.motor_gpio.pwm_high    :=  pwm.io.pwm_h
  io.motor_gpio.pwm_low     :=  pwm.io.pwm_l


  /******** QEI module and IO connections **********/
  val qei                   = Module(new Quad_Encoder)
  qei.io.quad_a             := io.motor_gpio.qei_ch_a
  qei.io.quad_b             := io.motor_gpio.qei_ch_b
  qei.io.raw_irq            := pwm.io.rawirq_out

  qei.io.reg_count_we       := interlink.io.qei_count_we
  qei.io.reg_count_di       := bus_dat_i
  interlink.io.qei_count_do := qei.io.reg_count_do

  qei.io.reg_cfg_we         := interlink.io.qei_cfg_we
  qei.io.reg_cfg_di         := bus_dat_i
  interlink.io.qei_cfg_do   := qei.io.reg_cfg_do

  interlink.io.qei_speed_do := qei.io.reg_speed_do

  /*********  PID module and IO connections   *********/
  val pid                   = Module(new PID_Controller)
  pid.io.fb_period          := qei.io.fb_period
  pid.io.speed_fb_in        := qei.io.reg_speed_do

  pid.io.reg_kp_we          := interlink.io.pid_kp_we
  pid.io.reg_kp_di          := bus_dat_i(7,0).asSInt()
  interlink.io.pid_kp_do    := pid.io.reg_kp_do

  pid.io.reg_ki_we          := interlink.io.pid_ki_we
  pid.io.reg_ki_di          := bus_dat_i(7,0).asSInt()
  interlink.io.pid_ki_do    := pid.io.reg_ki_do

  pid.io.reg_kd_we          := interlink.io.pid_kd_we
  pid.io.reg_kd_di          := bus_dat_i(7,0).asSInt()
  interlink.io.pid_kd_do    := pid.io.reg_kd_do

  pid.io.reg_ref_we         := interlink.io.pid_ref_we
  pid.io.reg_ref_di         := bus_dat_i(15,0).asSInt()
  interlink.io.pid_ref_do   := pid.io.reg_ref_do

  pid.io.reg_fb_we          := interlink.io.pid_fb_we
  pid.io.reg_fb_di          := bus_dat_i(15,0).asSInt()
  interlink.io.pid_fb_do    := pid.io.reg_fb_do

  pid.io.reg_cfg_we         := interlink.io.pid_cfg_we
  pid.io.reg_cfg_di         := bus_dat_i(15,0).asSInt()
  interlink.io.pid_cfg_do   := pid.io.reg_cfg_do

  pid_out                   := pid.io.pid_out
  pid.io.raw_irq            := pwm.io.rawirq_out
}

