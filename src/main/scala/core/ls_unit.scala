/*********************************************************************
* Filename :    ls_unit.scala
* Date     :    20-03-2021
* Author   :    Muhammad Tahir
*
* Description:  Load-store unit for data memory interface.
*
* 13-04-2020    Supports supports byte/half-word/word size accesses.
*********************************************************************/


package UETRV_ECore

import chisel3._
import chisel3.util._
import UETRV_ECore.CONSTANTS._


class LSU_IO extends Bundle with Config {
  val lsu_st_type   = Input(UInt(STORE_SIZE_SIG_LEN.W))
  val lsu_wdata_in  = Input(UInt(WLEN.W))
  val lsu_wdata_out = Output(UInt(WLEN.W))
  val lsu_rdata_in  = Input(UInt(WLEN.W))
  val lsu_rdata_out = Output(SInt(WLEN.W))
  val lsu_ld_type   = Input(UInt(LOAD_TYPE_SIG_LEN.W))
}

class LS_Unit extends Module with Config {
  val io = IO(new LSU_IO)

  // Data stored to memory
  io.lsu_wdata_out := MuxLookup(io.lsu_st_type, 0.U , Seq(
      ST_SW -> io.lsu_wdata_in ,
      ST_SH -> io.lsu_wdata_in(15, 0) ,
      ST_SB -> io.lsu_wdata_in(7, 0) )).asUInt

  // Data loaded from memory
  val load_raw_data  = io.lsu_rdata_in
  io.lsu_rdata_out  := MuxLookup(io.lsu_ld_type, 0.S, Seq(
    LD_LW  -> load_raw_data.zext,
    LD_LH  -> load_raw_data(15, 0).asSInt,
    LD_LB  -> load_raw_data(7, 0).asSInt,
    LD_LHU -> load_raw_data(15, 0).zext,
    LD_LBU -> load_raw_data(7, 0).zext) )
}
