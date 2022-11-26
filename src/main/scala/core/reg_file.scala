/*********************************************************************
 * Filename :    reg_file.scala
 * Date     :    28-03-2020
 *
 * Description:  Uses asynchronous reads to implement single cycle
 *               decode and execute.
 *********************************************************************/


package UETRV_ECore

import chisel3._
import chisel3.util.experimental.loadMemoryFromFile


class Reg_FileIO  extends Bundle with Config {
  val raddr_1 = Input(UInt(5.W))
  val raddr_2 = Input(UInt(5.W))
  val rdata_1 = Output(UInt(XLEN.W))
  val rdata_2 = Output(UInt(XLEN.W))
  val wen    = Input(Bool())
  val waddr  = Input(UInt(5.W))
  val wdata  = Input(UInt(XLEN.W))
}

class RegFile extends Module with Config {
  val io = IO(new Reg_FileIO)

  // Register file uses asynchronous reads, allowing single cycle
  // decode and execute implementation
  val regs = Mem(REGFILE_LEN, UInt(XLEN.W))

//  when(reset.asBool) {
//    for (i <- 0 to (REGFILE_LEN - 1)) {
//      regs(i) := 0.U(XLEN.W)
//    }
//  }

  io.rdata_1 := Mux((io.raddr_1.orR), regs(io.raddr_1), 0.U)
  io.rdata_2 := Mux((io.raddr_2.orR), regs(io.raddr_2), 0.U)

  when(io.wen & io.waddr.orR) {
    regs(io.waddr) := io.wdata
  }
}

