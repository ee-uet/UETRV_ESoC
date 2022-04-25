/*********************************************************************
 * Filename :    uart.scala
 * Date     :    20-03-2021
 * Author   :    Muhammad Tahir
 *
 * Description:  Uart top module with configurable baud rate using
 *               buad register.
 *********************************************************************/

package uart

import chisel3._
import chisel3.util._
import wishbone.{WB_InterConnect, WishboneSlaveIO}

trait UART_Config {
  val dataBits     = 8
  val stopBits     = 2
  val divisorBits  = 10
  val oversample   = 2
  val nSamples     = 3
  val nTxEntries   = 4
  val nRxEntries   = 4

  def oversampleFactor = 1 << oversample
  require(divisorBits > oversample)
  require(oversampleFactor > nSamples)
}

class UartIO extends Bundle {
  val uart_select = Input(Bool())
  val txd         = Output(Bool())
  val rxd         = Input(Bool())
  val uartInt     = Output(Bool())

  // Include UART bus interface for Wishbone
  val wbs         = new WishboneSlaveIO
}

object UART {
  val UART_RXDATA_R   = 0x0.U
  val UART_TXDATA_R   = 0x1.U
  val UART_BAUD_R     = 0x2.U
  val UART_CONTROL_R  = 0x3.U
  val UART_STATUS_R   = 0x4.U
  val UART_INT_MASK_R = 0x5.U
}

class UART extends Module with UART_Config { // (implicit p: Parameters)
  val io = IO(new UartIO)

  //  Instantiation for transmit and receive modules
  val txm = Module(new UARTTx)
  val rxm = Module(new UARTRx)

  // register definitions for IO and internal use
  val txen       = RegInit(Bool(), false.B)
  val rxen       = RegInit(Bool(), false.B)

  val tx_data_r  = RegInit(0x4A.U(dataBits.W))
  val rx_data_r  = RegInit(0x0.U(dataBits.W))
  val control_r  = RegInit(0x0.U(dataBits.W))
  val baud_r     = RegInit(0x8.U(divisorBits.W))
  val status_r   = RegInit(0x0.U(dataBits.W))
  val int_mask_r = RegInit(0x1.U(dataBits.W))

  val div        = baud_r // 8.U(c.divisorBits.W)

  private val stopCountBits = log2Up(stopBits)
  val nstop      = RegInit(0.U(stopCountBits.W))

  // wiring of sub-modules and IOs
  txen            := false.B
  txm.io.in.valid :=  txen
  txm.io.in.bits  := (tx_data_r)
  txm.io.div      := div
  txm.io.nstop    := nstop
  rxm.io.div      := div

  // IO wiring for Tx/Rx lines
  rxm.io.in       := io.rxd
  io.txd          := txm.io.out

  // Interface to Wishbone bus
  val addr        = io.wbs.m2s.addr(7, 0)
  val rd_en       = !io.wbs.m2s.we && io.wbs.m2s.stb
  val wr_en       = io.wbs.m2s.we && io.wbs.m2s.stb
  val st_type     = io.wbs.m2s.sel

  // Register address decoding signals
  val sel_reg_rx       = (addr === UART.UART_RXDATA_R) && io.uart_select
  val sel_reg_tx       = (addr === UART.UART_TXDATA_R) && io.uart_select
  val sel_reg_baud     = (addr === UART.UART_BAUD_R) && io.uart_select
  val sel_reg_control  = (addr === UART.UART_CONTROL_R) && io.uart_select
  val sel_reg_status   = (addr === UART.UART_STATUS_R) && io.uart_select
  val sel_reg_int_mask = (addr === UART.UART_INT_MASK_R) && io.uart_select

  // Wishbone handshake signals
  val ack         = RegInit(Bool(), false.B)
  io.wbs.ack_o    := ack
  ack             := io.wbs.m2s.stb & io.wbs.m2s.cyc

  // Reading specific UART register on Wishbone bus
  val rd_data     = RegInit(0.U(8.W))
  
  when(rd_en && sel_reg_control){
    rd_data   := control_r
  }.elsewhen(rd_en && sel_reg_baud){
    rd_data   := baud_r
  }.elsewhen(rd_en && sel_reg_status){
      rd_data := status_r
  }.elsewhen(rd_en && sel_reg_rx){
    rd_data   := rx_data_r
  }otherwise {
    rd_data   := 0.U
  }
  io.wbs.data_o  := rd_data

  // UART interrupt generation
  io.uartInt     := (status_r & int_mask_r).orR

  // UART register write operation on Wishbone bus
  when(wr_en) {
    when(sel_reg_tx) {
      tx_data_r  := io.wbs.m2s.data(7, 0)
      txen       := true.B
    }
    .elsewhen(sel_reg_baud) {
      baud_r     := io.wbs.m2s.data(7, 0)
    }
    .elsewhen(sel_reg_control){
      control_r  := io.wbs.m2s.data(7, 0)
    }
    .elsewhen(sel_reg_int_mask){
      int_mask_r := io.wbs.m2s.data(7, 0)
    }
  }

  // Updating UART status register due to Tx/Rx activity
  when(rxm.io.out.valid){
    rx_data_r    :=  (rxm.io.out.bits)
    status_r     := Cat(status_r(7,1), true.B)  // Registering UART Rx interrupt
  }.elsewhen(wr_en && sel_reg_status){
    status_r     := io.wbs.m2s.data(7, 0)
  }.otherwise{
    status_r     := Cat(status_r(7,2), txm.io.in.ready, status_r(0))   // Registering UART Tx interrupt
  }
}

// Instantiation of the UART module for Verilog generator
object Uart_generate extends App {
  chisel3.Driver.execute(args, () => new UART)
}
