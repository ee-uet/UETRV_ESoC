/*********************************************************************
 * Filename :    uart_rx.scala
 * Date     :    20-03-2021
 * Author   :    Muhammad Tahir
 *
 * Description:  Uart receiver module.
 *********************************************************************/

package uart

import chisel3._
import chisel3.util._

class UARTRx extends Module with UART_Config {
  val io = IO(new Bundle {
    val in  = Input(Bool())
    val out = Valid(Bits(dataBits.W))
    val div = Input(UInt(divisorBits.W))
  })

  // Bit counter for incoming bits
  private val dataCountBits = log2Floor(dataBits) + 1
  val data_count            = Reg(UInt(dataCountBits.W))
  val data_last             = (data_count === (0.U))

  // Use baud divisor to divide the clock and generate pulses as bit sampling points
  val prescaler             = RegInit(0.U(divisorBits.W))
  val pulse                 = (prescaler === (0.U))
  val prescaler_next        = Mux(pulse, (io.div - 1.U), prescaler - 1.U)

  // Creating the mid point of the start bit and also achieving debouncing
  val debounce              = RegInit(0.U((divisorBits - 1).W))
  val debounce_max          = (debounce === (io.div/2.U))

  // Shift register for collecting the incoming bits. Acts as a serial to parallel converter
  val shifter    = RegInit(0x0.U(dataBits.W))
  val valid      = Reg(Bool())
  valid          := false.B
  io.out.valid   := valid
  io.out.bits    := shifter

  // States for the state machine
  val (s_idle :: s_data :: Nil) = Enum(2)
  val state      = RegInit(s_idle)

  switch (state) {
    is (s_idle) {
      when (!io.in) {
        // create midpoint for the start bit
        debounce := debounce + (1.U)
        when (debounce_max) {
          state      := s_data
          data_count := (dataBits).U
          prescaler  := prescaler_next
        }
      }
    }

    is (s_data) {
      prescaler := prescaler_next
      when (pulse) {
        data_count := data_count - 1.U
        // Check if it is the last data bit
        when (data_last) {
            state    := s_idle
            valid    := (true.B)
            debounce := (0.U)
        } .otherwise {
           // sample the incoming bits
            shifter  := Cat(io.in, shifter >> 1)
        }
      }
    }
  }
}

