/******************************************************************************
 * Filename :    wbm_dbus.scala
 * Date     :    20-05-2020
 * Author   :    Muhammad Tahir
 *
 * Description:  Wishbone shared bus interface standard (ver. B4) based
 *               implementation.
 *
 *
 * 21-05-2020    Current implementation supports only pipelined Read/Write
 *               operations.
 *******************************************************************************/

package wishbone

import chisel3._
import UETRV_ECore.{CONSTANTS, Config, DBusIO}


class WBM_DBus_IO extends Bundle {
  val dbus  = new DBusIO
  val wbm   = (new WishboneMasterIO)
}

class WBM_DBus extends Module with Config{
  val io = IO(new WBM_DBus_IO)

  // Wishbone selection output signal generation
  val store_type = io.dbus.st_type
  val st_sel_vec    = WireInit(0.U(WB_SEL_SIZE.W))

  // Generate the select vector for WB master sel output signal. Only store operation is managed here.
  // The load operation data size is handled by load/store unit (implemented as part of datapath) and
  // unaligned load leads to a fault due to CSR implementation
  when(store_type === CONSTANTS.ST_SW) {
      st_sel_vec := CONSTANTS.WB_WORD_SEL
    }
    .elsewhen(store_type === CONSTANTS.ST_SH) {
      st_sel_vec :=  CONSTANTS.WB_HW_LOW_SEL
    }
    .elsewhen(store_type === CONSTANTS.ST_SB){
      st_sel_vec := CONSTANTS.WB_BYTE0_SEL
    }

  // Wishbone Selection Output (sel_o) signal generation
  val ld_align = io.dbus.addr(1, 0)
  val ld_type = io.dbus.ld_type
  val ld_sel_vec = WireInit(0.U(WB_SEL_SIZE.W))

  // generate the sel_o signal
  when(ld_type === CONSTANTS.LD_LW) {
    ld_sel_vec := CONSTANTS.WB_WORD_SEL
  }
    .elsewhen(ld_type === CONSTANTS.LD_LH || ld_type === CONSTANTS.LD_LHU) {
      ld_sel_vec := Mux (ld_align(1), CONSTANTS.WB_HW_HIGH_SEL, CONSTANTS.WB_HW_LOW_SEL)
    }
    .elsewhen(ld_type === CONSTANTS.LD_LB || ld_type === CONSTANTS.LD_LBU){
      when(ld_align === 0x3.U) {
        ld_sel_vec := CONSTANTS.WB_BYTE3_SEL
      }.elsewhen(ld_align === 0x2.U){
        ld_sel_vec := CONSTANTS.WB_BYTE2_SEL
      }.elsewhen(ld_align === 0x1.U){
        ld_sel_vec := CONSTANTS.WB_BYTE1_SEL
      }otherwise {
        ld_sel_vec := CONSTANTS.WB_BYTE0_SEL
      }
    }


  // Connections between system data bus (DBus) and WB master (WBM)
  io.wbm.m2s.addr := io.dbus.addr(BUSW-1, 0)
  io.wbm.m2s.data := io.dbus.wdata
  io.wbm.m2s.we   := io.dbus.wr_en
  io.wbm.m2s.sel  := Mux(store_type.orR, st_sel_vec, ld_sel_vec)
  io.wbm.m2s.stb  := io.dbus.rd_en.asBool || io.dbus.wr_en.asBool
  io.wbm.m2s.cyc  := true.B

  io.dbus.rdata   := io.wbm.data_i
  io.dbus.valid   := io.wbm.ack_i
}

