/*********************************************************************
 * Filename :    Memory.scala
 * Date     :    28-03-2020
 * Author   :    Muhammad Tahir
 *
 * Description:  Instruction and data memories. The memory
 *               sizes can be changed in Configurations.scala file.
 *********************************************************************/


package memories

import chisel3._
import chisel3.util._
import UETRV_ECore.{CONSTANTS, Config, IBusIO}
import wishbone.WishboneSlaveIO
import chisel3.util.experimental.loadMemoryFromFile

/*******   Instruction memory implementation    ******/
class IMem_IO extends Bundle with Config {
  val imem_addr   = Input(UInt(WLEN.W))
  val imem_rdata  = Output(UInt(WLEN.W))
  val imem_wdata  = Input(UInt(WLEN.W))
  val wr_en       = Input(Bool())
  val st_type     = Input(UInt(WB_SEL_SIZE.W))
}

class IMem extends Module with Config {
  val io = IO(new IMem_IO)

  // Instruction memory with word aligned reads
  val imem = SyncReadMem(INST_MEM_LEN, UInt(WLEN.W))

 // loadMemoryFromFile(imem , imem_init_file)

  // IMEM writing by the bootloader
  val addr  = io.imem_addr
  val wdata = io.imem_wdata
  val st_type = io.st_type

  // Memory write operation
  when (io.wr_en) {
    imem(io.imem_addr / 4.U) := wdata
  }
/*  when (io.wr_en) {
    when (st_type(0).toBool) {
      imem(addr) := wdata(7, 0)
    }
    when (st_type(1).toBool) {
      imem(addr + 1.U) := wdata(15, 8)
    }
    when (st_type(2).toBool) {
      imem(addr + 2.U) := wdata(23, 16)
    }
    when (st_type(3).toBool) {
      imem(addr + 3.U) := wdata(31, 24)
    }
  }
*/
  // Read data from IMEM
  io.imem_rdata := imem(io.imem_addr / 4.U)

}

/*******   Data memory implementation    ******/
class DMem_IO extends Bundle with Config {
  val dmem_addr   = Input(UInt(log2Ceil(DATA_MEM_LEN).W))
  val dmem_wdata  = Input(UInt(WLEN.W))
  val dmem_rdata  = Output(UInt(WLEN.W))
  val wr_en       = Input(Bool())
  val st_type     = Input(UInt(WB_SEL_SIZE.W))
}

class DMem extends Module with Config {
  val io = IO(new DMem_IO)

  // Data memory is synchronous read and synchronous write
  val dmem  = SyncReadMem(DATA_MEM_LEN, UInt(BLEN.W))

  val addr  = io.dmem_addr
  val wdata = io.dmem_wdata
  val st_type = io.st_type

  // Memory write operation
  when (io.wr_en) {
    when (st_type(0).toBool) {
      dmem(addr) := wdata(7, 0)
    }
    when (st_type(1).toBool) {
      dmem(addr + 1.U) := wdata(15, 8)
    }
    when (st_type(2).toBool) {
      dmem(addr + 2.U) := wdata(23, 16)
    }
    when (st_type(3).toBool) {
      dmem(addr + 3.U) := wdata(31, 24)
    }
  }

  // Read word size data from memory. Actual size will be managed by load/store unit
  val rdata = Wire(UInt(XLEN.W))
  rdata := Cat(dmem(addr + 3.U), dmem(addr + 2.U), dmem(addr + 1.U), dmem(addr))
  io.dmem_rdata := rdata
}
