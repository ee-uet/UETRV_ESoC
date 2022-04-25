
// Standard libraries
// #include <stdint.h>
  #include <inttypes.h>
 // #include <limits.h>

#include "uart.h"


/**********************************************************************//**
 * Initialize UART module.
 *
 * @note Configure the baud divisor register.
 *
 * @param baud.
 **************************************************************************/
void UART_Init(uint8_t baud) {
  
  UART_Module.baud = baud;
}


/**********************************************************************//**
 * UART data transmit. This is a blocking function.
 *
 **************************************************************************/
void UART_Tx(uint8_t tx_data) {
  
  while ((UART_Module.status & 0x02) == 0);
	UART_Module.tx_data = tx_data;             // trigger transfer

  return ;
}

/**********************************************************************//**
 * Print string (zero-terminated) via UART. 
 *
 * @note This function is blocking.
 *
 * @param[in] s -- Pointer to string.
 **************************************************************************/
/*void UART_Print(const char *s) {

  char c = 0;
  while ((c = *s++)) {
    UART_Tx(((uint8_t) c));
  }
}
*/


