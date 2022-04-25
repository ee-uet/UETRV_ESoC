// Standard libraries
// #include <stdint.h>
#include <inttypes.h>
#include "spi.h"


/**********************************************************************//**
 * Initialize SPI module.
 *
 * @note Configure the SPI baud rate.
 * @param baud.
 **************************************************************************/
void SPI_Init(uint8_t baud) {
  
  SPI_Module.baud |= baud;
}


/**********************************************************************//**
 * Initiate SPI transfer. This is a blocking function.
 *
 **************************************************************************/
uint8_t SPI_Transfer(uint8_t tx_data) {
  
  SPI_Module.tx_data = tx_data;             // trigger transfer
  while(!(SPI_Module.status & SPI_TX_RDY)); // wait for transfer to finish

  return (uint8_t)(SPI_Module.rx_data) ;
}

