/*********************************************************************
 * Filename :    Core.scala
 * Date     :    28-03-2020
 * Author   :    Muhammad Tahir
 *
 * Description:  Processor core module implementation using simple
 *               memory interfaces.
*********************************************************************/

package UETRV_ECore

import chisel3._
import chisel3.util.Valid

class IrqIO extends Bundle {
  val uart_irq    = Input(Bool())
  val spi_irq     = Input(Bool())
  val m1_irq      = Input(Bool())
  val m2_irq      = Input(Bool())
  val m3_irq      = Input(Bool())
}


class DBusIO extends Bundle with Config {
  val addr        = Input(UInt(WLEN.W))
  val wdata       = Input(UInt(WLEN.W))
  val rdata       = Output(UInt(WLEN.W))
  val rd_en       = Input(UInt(MEM_READ_SIG_LEN.W))
  val wr_en       = Input(UInt(MEM_WRITE_SIG_LEN.W))
  val st_type     = Input(UInt(STORE_SIZE_SIG_LEN.W))
  val ld_type     = Input(UInt(LOAD_TYPE_SIG_LEN.W))
  val valid       = Output(Bool())
}

class IBusIO extends Bundle with Config {
  val addr        = Input(UInt(WLEN.W))
  val inst        = Output(UInt(WLEN.W))
  val valid       = Output(Bool())
}

class DebugIO extends Bundle with Config {
  val inst      = Output(UInt(XLEN.W))
  val reg_waddr = Output(UInt(5.W))
  val reg_wdata = Output(UInt(XLEN.W))
  val pc        = Output(UInt(XLEN.W))
}


class CoreIO extends Bundle {
 // val debug     = new DebugIO
  val irq       = new IrqIO
  val ibus      = Flipped((new IBusIO))
  val dbus      = Flipped((new DBusIO))
}

class Core extends Module {
  val io        = IO(new CoreIO)
  val dpath     = Module(new Datapath)
  val ctrl      = Module(new Control)

// Wiring of different modules
 // io.debug      <> dpath.io.debug
  io.irq        <> dpath.io.irq
  dpath.io.ibus <> io.ibus
  dpath.io.dbus <> io.dbus
  dpath.io.ctrl <> ctrl.io

}


