/*********************************************************************
 * Filename :    interlink.scala
 * Date     :    28-03-2020
 * Author   :    Muhammad Tahir
 *
 * Description:  Interlink module for address decoding for motor
 *               module.
 *********************************************************************/

package MC_Module

import chisel3._
//import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}
//import sv2chisel.helpers.vecconvert._
import chisel3.util.Cat

trait Config {

 // val BASE_ADDRESS = "h0_0003".U(20.W) // Top 20 lines for base address comparison

  // Timer register offset addresses
  val TM_CONFIG    = "h000".U(12.W)
  val TM_VALUE     = "h004".U(12.W)
  val TM_DATA      = "h008".U(12.W)
  val TM_DUTY      = "h00C".U(12.W)

  // QEI register offset addresses
  val QEI_COUNT    = "h100".U(12.W)
  val QEI_SPEED    = "h104".U(12.W)
  val QEI_CFG      = "h108".U(12.W)

  // PID controller register offset addresses
  val PID_KP       = "h200".U(12.W)
  val PID_KI       = "h204".U(12.W)
  val PID_KD       = "h208".U(12.W)
  val PID_REF      = "h20C".U(12.W)
  val PID_FB       = "h210".U(12.W)
  val PID_CFG      = "h214".U(12.W)
}

class InterLinkIO extends Bundle {
  // Wishbone bus signals
  val bus_adr_i    = Input(UInt(32.W))
  val bus_sel_i    = Input(UInt(4.W))
  val bus_we_i     = Input(Bool())
  val bus_cyc_i    = Input(Bool())
  val bus_stb_i    = Input(Bool())
  val bus_ack_o    = Output(Bool())
  val bus_dat_o    = Output(UInt(32.W))

  // IOs for timer module
  val tmr_val_we   = Output(Bool())
  val tmr_val_do   = Input(UInt(32.W))
  val tmr_dat_we   = Output(Bool())
  val tmr_dat_do   = Input(UInt(32.W))
  val tmr_duty_we  = Output(Bool())
  val tmr_duty_do  = Input(UInt(32.W))
  val tmr_cfg_we   = Output(Bool())
  val tmr_cfg_do   = Input(UInt(32.W))

  val qei_count_we = Output(Bool())
  val qei_count_do = Input(UInt(32.W))
  val qei_cfg_we   = Output(Bool())
  val qei_cfg_do   = Input(UInt(32.W))
  val qei_speed_do = Input(SInt(16.W))

  val pid_kp_we    = Output(Bool())
  val pid_kp_do    = Input(SInt(16.W))
  val pid_ki_we    = Output(Bool())
  val pid_ki_do    = Input(SInt(16.W))
  val pid_kd_we    = Output(Bool())
  val pid_kd_do    = Input(SInt(16.W))
  val pid_ref_we   = Output(Bool())
  val pid_ref_do   = Input(SInt(16.W))
  val pid_fb_we    = Output(Bool())
  val pid_fb_do    = Input(SInt(16.W))
  val pid_cfg_we   = Output(Bool())
  val pid_cfg_do   = Input(SInt(16.W))

  // Module base address match signal
  val motor_select     = Input(Bool())
}


class Interlink_Module extends Module with Config{

  val io = IO(new InterLinkIO)

   val bus_valid    = WireInit(Bool(), io.bus_stb_i && io.bus_cyc_i)

  // timer module register read/write related definitions
  val tmr_cfg_do    = Wire(UInt(32.W))
  val tmr_val_do    = Wire(UInt(32.W))
  val tmr_dat_do    = Wire(UInt(32.W))
  val tmr_duty_do   = Wire(UInt(32.W))

  val base_adr_sel  = io.motor_select
  val reg_offset    = io.bus_adr_i(11,0)

  val tmr_cfg_sel   = WireInit(Bool(), bus_valid && base_adr_sel && (reg_offset === TM_CONFIG))
  val tmr_val_sel   = WireInit(Bool(), bus_valid && base_adr_sel && (reg_offset === TM_VALUE))
  val tmr_dat_sel   = WireInit(Bool(), bus_valid && base_adr_sel && (reg_offset === TM_DATA))
  val tmr_duty_sel  = WireInit(Bool(), bus_valid && base_adr_sel && (reg_offset === TM_DUTY))

  val tmr_cfg_we    = WireInit(Bool(), Mux((tmr_cfg_sel), (io.bus_sel_i(0) & Cat(io.bus_we_i)), "b0".U(1.W)))
  val tmr_val_we    = WireInit(Bool(), Mux((tmr_val_sel), (io.bus_sel_i(0) & Cat(io.bus_we_i)), "b0".U(1.W)))
  val tmr_dat_we    = WireInit(Bool(), Mux((tmr_dat_sel), (io.bus_sel_i(0) & Cat(io.bus_we_i)), "b0".U(1.W)))
  val tmr_duty_we   = WireInit(Bool(), Mux((tmr_duty_sel), (io.bus_sel_i(0) & Cat(io.bus_we_i)), "b0".U(1.W)))

  val reg_dat_re    = WireInit(Bool(), tmr_dat_sel &&  !(io.bus_sel_i =/= 0.U) &&  ~io.bus_we_i)

  val tmr_sel       = tmr_cfg_sel || tmr_val_sel || tmr_dat_sel || tmr_duty_sel
  val tmr_do        = Mux((tmr_cfg_sel), tmr_cfg_do, Mux((tmr_val_sel), tmr_val_do,
                      Mux(tmr_duty_sel, tmr_duty_do, tmr_dat_do)))


  val qei_count_do  = Wire(UInt(32.W))
  val qei_count_sel = WireInit(Bool(), bus_valid && base_adr_sel && (reg_offset === QEI_COUNT))
  val qei_count_we  = WireInit(Bool(), Mux((qei_count_sel), (io.bus_sel_i(0) & Cat(io.bus_we_i)), "b0".U(1.W)))

  val qei_cfg_do    = Wire(UInt(32.W))
  val qei_cfg_sel   = WireInit(Bool(), bus_valid && base_adr_sel && (reg_offset === QEI_CFG))
  val qei_cfg_we    = WireInit(Bool(), Mux((qei_cfg_sel), (io.bus_sel_i(0) & Cat(io.bus_we_i)), "b0".U(1.W)))

  val qei_speed_do  = Wire(UInt(32.W))
  val qei_speed_sel = WireInit(Bool(), bus_valid && base_adr_sel && (reg_offset === QEI_SPEED))
  val qei_speed_we  = WireInit(Bool(), Mux((qei_speed_sel), (io.bus_sel_i(0) & Cat(io.bus_we_i)), "b0".U(1.W)))


  val qei_sel       = qei_count_sel || qei_cfg_sel || qei_speed_sel
  val qei_do        = Mux(qei_speed_sel, qei_speed_do, Mux(qei_cfg_sel, qei_cfg_do, qei_count_do))

  // PID module and IO connections
  val pid_kp_do     = Wire(SInt(16.W))
  val pid_kp_sel    = WireInit(Bool(), bus_valid && base_adr_sel && (reg_offset === PID_KP))
  val pid_kp_we     = WireInit(Bool(), Mux((pid_kp_sel), (io.bus_sel_i(0) & Cat(io.bus_we_i)), "b0".U(1.W)))

  val pid_ki_do     = Wire(SInt(16.W))
  val pid_ki_sel    = WireInit(Bool(), bus_valid && base_adr_sel && (reg_offset === PID_KI))
  val pid_ki_we     = WireInit(Bool(), Mux((pid_ki_sel), (io.bus_sel_i(0) & Cat(io.bus_we_i)), "b0".U(1.W)))

  val pid_kd_do     = Wire(SInt(16.W))
  val pid_kd_sel    = WireInit(Bool(), bus_valid && base_adr_sel && (reg_offset === PID_KD))
  val pid_kd_we     = WireInit(Bool(), Mux((pid_kd_sel), (io.bus_sel_i(0) & Cat(io.bus_we_i)), "b0".U(1.W)))

  val pid_ref_do    = Wire(SInt(16.W))
  val pid_ref_sel   = WireInit(Bool(), bus_valid && base_adr_sel && (reg_offset === PID_REF))
  val pid_ref_we    = WireInit(Bool(), Mux((pid_ref_sel), (io.bus_sel_i(0) & Cat(io.bus_we_i)), "b0".U(1.W)))

  val pid_fb_do     = Wire(SInt(16.W))
  val pid_fb_sel    = WireInit(Bool(), bus_valid && base_adr_sel && (reg_offset === PID_FB))
  val pid_fb_we     = WireInit(Bool(), Mux((pid_fb_sel), (io.bus_sel_i(0) & Cat(io.bus_we_i)), "b0".U(1.W)))

  val pid_cfg_do    = Wire(SInt(16.W))
  val pid_cfg_sel   = WireInit(Bool(), bus_valid && base_adr_sel && (reg_offset === PID_CFG))
  val pid_cfg_we    = WireInit(Bool(), Mux((pid_cfg_sel), (io.bus_sel_i(0) & Cat(io.bus_we_i)), "b0".U(1.W)))

  val pid_sel       = pid_kp_sel || pid_ki_sel || pid_kd_sel || pid_ref_sel || pid_fb_sel || pid_cfg_sel
  val pid_do        = Mux(pid_kp_sel, pid_kp_do, Mux(pid_ki_sel, pid_ki_do,
                                          Mux(pid_kd_sel, pid_kd_do,
                                          Mux(pid_ref_sel, pid_ref_do,
                                          Mux(pid_fb_sel, pid_fb_do, pid_cfg_do)))))

  // update the WB output signals
  val wb_ack_o      = RegInit(Bool(), false.B)
  val wb_data_o     = RegInit(UInt(32.W), 0.U)
  wb_data_o         := Mux(tmr_sel, tmr_do, Mux(qei_sel, qei_do, Mux(pid_sel, pid_do.asUInt(), 0.U)))
  wb_ack_o          := tmr_sel || qei_sel || pid_sel

  io.bus_dat_o      := wb_data_o
  io.bus_ack_o      := wb_ack_o

  // IO wiring for different modules
  io.tmr_val_we     := tmr_val_we
  tmr_val_do        := io.tmr_val_do
  io.tmr_dat_we     := tmr_dat_we
  tmr_dat_do        := io.tmr_dat_do
  io.tmr_duty_we    := tmr_duty_we
  tmr_duty_do       := io.tmr_duty_do
  io.tmr_cfg_we     := tmr_cfg_we
  tmr_cfg_do        := io.tmr_cfg_do

  io.qei_count_we   := qei_count_we
  qei_count_do      := io.qei_count_do
  io.qei_cfg_we     := qei_cfg_we
  qei_cfg_do        := io.qei_cfg_do
  qei_speed_do      := io.qei_speed_do.asUInt()

  io.pid_kp_we      := pid_kp_we
  pid_kp_do         := io.pid_kp_do
  io.pid_ki_we      := pid_ki_we
  pid_ki_do         := io.pid_ki_do
  io.pid_kd_we      := pid_kd_we
  pid_kd_do         := io.pid_kd_do
  io.pid_ref_we     := pid_ref_we
  pid_ref_do        := io.pid_ref_do
  io.pid_fb_we      := pid_fb_we
  pid_fb_do         := io.pid_fb_do
  io.pid_cfg_we     := pid_cfg_we
  pid_cfg_do        := io.pid_cfg_do
}

