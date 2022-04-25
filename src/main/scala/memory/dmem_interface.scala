/*********************************************************************
* Filename :    DMem_Interface.scala
* Date     :    28-03-2020
* Author   :    Muhammad Tahir
*
* Description:  Data memory interface provides Synchronous
*               read/write accesses. The memory size can
*               be changed in Configurations.scala file.
*
* 13-04-2020    Supports variable length as well as unaligned
*               load and store operations.
*********************************************************************/


package memories

import chisel3._
import chisel3.util._
import wishbone.{WB_InterConnect, WishboneSlaveIO}
import UETRV_ECore.Control._
import UETRV_ECore.{CONSTANTS, Config}

object BUS {
  val MEM_RESP_NOTRDY = false.B
  val MEM_RESP_RDY    = true.B
}

class DMem_InterfaceIO extends Bundle{
  val wbs  = new WishboneSlaveIO
}

class DMem_Interface extends Module with Config {
  val io = IO(new DMem_InterfaceIO)

  val dmem = Module(new DMem)

  val dmem_addr_match  = io.wbs.m2s.addr(WB_DMEM_ADDR_HIGH, WB_DMEM_ADDR_LOW) === WB_InterConnect.DMEM
  val dmem_req         = io.wbs.m2s.stb
  val dmem_select      = io.wbs.m2s.stb && dmem_addr_match
  val rd_en            = !io.wbs.m2s.we && dmem_select

  dmem.io.dmem_addr   := io.wbs.m2s.addr(log2Ceil(DATA_MEM_LEN)-1, 0)
  dmem.io.dmem_wdata  := io.wbs.m2s.data
  dmem.io.wr_en       := io.wbs.m2s.we && dmem_select
  dmem.io.st_type     := io.wbs.m2s.sel

  // Ack generation for data memory request
  val ack2        = RegInit(Bool(), BUS.MEM_RESP_NOTRDY)
  val dmem_res_en = (ack2 === BUS.MEM_RESP_RDY) ^ dmem_req

  when(dmem_res_en) {
    ack2 := Mux(dmem_req, BUS.MEM_RESP_RDY, BUS.MEM_RESP_NOTRDY)
  }

  val ack         = RegInit(Bool(), BUS.MEM_RESP_NOTRDY)
  ack            := io.wbs.m2s.stb & io.wbs.m2s.cyc
  io.wbs.ack_o   := ack || ack2

  val rdata       = dmem.io.dmem_rdata
  val rd_resp     = Reg(Bool())
  rd_resp        := rd_en
  io.wbs.data_o  := Mux(rd_resp, rdata, 0.U)
}
