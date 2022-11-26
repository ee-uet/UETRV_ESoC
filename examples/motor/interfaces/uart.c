
// Standard libraries
// #include <stdint.h>
#include <inttypes.h>

#include "../main/defs.h"
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


/*************************************************************************
 * UART data transmit. This is a blocking function.
 *
 ************************************************************************/
void UART_Tx(uint8_t tx_data) {
  
  while ((UART_Module.status & 0x02) == 0);
	UART_Module.tx_data = tx_data;             // trigger transfer

  return ;
}

/*************************************************************************
 * UART interrupt service routine. Calls the Motor_Speed function 
 *
 ************************************************************************/
void UART_Isr(void){
     
  // clear the Uart Interrupt	
  char status, rx_data;
  status = UART_STATUS_R;
  rx_data = UART_RX_R;

  UART_STATUS_R = UART_STATUS_R & (0xFE);  // Clear the UART Rx interrupt
  draw_command(rx_data);
}


