/*********************************************************************
 * Filename :    pid.scala
 * Date     :    28-03-2020
 * Author   :    Muhammad Tahir
 *
 * Description:  PID controller implementation.
 *********************************************************************/


package MC_Module

import chisel3._
import chisel3.util.Cat

class PID_IO extends Bundle {
  val fb_period  = Input(Bool())
  val raw_irq    = Input(Bool())
  // Interface for PID controller gains
  // Kp gain
  val reg_kp_we  =  Input(Bool())
  val reg_kp_di  =  Input(SInt(16.W))
  val reg_kp_do  =  Output(SInt(16.W))
  // Ki gain
  val reg_ki_we  =  Input(Bool())
  val reg_ki_di  =  Input(SInt(16.W))
  val reg_ki_do  =  Output(SInt(16.W))
  // Kd gain
  val reg_kd_we  =  Input(Bool())
  val reg_kd_di  =  Input(SInt(16.W))
  val reg_kd_do  =  Output(SInt(16.W))

  // Reference signal for PID controller
  val reg_ref_we =  Input(Bool())
  val reg_ref_di =  Input(SInt(16.W))
  val reg_ref_do =  Output(SInt(16.W))

  // Software based feedback signal for PID controller
  val reg_fb_we  =  Input(Bool())
  val reg_fb_di  =  Input(SInt(16.W))
  val reg_fb_do  =  Output(SInt(16.W))

  // Configuration register for PID controller
  val reg_cfg_we =  Input(Bool())
  val reg_cfg_di =  Input(SInt(16.W))
  val reg_cfg_do =  Output(SInt(16.W))

  val speed_fb_in = Input(SInt(16.W)) // input
  val pid_out    = Output(SInt(16.W)) // output
}

class PID_Controller extends Module {

  val io = IO(new PID_IO)

  // Controller gains
  val kp        = RegInit(SInt(16.W), 1.S)
  val ki        = RegInit(SInt(16.W), 0.S)
  val kd        = RegInit(SInt(16.W), 0.S)
  val ref       = RegInit(SInt(16.W), 20.S)
  val feedback  = RegInit(SInt(16.W), 0.S)
  val sigma_old = RegInit(SInt(16.W), 0.S)
  val fb_sel    = RegInit(Bool(), false.B)

  val e_prev1   = RegInit(SInt(16.W), 0.S)
  val e_prev2   = RegInit(SInt(16.W), 0.S)
  val reg_pid_out = RegInit(SInt(16.W), 0.S)

  // Controller gains read write signals
  io.reg_kp_do  := kp
  when(io.reg_kp_we) {
    kp := io.reg_kp_di
  }

  io.reg_ki_do  := ki
  when(io.reg_ki_we) {
    ki := io.reg_ki_di
  }

  io.reg_kd_do  := kd
  when(io.reg_kd_we) {
    kd := io.reg_kd_di
  }

  // Controller reference signal
  io.reg_ref_do := ref
  when(io.reg_ref_we) {
    ref := io.reg_ref_di
  }

  io.reg_fb_do  := feedback

  when(fb_sel) {
    when(io.reg_fb_we) {
     feedback := io.reg_fb_di
    }
  }.otherwise{
    feedback  := io.speed_fb_in
  }

  io.reg_cfg_do := Cat(0.U(31.W), fb_sel).asSInt()
  when(io.reg_cfg_we) {
    fb_sel := io.reg_cfg_di(0)
  }

  // PID implementation
  val delta_err = e_prev1 - e_prev2;
  val sigma_new = e_prev1 + sigma_old;

  // Multiplier for Proportional component
  val mul_kp    = Module(new vedic_16x16)
  mul_kp.io.a   := e_prev1
  mul_kp.io.b   := kp.asUInt()
  val prop_out  = mul_kp.io.c(15,0).asSInt()

  // Multiplier for Integral component
  val mul_ki    = Module(new vedic_16x16)
  mul_ki.io.a   := sigma_new
  mul_ki.io.b   := ki.asUInt()
  val integral_out = mul_ki.io.c(15,0).asSInt()

  // Multiplier for Derivative component
  val mul_kd    = Module(new vedic_16x16)
  mul_kd.io.a   := delta_err
  mul_kd.io.b   := kd.asUInt()
  val derivative_out = mul_kd.io.c(15,0).asSInt()

  // Combining/adding different PID terms
  val pi_sum    = prop_out + integral_out
  val pi_sum_overflow = (prop_out(15) && integral_out(15) && !pi_sum(15)) ||
                        (!prop_out(15) && !integral_out(15) && pi_sum(15))

  when(io.raw_irq) {
    // For period feedback
    when(io.fb_period){
      e_prev1   := feedback - ref
    }.otherwise{  // For speed feedback
      e_prev1   := ref - feedback
    }
    e_prev2     := e_prev1
    sigma_old   := sigma_new
    reg_pid_out := pi_sum + derivative_out;
  }

  io.pid_out    := Mux(pi_sum_overflow || reg_pid_out(15), 0.S, reg_pid_out)
}

