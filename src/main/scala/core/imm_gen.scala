/********************************************************************
 * Filename :    imm_gen.scala
 * Date     :    28-03-2020
 *
 * Description:  Implements immediate value generation.
*********************************************************************/


package UETRV_ECore

import chisel3._
import chisel3.util._

import CONSTANTS._

class ImmIO extends Bundle with Config {
  val inst    = Input(UInt(XLEN.W))
  val imm_sel = Input(UInt(3.W))
  val imm_out = Output(UInt(XLEN.W))
}

class Imm extends Module with Config {
  val io = IO(new ImmIO)

  val sign_val = Mux(io.imm_sel === IMM_Z, 0.S, io.inst(31).asSInt)
  val imm30_20 = Mux(io.imm_sel === IMM_U, io.inst(30,20).asSInt, sign_val)
  val imm19_12 = Mux(io.imm_sel =/= IMM_U && io.imm_sel =/= IMM_J, sign_val, io.inst(19,12).asSInt)
  val imm11    = Mux(io.imm_sel === IMM_U || io.imm_sel === IMM_Z, 0.S,
                   Mux(io.imm_sel === IMM_J, io.inst(20).asSInt,
                     Mux(io.imm_sel === IMM_B, io.inst(7).asSInt, sign_val)))
  val imm10_5  = Mux(io.imm_sel === IMM_U || io.imm_sel === IMM_Z, 0.U, io.inst(30,25))
  val imm4_1   = Mux(io.imm_sel === IMM_U, 0.U,
                   Mux(io.imm_sel === IMM_S || io.imm_sel === IMM_B, io.inst(11,8),
                     Mux(io.imm_sel === IMM_Z, io.inst(19,16), io.inst(24,21))))
  val imm0     = Mux(io.imm_sel === IMM_S, io.inst(7),
                   Mux(io.imm_sel === IMM_I, io.inst(20),
                    Mux(io.imm_sel === IMM_Z, io.inst(15), 0.U)))

  io.imm_out := Cat(sign_val, imm30_20, imm19_12, imm11, imm10_5, imm4_1, imm0).asSInt.asUInt
}

