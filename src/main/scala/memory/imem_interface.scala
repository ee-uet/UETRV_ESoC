/*********************************************************************
* Filename :    IMem_Interface.scala
* Date     :    28-03-2020
* 
* Description:  Test instruction memory, 1024 Bytes, 32 Words, implemented 
*               using 'mem'. The memory size can be changed in 
*               Configurations.scala.
*
* 13-04-2020    Supports word (32-bit) sized accesses and
 *              word/halfword/byte sized reads, in case of constant
 *              data, are possible.
*
*********************************************************************/


package memories

import chisel3._
import chisel3.util.{Cat, is, log2Ceil, switch}
import UETRV_ECore.{CONSTANTS, Config, IBusIO}
import wishbone.WishboneSlaveIO
import chisel3.util.experimental.loadMemoryFromFile

object MEM_ADDR {
  // Address mapping for wishbone slaves
  val IMEM     = 0x0.U(4.W)
  val BMEM     = 0x7.U(4.W)
}


class IMem_InterfaceIO extends Bundle with Config {
  val ibus = (new IBusIO)
  // Wishbone slave interface for reading data from instruction memory
  val wbs  = new WishboneSlaveIO
}

class IMem_Interface extends Module with Config {
  val io = IO(new IMem_InterfaceIO)

  val imem = Module(new IMem)
  val bmem = Module(new BMem)

  // Dual bus interface for Instruction Memory.
  // One interface is instruction-memory bus (IBus) while other is Wishbone

  // Address generation from the interfaces
  val ibus_imem_addr      = io.ibus.addr(log2Ceil(INST_MEM_LEN)+1, 0)
  val ibus_bmem_addr      = io.ibus.addr(log2Ceil(BOOT_MEM_LEN)-1, 0)
  val wbs_imem_addr       = io.wbs.m2s.addr(log2Ceil(INST_MEM_LEN)+1, 0)

 // val ibus_bmem_sel  = io.ibus.addr(BMEM_ADDR_HIGH, BMEM_ADDR_LOW) === MEM_ADDR.BMEM

  // Define ack signal and wire WB interface
  val ack            = RegInit(true.B)
  val wb_select      = Reg(UInt(WB_SEL_SIZE.W))
  val wb_wdata       = io.wbs.m2s.data
  val wb_rd_en       = !io.wbs.m2s.we && io.wbs.m2s.stb
  val wb_wr_en       = io.wbs.m2s.we && io.wbs.m2s.stb
  val wb_st_type     = io.wbs.m2s.sel

  // Address decoding for IMEM during booting as well as when fetching data (constants)
 // val imem_wbs_read   =  imem_wbs_select && wb_rd_en
  val imem_wbs_addr_match = !(io.wbs.m2s.addr(WB_IMEM_ADDR_HIGH, WB_IMEM_ADDR_LOW).orR)
  val imem_wbs_write  =  imem_wbs_addr_match && wb_wr_en

 // !((wb_rd_en || wb_wr_en) && imem_wbs_select)

  // Generating valid signal for IMEM
  val imem_wbs_sel = WireInit(false.B)
  imem_wbs_sel    := ((wb_rd_en || wb_wr_en) && imem_wbs_addr_match) // !imem_wbs_read && !imem_wbs_write
  val imem_ibus_valid = RegInit(true.B)
  imem_ibus_valid := !imem_wbs_sel


  // Define local wire type data for internal wiring
  val rd_imem_const = WireInit(0.U(XLEN.W))
  val rd_imem_inst  = WireInit(0.U(XLEN.W))

  // Address Mux for selecting the source of transaction
  val imem_addr      = Mux(imem_wbs_sel, wbs_imem_addr, ibus_imem_addr)
  imem.io.imem_addr := imem_addr

  // Read data/instruction from memory
  val imem_read = imem.io.imem_rdata

  // Write application program to instruction memory (by bootloader)
  imem.io.imem_wdata := wb_wdata
  imem.io.wr_en := imem_wbs_write
  imem.io.st_type := wb_st_type
  
// DeMux to select between reading constants vs instructions
when(imem_ibus_valid) {
  rd_imem_inst := imem_read
} otherwise {
  rd_imem_const := imem_read
}

when (imem_wbs_sel){
  ack      := io.wbs.m2s.stb
}

// Use 'sel' to determine whether byte, half-word or word is addressed
val rconst_data = WireInit(0.U(XLEN.W))
wb_select      := io.wbs.m2s.sel

  when(wb_select === CONSTANTS.WB_BYTE0_SEL){
    rconst_data := rd_imem_const(7, 0).asUInt
  }.elsewhen(wb_select === CONSTANTS.WB_BYTE1_SEL) {
    rconst_data := rd_imem_const(15, 8).asUInt
  }.elsewhen(wb_select === CONSTANTS.WB_BYTE2_SEL) {
    rconst_data := rd_imem_const(23, 16).asUInt
  }.elsewhen(wb_select === CONSTANTS.WB_BYTE3_SEL) {
    rconst_data := rd_imem_const(31, 24).asUInt
  }.elsewhen(wb_select === CONSTANTS.WB_HW_LOW_SEL){
    rconst_data := rd_imem_const(15, 0).asUInt
  }.elsewhen(wb_select === CONSTANTS.WB_HW_HIGH_SEL) {
    rconst_data := rd_imem_const(31, 16).asUInt
  }otherwise {
    rconst_data := rd_imem_const(31, 0).asUInt
  }

  // Wishbone bus read constants from Instruction memory
  io.wbs.ack_o   := ack
  io.wbs.data_o  := rconst_data

  /******* Address decoding and instruction fetching from boot memory  *******/
  val bmem_ibus_sel  = RegInit(Bool(), false.B)
  bmem_ibus_sel  :=  io.ibus.addr(BMEM_ADDR_HIGH, BMEM_ADDR_LOW) === BMEM_BASE.U(4.W)

  bmem.io.bmem_addr := ibus_bmem_addr
 // imem.io.imem_addr := ibus_imem_addr

  // Read instruction from boot memory
  val rd_bmem_inst = bmem.io.bmem_rdata

  // Dedicated Inst bus read instructions
  io.ibus.inst    := Mux(bmem_ibus_sel, rd_bmem_inst, rd_imem_inst)
  io.ibus.valid   := Mux(bmem_ibus_sel, true.B, imem_ibus_valid)

}

