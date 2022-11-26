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
import UETRV_ECore.{CONSTANTS, Config, IBusIO, DebugIO}
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
  
  val inst_address = io.imem_addr >> 2

  // Memory write operation
  when (io.wr_en) {
    imem(inst_address) := io.imem_wdata
  }
  // Read data from IMEM
  io.imem_rdata := imem(inst_address)
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

  val granularityPowerOf2: Int = log2Ceil(WB_SEL_SIZE)

  // Data memory is synchronous read and synchronous write
  val dmem = SyncReadMem(DATA_MEM_LEN/WB_SEL_SIZE, Vec(WB_SEL_SIZE, UInt(BLEN.W)))

  val addr = io.dmem_addr >> granularityPowerOf2

  val mask_shift = io.dmem_addr(granularityPowerOf2 - 1, 0)
  val data_shift = mask_shift << (WB_SEL_SIZE - 1)

  val wmask = io.st_type.rotateLeft(mask_shift)
  val wmask_vec = Wire(Vec(WB_SEL_SIZE, Bool()))
  wmask_vec := VecInit((wmask & Fill(WB_SEL_SIZE, io.wr_en)).asBools)   // AND wr_en with all bits of wmask, and connect the result to wmask_vec

  val wdata = io.dmem_wdata.rotateLeft(data_shift)
  val wdata_vec = Wire(Vec(WB_SEL_SIZE, UInt(BLEN.W)))
  for (k <- 0 to WB_SEL_SIZE - 1) {
    wdata_vec(k) := wdata((k + 1)*BLEN - 1, k*BLEN)   // connect each byte of wdata with each byte of wdata_vec
  }

  when (io.wr_en) {
    dmem.write(addr, wdata_vec, wmask_vec)
  }

  val old_data_shift = Reg(UInt(data_shift.getWidth.W))
  old_data_shift := data_shift

  io.dmem_rdata := dmem(addr).asUInt.rotateRight(old_data_shift)
}
