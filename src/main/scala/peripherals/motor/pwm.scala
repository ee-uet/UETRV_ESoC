/*********************************************************************
 * Filename :    pwm.scala
 * Date     :    28-03-2020
 * Author   :    Muhammad Tahir
 *
 * Description:  PWM generation based on the PID controller output.
**********************************************************************/


package MC_Module

import chisel3._
import chisel3.util.Cat

class PWM_IO extends Bundle {

  val reg_val_we  = Input(Bool())
  val reg_val_di  = Input(UInt(32.W))
  val reg_val_do  = Output(UInt(32.W))
  val reg_cfg_we  = Input(Bool())
  val reg_cfg_di  = Input(UInt(32.W))
  val reg_cfg_do  = Output(UInt(32.W))
  val reg_dat_we  = Input(Bool())
  val reg_dat_di  = Input(UInt(32.W))
  val reg_dat_do  = Output(UInt(32.W))
  val reg_duty_we = Input(Bool())
  val reg_duty_di = Input(UInt(32.W))
  val reg_duty_do = Output(UInt(32.W))
  val reg_step_we = Input(Bool())
  val reg_step_di = Input(UInt(32.W))
  val reg_step_do = Output(UInt(32.W))

  val reg_pid_out = Input(SInt(16.W))

  val pwm_h       = Output(Bool())
  val pwm_l       = Output(Bool())
  val irq_out     = Output(Bool())
  val rawirq_out  = Output(Bool())

  // inputs for homing switches
  val x_homed     = Input(Bool())
  val y_homed     = Input(Bool())
}

class PWM extends Module {

  // IO module
  val io = IO(new PWM_IO)

  // Timer internal registers and their initialization
  val value_cur       = RegInit(UInt(32.W), 0.U)
  val value_reload    = RegInit(UInt(32.W), 0x0FF.U)
  val pwm_duty        = RegInit(UInt(32.W), 0.U)
  val reg_duty        = RegInit(UInt(32.W), 0.U)

  val value_cur_plus  = Wire(UInt(32.W))  // Next value, on up-count
  val value_cur_minus = Wire(UInt(32.W))  // Next value, on down-count

  val loc_enable      = Wire(Bool())
  val enable          = RegInit(Bool(), false.B) // Enable (start) the counter/timer

  val stop_out        = RegInit(Bool(), false.B)
  val irq_out         = RegInit(Bool(), false.B)

  // Previous state of enable (catch rising/falling edge)
  val lastenable      = Reg( Bool())

  // Count up / down (1/0)
  val updown          = RegInit(Bool(), false.B)

  // Enable interrupt on timeout
  val irq_ena         = RegInit(Bool(), false.B)

  // Enable PID output to drive timer duty cycle
  val pid_out_sel     = RegInit(Bool(), false.B)

  // PWM deadband configuration bit field
  val pwm_db          = RegInit(UInt(4.W), 2.U)

  // outputs for stepper motor, set and reset by software
  val step1step       = RegInit(Bool(), true.B)
  val step1dir        = RegInit(Bool(), true.B)
  val step2step       = RegInit(Bool(), true.B)
  val step2dir        = RegInit(Bool(), true.B)

  // PWM implementation and duty_cycle register read/write
  io.reg_duty_do      := pwm_duty
  when(io.reg_duty_we) {
    reg_duty := io.reg_duty_di
  }

  io.reg_step_do      := Cat(0.U(26.W), step1step, step1dir, step2step, step2dir, io.x_homed, io.y_homed)
  when(io.reg_step_we) {
    step1step         := io.reg_cfg_di(5)
    step1dir          := io.reg_cfg_di(4)
    step2step         := io.reg_cfg_di(3)
    step2dir          := io.reg_cfg_di(2)
  }

  when(stop_out) {
    when(pid_out_sel){
      pwm_duty := io.reg_pid_out.asUInt()
    }.otherwise{
      pwm_duty := reg_duty
    }
  }

  val proc_offset = Reg(UInt(32.W))
  val pwm_ld      = Reg(Bool())
  val pwm_hd      = Reg(Bool())

  // Limit the offset internally to keep the deadband from being over written
  val pwm_db_twice = (pwm_db << 1.U).asUInt()

  proc_offset      := Mux((pwm_duty >= pwm_db_twice) && (pwm_duty <= (value_reload - pwm_db_twice)), pwm_duty,
                      Mux(pwm_duty < pwm_db_twice, pwm_db_twice, (value_reload - pwm_db_twice)))
  pwm_hd           := value_cur < (proc_offset - pwm_db)
  pwm_ld           := (value_cur > proc_offset) && (value_cur < (value_reload - pwm_db))
  io.pwm_h         := pwm_hd & enable
  io.pwm_l         := pwm_ld & enable

  // Interrupt generation
  io.irq_out       := irq_out
  io.rawirq_out    := stop_out & ~irq_out

  // Configuration register
  io.reg_cfg_do    := Cat(0.U(24.W), pwm_db(3,0), pid_out_sel, irq_ena, updown, enable)
  when(io.reg_cfg_we) {
    enable        := io.reg_cfg_di(0)
    updown        := io.reg_cfg_di(1)
    irq_ena       := io.reg_cfg_di(2)
    pid_out_sel   := io.reg_cfg_di(3)
    pwm_db        := (io.reg_cfg_di(7,4) + 2.U)
  }

// Counter/timer reset value register
  io.reg_val_do   := value_reload
  when(io.reg_val_we.orR()) {
    value_reload  := io.reg_val_di
  }

  // Counter/timer current value register and timer implementation
  io.reg_dat_do   := value_cur
  value_cur_plus  := value_cur.asUInt + 1.U
  value_cur_minus := value_cur.asUInt - 1.U
  loc_enable      :=  enable

// Timer count register up-dation and IRQ generation
  lastenable      := loc_enable
  when(io.reg_dat_we.orR()) {
      value_cur   := io.reg_dat_di
  } .elsewhen (loc_enable === true.B) {
    // IRQ signals one cycle after stop_out, if IRQ is enabled
    // IRQ lasts for one clock cycle only.
      irq_out   := Mux((irq_ena), (stop_out & ~irq_out), "b0".U(1.W))

      when(updown === true.B) {
        when(lastenable === false.B) {
          value_cur := 0.U(32.W)
          stop_out  := false.B
        } .otherwise { // count up
          // 32-bit counter behavior
          when(value_cur.asUInt === value_reload.asUInt) {
            value_cur := 0.U(32.W)
            stop_out  := true.B
          } .otherwise {
            value_cur := value_cur_plus
            stop_out  := false.B
          }
        }
      } .otherwise { // count down

        when(lastenable === false.B) {
          value_cur   := value_reload
          stop_out    := false.B
        } .otherwise { // count down
            // 32-bit counter countdown behavior
            when(value_cur.asUInt === 0.U(32.W)) {
              value_cur := value_reload
              stop_out  := true.B
            }.otherwise {
              value_cur := value_cur_minus
              stop_out  := false.B
            }
        }
      }
    }
}

