/*********************************************************************
 * Filename :    csr_defs.scala
 * Date     :    28-03-2020
 * Author   :    Muhammad Tahir
 *
 * Description:  CSR definitions for selected registers.
 *
 * 10-05-2020    Conforms to Privileged Spec. 1.11
*********************************************************************/


package UETRV_ECore

import chisel3._
import chisel3.util._

// Machine status register bit field definitions
class MstatusCsr extends Bundle {
  val sd    = Bool()
  val wpri0 = UInt(6.W)
  val prv   = UInt(2.W)   // 'prv' field is not part of Priv. Spec. 1.11
  val tsr   = Bool()      // however its better to have it part of 'mstatus' register
  val tw    = Bool()      // rather a separate register for this purpose
  val tvm   = Bool()
  val mxr   = Bool()
  val sum   = Bool()
  val mprv  = Bool()
  val xs    = UInt(2.W)
  val fs    = UInt(2.W)
  val mpp   = UInt(2.W)
  val wpri1 = UInt(2.W)
  val spp   = Bool()
  val mpie  = Bool()
  val wpri2 = Bool()
  val spie  = Bool()
  val upie  = Bool()
  val mie   = Bool()
  val wpri3 = Bool()
  val sie   = Bool()
  val uie   = Bool()
}

// Machine interrupt-enable register bit field definitions
class MieCsr extends Bundle {
  val wpri4 = UInt(11.W)
  val motor3ie = Bool()
  val motor2ie = Bool()
  val motor1ie = Bool()
  val spiie = Bool()
  val uartie = Bool()
  val wpri3 = UInt(4.W)
  val meie  = Bool()
  val wpri2 = Bool()
  val seie  = Bool()
  val ueie  = Bool()
  val mtie  = Bool()
  val wpri1 = Bool()
  val stie  = Bool()
  val utie  = Bool()
  val msie  = Bool()
  val wpri0 = Bool()
  val ssie  = Bool()
  val usie  = Bool()
}

// Machine interrupt-pending register bit field definitions
class MipCsr extends Bundle {
  val wpri4 = UInt(11.W)
  val motor1ip = Bool()
  val motor2ip = Bool()
  val motor3ip = Bool()
  val spiip = Bool()
  val uartip = Bool()
  val wpri3 = UInt(4.W)
  val meip  = Bool()
  val wpri2 = Bool()
  val seip  = Bool()
  val ueip  = Bool()
  val mtip  = Bool()
  val wpri1 = Bool()
  val stip  = Bool()
  val utip  = Bool()
  val msip  = Bool()
  val wpri0 = Bool()
  val ssip  = Bool()
  val usip  = Bool()
}


