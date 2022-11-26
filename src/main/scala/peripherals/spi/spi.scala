/*********************************************************************
 * Filename :    spi.scala
 * Date     :    20-12-2021
 * Author   :    Muhammad Tahir
 *
 * Description:  Spi top module with configurable clock rate.
 *
 *********************************************************************/


package spi

import chisel3._
// import sv2chisel.helpers.vecconvert._
import chisel3.util.Cat
import wishbone.{WB_InterConnect, WishboneSlaveIO}

trait SPI_Config {

  val SHIFT_DIRECTION = 0
  val CLOCK_PHASE = 0
  val CLOCK_POLARITY = 0
  val CLOCK_SEL = 3 //  SCLK = CLK_I / (2 * (CLOCK_SEL + 1)) = CLK_I / 4
  val SLAVE_NUMBER = 1 //  maximum value = 8 for current design
  val DATA_LENGTH = 8 //  changed from 32 to 8
  val DELAY_TIME = 2
  val CLKCNT_WIDTH = 5
  val INTERVAL_LENGTH = 2
  }

class SpiIO extends Bundle {
  val spi_select = Input(Bool())
  // SPI IO lines
  val spi_cs     = Output(Bool())
  val spi_clk    = Output(Bool())
  val spi_mosi   = Output(Bool())
  val spi_miso   = Input(Bool())
  val spi_intr   = Output(Bool())

  // Include UART bus interface for Wishbone
  val wbs         = new WishboneSlaveIO
}

object SPI {
  val SPI_RXDATA_R   = 0x0.U
  val SPI_TXDATA_R   = 0x1.U
  val SPI_BAUD_R     = 0x2.U
  val SPI_CONTROL_R  = 0x3.U
  val SPI_STATUS_R   = 0x4.U
  val SPI_SS_MASK_R  = 0x5.U
}

class SPI extends Module with SPI_Config { // (implicit p: Parameters)
  val io = IO(new SpiIO)

  /* synthesis syn_keep=1 opt="keep"*/ /* synthesis syn_keep=1 opt="keep"*/ /* synthesis syn_keep=1 opt="keep"*/
  val ST_IDLE: UInt = "b000".U(3.W)
  val ST_LOAD: UInt = "b001".U(3.W)
  val ST_WAIT: UInt = "b010".U(3.W)
  val ST_TRANS: UInt = "b011".U(3.W)
  val ST_TURNAROUND: UInt = "b100".U(3.W)
  val ST_INTERVAL: UInt = "b101".U(3.W)

   // Register definitions
  val ack_o    = RegInit(Bool(), false.B)
  val rd_data  = RegInit(0.U(DATA_LENGTH.W))

  val cs_r   = RegInit(Bool(), true.B)  // SS_N_MASTER
  val sclk_r = RegInit(Bool(), false.B)  // SCLK_MASTER
  val mosi_r = RegInit(Bool(), false.B)  // MOSI_MASTER
  val miso_r = WireInit(Bool(), false.B)  // MISO_SLAVE

  val wr_en = WireInit(Bool(), false.B)
  val rd_en = WireInit(Bool(), false.B)
  val read_wait_done = RegInit(Bool(), false.B)
  val latch_s_data = WireInit(0.U(DATA_LENGTH.W))  //8 bit width - changed from 32 bits

  val reg_rxdata  = RegInit(0.U(DATA_LENGTH.W))
  val reg_txdata  = RegInit(0x35.U(DATA_LENGTH.W))
  val reg_ssmask  = RegInit(Bool(), false.B)

  val rx_shift_data = RegInit(0.U(DATA_LENGTH.W))
  val tx_shift_data = RegInit(0.U(DATA_LENGTH.W))
  val rx_latch_flag = RegInit(Bool(), false.B)

  // Control register bits
  val bit_iroe   = RegInit(Bool(), false.B)
  val bit_itoe   = RegInit(Bool(), false.B)
  val bit_itrdy  = RegInit(Bool(), false.B)
  val bit_irrdy  = RegInit(Bool(), false.B)
  val bit_ie     = RegInit(Bool(), false.B)
  val bit_sso    = RegInit(Bool(), true.B)    // MT enabled on reset

  // Status register bits
  val bit_toe    = RegInit(Bool(), false.B)
  val bit_roe    = RegInit(Bool(), false.B)
  val bit_trdy   = RegInit(Bool(), true.B)
  val bit_rrdy   = RegInit(Bool(), false.B)
  val bit_tmt    = RegInit(Bool(), true.B)
  val bit_e      = RegInit(Bool(), false.B)

  // Interface to Wishbone bus
  val stb_i    = io.wbs.m2s.stb
  val cyc_i    = io.wbs.m2s.cyc
  val we_i     = io.wbs.m2s.we
  val addr     = io.wbs.m2s.addr(7, 0)
  val st_type  = io.wbs.m2s.sel
  rd_en        := !io.wbs.m2s.we && io.wbs.m2s.stb && io.wbs.m2s.cyc
  wr_en        := io.wbs.m2s.we && io.wbs.m2s.stb && io.wbs.m2s.cyc
  latch_s_data := io.wbs.m2s.data

  // Register address decoding signals
  val sel_reg_rx       = (addr === SPI.SPI_RXDATA_R) && io.spi_select
  val sel_reg_tx       = (addr === SPI.SPI_TXDATA_R) && io.spi_select
  val sel_reg_baud     = (addr === SPI.SPI_BAUD_R) && io.spi_select
  val sel_reg_control  = (addr === SPI.SPI_CONTROL_R) && io.spi_select
  val sel_reg_status   = (addr === SPI.SPI_STATUS_R) && io.spi_select
  val sel_reg_ssmask   = (addr === SPI.SPI_SS_MASK_R) && io.spi_select

  // Receive data register update
 when (rx_latch_flag) {
    reg_rxdata := rx_shift_data
  }

 // Transmit data register update
 when (wr_en && sel_reg_tx && bit_trdy) {
    reg_txdata := latch_s_data
  }

 // Status register definition
 bit_e := bit_toe | bit_roe
 val reg_status = Cat(bit_e, bit_rrdy, bit_trdy, bit_tmt, bit_toe, bit_roe, "b00".U(2.W))

 // Control register definition
 val reg_control = Cat(bit_sso, "b0".U(1.W), bit_ie, bit_irrdy, bit_itrdy, "b0".U(1.W), bit_itoe, bit_iroe)

 //Control Register(0x0C)	// reduced control register length to 8 bits - deleted 3 bits padding at end
 when (wr_en && sel_reg_control) {
    bit_iroe  := latch_s_data(0)
    bit_itoe  := latch_s_data(1)
    bit_itrdy := latch_s_data(3)
    bit_irrdy := latch_s_data(4)
    bit_ie    := latch_s_data(5)
    bit_sso   := latch_s_data(7)
 }

 io.spi_intr := (bit_ie & (bit_iroe & bit_roe | bit_itoe & bit_toe)) | (bit_itrdy & bit_trdy) | (bit_irrdy &  bit_rrdy)

 //For Write, ACK is asserted right after STB is sampled
 //For Read, ACK is asserted one clock later after STB is sampled for better timing

 when (ack_o) {
   ack_o := false.B
 } .elsewhen (stb_i && cyc_i && (we_i || read_wait_done)) {
   ack_o := true.B
 }
 io.wbs.ack_o := ack_o

 when (ack_o) {
   read_wait_done := false.B
 } .elsewhen (stb_i && cyc_i &&  (~we_i)) {
    read_wait_done := true.B
  }

  // Internal registers
    val clock_cnt    = RegInit(0.U(CLKCNT_WIDTH.W))
    val data_cnt     = RegInit(0.U(6.W))
    val pending_data = RegInit(Bool(), false.B)
    val c_status     = WireInit(ST_IDLE)
    val n_status     = RegInit(ST_IDLE)
    val p_status     = RegInit(ST_IDLE)

    when (wr_en && sel_reg_tx) {
      pending_data := true.B
    } .elsewhen (c_status === ST_LOAD) {
      pending_data := false.B
    }

    when (rd_en) {
      rd_data := Mux(sel_reg_rx, reg_rxdata, Mux(sel_reg_tx, reg_txdata.asTypeOf(UInt(8.W)),
        Mux(sel_reg_status, reg_status, Mux(sel_reg_control, reg_control, Mux(sel_reg_ssmask, reg_ssmask, "h0".U(8.W))))))
    }
   io.wbs.data_o := rd_data // MT added for IO connectivity

   when (wr_en && sel_reg_ssmask) {
      reg_ssmask := latch_s_data(0)
    }

/*
    when (bit_sso) {
      cs_r := ( ~reg_ssmask)
    } .elsewhen ((c_status === ST_TRANS) || (c_status === ST_WAIT) || (c_status === ST_TURNAROUND)) {
      cs_r := ( ~reg_ssmask)
    } .otherwise {
      cs_r := true.B
    }
*/
  io.spi_cs := ~reg_ssmask    // MT simplified Chip select implementation commented the above part

  // Generate SCLK
    when ((c_status === ST_TRANS) && (clock_cnt === CLOCK_SEL.U)) {
      sclk_r :=  ~sclk_r
    }
    io.spi_clk := sclk_r

    miso_r := io.spi_miso

    when ((clock_cnt === CLOCK_SEL.U) && ((CLOCK_PHASE.U) === sclk_r) && (c_status === ST_TRANS)) {
      when((SHIFT_DIRECTION != 0).B) {
        rx_shift_data := Cat(miso_r, rx_shift_data(DATA_LENGTH-1,1))
      } .otherwise {
        rx_shift_data := Cat(rx_shift_data, miso_r)
      }
    }

   // Control signal after data is received
   when ((p_status === ST_TRANS) && (n_status =/= ST_TRANS)) {
      rx_latch_flag := true.B
    } .elsewhen (rx_latch_flag) {
      rx_latch_flag := false.B
    }

   when (clock_cnt === CLOCK_SEL.U || (n_status === ST_IDLE)) {
      clock_cnt := 0.U
    } .otherwise {
      clock_cnt := clock_cnt + 1.U
    }

   c_status := n_status
   p_status := n_status

  val ACTUAL_MAX = WireInit( Mux((CLOCK_POLARITY.U === CLOCK_PHASE.U), (DATA_LENGTH-1).U(6.W), DATA_LENGTH.U(6.W)))

   when (c_status === ST_IDLE) {
      when(pending_data) {
        n_status := ST_LOAD
      } .otherwise {
        n_status := ST_IDLE
      }
    } .elsewhen (c_status === ST_LOAD) {
      when(DELAY_TIME.U === 0.U) {
        n_status := ST_TRANS
      } .otherwise {
        n_status := ST_WAIT
      }
    } .elsewhen (c_status === ST_WAIT) {
      when((clock_cnt === CLOCK_SEL.U) && (data_cnt === (DELAY_TIME-1).U)) {
        n_status := ST_TRANS
      } .otherwise {
        n_status := ST_WAIT
      }
    } .elsewhen (c_status === ST_TRANS) {
      when((clock_cnt === CLOCK_SEL.U) && (data_cnt === ACTUAL_MAX) && (sclk_r =/= (CLOCK_POLARITY.U))) {
        n_status := ST_TURNAROUND
      } .otherwise {
        n_status := ST_TRANS
      }
    } .elsewhen (c_status === ST_TURNAROUND) {
      when(clock_cnt === CLOCK_SEL.U) {
        when((INTERVAL_LENGTH != 0).B) {
          n_status := ST_INTERVAL
        } .otherwise {
          n_status := ST_IDLE
        }
      }
    } .elsewhen (c_status === ST_INTERVAL) {
      when((clock_cnt === CLOCK_SEL.U) && (data_cnt === INTERVAL_LENGTH.U)) {
        n_status := ST_IDLE
      } .otherwise {
        n_status := ST_INTERVAL
      }
    } .otherwise {
      n_status := ST_IDLE
    }

  when ((c_status === ST_WAIT) && (clock_cnt === CLOCK_SEL.U) && (data_cnt === (DELAY_TIME-1).U)) {
      data_cnt := 0.U
    } .elsewhen ((c_status === ST_TRANS) && (clock_cnt === CLOCK_SEL.U) && (data_cnt === ACTUAL_MAX) && ((CLOCK_POLARITY.U) =/= sclk_r)) {
      data_cnt := 0.U
    } .elsewhen ((c_status === ST_INTERVAL) && (clock_cnt === CLOCK_SEL.U) && (data_cnt === INTERVAL_LENGTH.U)) {
      data_cnt := 0.U
    } .elsewhen (((c_status === ST_WAIT) && (clock_cnt === CLOCK_SEL.U)) || ((c_status === ST_TRANS) && (clock_cnt === CLOCK_SEL.U) && ((CLOCK_PHASE.U =/= 0.U) =/= sclk_r)) || ((c_status === ST_INTERVAL) && (clock_cnt === CLOCK_SEL.U))) {
      data_cnt := data_cnt + 1.U
    }

    val wait_one_tick_done = RegInit(Bool(), false.B)

    when (CLOCK_PHASE.U === CLOCK_POLARITY.U) {
      wait_one_tick_done := true.B
    } .elsewhen ((c_status === ST_TRANS) && (clock_cnt === CLOCK_SEL.U) && (data_cnt === 1.U)) {
      wait_one_tick_done := true.B
    } .elsewhen (data_cnt === 0.U) {
      wait_one_tick_done := false.B
    }

  // when (((c_status === ST_LOAD) && (n_status === ST_TRANS)) || ((c_status === ST_WAIT) && (n_status === ST_TRANS)))
    when ( (c_status === ST_WAIT) ) {
      mosi_r := Mux((SHIFT_DIRECTION != 0).B, reg_txdata(0), reg_txdata(DATA_LENGTH-1))
      tx_shift_data := Mux((SHIFT_DIRECTION != 0).B, Cat("b0".U(1.W), reg_txdata(DATA_LENGTH-1,1).asUInt), Cat(reg_txdata.asUInt, "b0".U(1.W)))
    } .elsewhen ((c_status === ST_TRANS) && (clock_cnt === CLOCK_SEL.U) && (((CLOCK_PHASE.U ^ sclk_r)) =/= 0.U)) {
      when(wait_one_tick_done) {
        mosi_r := Mux((SHIFT_DIRECTION != 0).B, tx_shift_data(0), tx_shift_data(DATA_LENGTH-1))
        tx_shift_data := Mux((SHIFT_DIRECTION != 0).B, Cat("b0".U(1.W), tx_shift_data(DATA_LENGTH-1,1).asUInt), Cat(tx_shift_data.asUInt, "b0".U(1.W)))
      }
    }
  io.spi_mosi := mosi_r

    when ((n_status === ST_TRANS)) {   // (c_status =/= ST_TRANS) &&
      bit_trdy := true.B
    } .elsewhen (wr_en && sel_reg_tx) {
      bit_trdy := false.B
    }

    when ( !bit_trdy && wr_en && sel_reg_tx) {
      bit_toe := true.B
    } .elsewhen (wr_en && sel_reg_status) {
      bit_toe := false.B
    }

    when ((c_status === ST_TURNAROUND) && (clock_cnt === CLOCK_SEL.U)) {
      when(bit_rrdy) {
        bit_roe := true.B
      } .otherwise {
        bit_rrdy := true.B
      }
    } .elsewhen (rd_en && sel_reg_rx) {
      bit_rrdy := false.B
      bit_roe := false.B
    }

    when ((c_status =/= ST_IDLE) || pending_data) {
      bit_tmt := false.B
    } .otherwise {
      bit_tmt := true.B
    }
}

