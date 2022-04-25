
/* ********************************************************************//* 
 * @file main.c
 * @author M Tahir
 * @brief Main test application program.
 **************************************************************************/

// Header files
#include <stdint.h>
#include "../Interfaces/uart.h"

const char message[8] = {'H','e','l','l','o', '\n', '\r'};
char dst[8] = {0,0,0,0,0,0,0,0};


/* ************************************************************************ 
 * Main function.
 **************************************************************************/
int main(void) {
  uint8_t count = 0;

  // Initialize UART with desired baudrate
  Uetrv32_Uart_Init(UART_BAUD_DIV);

  for(count = 0; count < 5; count++) {
    dst[count] = message[count]; 
  }
    
  while(1){
	for(count = 0; count < 5; count++) {
    	  Uetrv32_Uart_Tx((dst[count])); 
  	}  
  }
}

