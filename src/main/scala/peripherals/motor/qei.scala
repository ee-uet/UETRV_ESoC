/*********************************************************************
 * Filename :    qei.scala
 * Date     :    28-03-2020
 * Author   :    Muhammad Tahir
 *
 * Description:  QEI interface for speed feedback of the motor.
 *********************************************************************/

package MC_Module

import chisel3._
import chisel3.util.Cat

class QuadIO extends Bundle {
  val quad_a        = Input(Bool())
  val quad_b        = Input(Bool())
  val raw_irq       = Input(Bool())

  val reg_count_we  = Input(Bool())
  val reg_count_di  = Input(UInt(32.W))
  val reg_count_do  = Output(UInt(32.W))

  val reg_cfg_we    = Input(Bool())
  val reg_cfg_di    = Input(UInt(32.W))
  val reg_cfg_do    = Output(UInt(32.W))

  // Speed output
  val reg_speed_do  = Output(SInt(16.W))
  val fb_period     = Output(Bool())
}

class Quad_Encoder extends Module {
  val io = IO(new QuadIO)

  val quad_a_delayed   = RegInit(UInt(3.W), 0.U)
  val quad_b_delayed   = RegInit(UInt(3.W), 0.U)
  val count_reg        = RegInit(UInt(32.W), 0.U)
  val count_reg_2      = RegInit(UInt(16.W), 0.U)
  val period_count     = RegInit(UInt(16.W), 0.U)

  val speed_enable     = RegInit(Bool(), true.B)
  val count_sel_2x     = RegInit(Bool(), true.B)
  val count_old        = RegInit(UInt(32.W), 0.U)
  val qei_output       = RegInit(UInt(16.W), 0.U)
  val qei_speed_count  = RegInit(UInt(16.W), 0.U)
  val qei_period_count = RegInit(UInt(16.W), 0x1FFF.U)
  val period_sel       = RegInit(Bool(), false.B)

  io.reg_count_do     := count_reg

  quad_a_delayed      := Cat(quad_a_delayed(1), quad_a_delayed(0), io.quad_a)
  quad_b_delayed      := Cat(quad_b_delayed(1), quad_b_delayed(0), io.quad_b)

  val count_2x         = WireInit(Bool(), quad_a_delayed(1)^quad_a_delayed(2))
  val count_4x         = WireInit(Bool(), quad_a_delayed(1)^quad_a_delayed(2)^quad_b_delayed(1)^quad_b_delayed(2))
  val count_direction  = WireInit(Bool(), quad_a_delayed(1)^quad_b_delayed(2))
  val count_pulses     = Mux(count_sel_2x, count_2x, count_4x)

  // Event for generating speed calculation interval
  val scount_flag      = io.raw_irq

  when(count_pulses) {
    when(count_direction) {
      count_reg       := count_reg + 1.U
    } .otherwise {
      count_reg       := count_reg - 1.U
    }
  }

  // Counter for speed measurement
  when(scount_flag || count_pulses) {
    when(scount_flag) {
      qei_speed_count := count_reg_2
      count_reg_2     := 0.U
    }.otherwise {
      count_reg_2     := count_reg_2 + 1.U
    }
  }

  // Counter for period measurement (add another elsewhen with period_count exceeding some threshold)
  when(period_sel) {
    when(count_pulses) {
      qei_period_count := period_count
      period_count     := 0.U
    }.elsewhen(period_count === 0xFF.U){
      qei_period_count := period_count
      period_count     := 0.U
    }.otherwise {
      period_count     := period_count + 1.U
    }
  }

  // Feedback selection
  qei_output           := Mux(period_sel, qei_period_count, qei_speed_count)

  // Configuration register
  io.reg_cfg_do        := Cat(0.U(29.W), period_sel, speed_enable, count_sel_2x)

  // Encoder output signals
  io.reg_speed_do      := qei_output(15,0).asSInt()
  io.fb_period         := period_sel

  when(io.reg_count_we) {
    count_reg          := io.reg_count_di
  }.elsewhen(io.reg_cfg_we){
    count_sel_2x       := io.reg_cfg_di(0)
    speed_enable       := io.reg_cfg_di(1)
    period_sel         := io.reg_cfg_di(2)
  }
}

