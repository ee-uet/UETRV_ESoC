/*********************************************************************
 * Filename :    uart_tx.scala
 * Date     :    20-03-2021
 * Author   :    Muhammad Tahir
 *
 * Description:  Uart transmit module.
 *********************************************************************/

package uart

import chisel3._
import chisel3.util._


class UARTTx extends Module with UART_Config {
  val io = IO(new Bundle {
    val in    = Flipped(Decoupled(UInt((dataBits).W)))
    val out   = Output(Bool())
    val div   = Input(UInt((divisorBits).W))
    val nstop = Input(UInt((stopBits).W))
  })

  val prescaler = RegInit(UInt((divisorBits).W), 0.U)
  val pulse     = (prescaler === 0.U)

  private val n = dataBits + 1
  val counter   = RegInit(UInt((log2Floor(n + stopBits) + 1).W), 0.U)
  val shifter   = Reg(UInt(n.W))
  val out       = RegInit(Bool(), true.B)
  io.out        := out

  val busy      = (counter =/= 0.U)
  val state1    = io.in.valid && !busy
  val state2    = busy
  io.in.ready   := !busy

  when(state1) {
    shifter  := Cat(io.in.bits, false.B)
    counter  := Mux1H(
      (0 until stopBits).map(i => (io.nstop === i.U) -> (n+i+2).U)
    )
  }

  when(state2) {
    prescaler := Mux(pulse, (io.div - 1.U), prescaler - 1.U)

    when(pulse) {
      counter := counter - (1.U)
      shifter := Cat(true.B, shifter >> 1)
      out     := shifter(0)
    }
  }
}




