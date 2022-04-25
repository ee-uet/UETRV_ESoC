/******************************************************************
* Filename:      SoC_Test.scala
* Date:          04-04-2020
* Author:        M Tahir
*
* Description:   This is a simple test based on Chisel3 iotesters  
*                using Treadle compiler.
*
* Issues:        
*                 
******************************************************************/

package UETRV_ECore

import chisel3._
import chisel3.iotesters
import chisel3.iotesters.{Driver, PeekPokeTester}

class TestCore(c: SoC_Tile)
      extends PeekPokeTester(c) {

  var spi_Tx = (peek(c.io.spi_mosi) == BigInt(1))
  poke(c.io.uart_rx, true.B)

  for (i <- 0 until 100) {
    step(1)
  }

  var index = 0

  for (i <- 0 until 1400) {
    spi_Tx = (peek(c.io.spi_mosi) == BigInt(1) )
    if (spi_Tx) {
      step(499)
      Drive_MISO(flash.im_arr(index)(3))  // Order reversed for little endianness
      step(68)
      Drive_MISO(flash.im_arr(index)(2))
      step(68)
      Drive_MISO(flash.im_arr(index)(1))
      step(68)
      Drive_MISO(flash.im_arr(index)(0))
      index = index + 1
    }

    else
    step(1)
  }

  def Drive_MISO(data: Int): Int ={
    var bdata = data

    for (t <- 0 until 8) {
      poke(c.io.spi_miso, ((bdata) & 0x80) >> 7)
      bdata = (bdata << 1)
      step(8)
    }
    step(1)
    poke(c.io.spi_miso, false.B)
    return 0
  }

}


object SoC_Main extends App {
  
  iotesters.Driver.execute(Array("--generate-vcd-output", "on", "--backend-name", "treadle"), () => new SoC_Tile) {
    c => new TestCore(c)
  } 

}

