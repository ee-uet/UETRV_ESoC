/********************************************************************
 * Filename :    Branch.scala
 * Date     :    28-03-2020
 *
 * Description:  Implements branch condition checking and generates
 *               branch taken/not-taken signal.
*********************************************************************/

package UETRV_ECore

import chisel3._
import CONSTANTS._

class Branch_IO extends Bundle with Config {
  val in_a       = Input(UInt(XLEN.W))
  val in_b       = Input(UInt(XLEN.W))
  val br_type    = Input(UInt(3.W))
  val br_taken   = Output(Bool())
}

class Branch extends Module with Config {
  val io = IO(new Branch_IO)

  val difference      = io.in_a - io.in_b
  val not_equal       = difference.orR
  val equal           = !not_equal
  val is_same_sign    = io.in_a(XLEN-1) === io.in_b(XLEN-1)
  val less_than       = Mux(is_same_sign, difference(XLEN-1), io.in_a(XLEN-1))
  val less_than_u     = Mux(is_same_sign, difference(XLEN-1), io.in_b(XLEN-1))
  val greater_equal   = !less_than
  val greater_equal_u = !less_than_u

  // Determine whether the branch is taken or not
  io.br_taken :=
    ((io.br_type === BR_EQ)  && equal) ||
    ((io.br_type === BR_NE)  && not_equal) ||
    ((io.br_type === BR_LT)  && less_than) ||
    ((io.br_type === BR_GE)  && greater_equal) ||
    ((io.br_type === BR_LTU) && less_than_u) ||
    ((io.br_type === BR_GEU) && greater_equal_u)
}


