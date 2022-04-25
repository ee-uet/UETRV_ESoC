
/* ********************************************************************//* 
 * @file main.c
 * @author M Tahir
 * @brief Main test application program.
 **************************************************************************/

// Libraries
#include <stdint.h>
#include "../Interfaces/uart.h"


#define UART_BAUD_DIV  217
#define PWM_Duty (*((volatile uint8_t*) (0x0000400C)))
#define DELAY 2000

const char message[13] = {'H','e','l','l','o', ' ', 'W', 'o', 'r', 'l', 'd', '\n', '\r'};
const char PWM[4] = {'D','C',' ','='};


/* ********************************************************************//* 
 * Main function.
 **************************************************************************/
int main(void) {
  uint8_t count = 0;
unsigned int delay = 0;
char duty_Unit;
char duty_Tens;

  // Initialize UART with desired baudrate
  Uetrv32_Uart_Init(UART_BAUD_DIV);
  
  for(count = 0; count < 13; count++) {
    		Uetrv32_Uart_Tx((message[count]));
    	}
  
  while(1)
	{
		// Random Delay loop
		 for (delay=0; delay<DELAY;delay++);
		
		// Conversion to char
		duty_Unit = PWM_Duty%10 + '0';
		duty_Tens = (PWM_Duty/10)%10 + '0';
		
		// Message
		for(count = 0; count < 4; count++) {
    		Uetrv32_Uart_Tx((PWM[count]));
    	     }
    	
	    	Uetrv32_Uart_Tx(duty_Unit);		
	    	Uetrv32_Uart_Tx(duty_Tens);
	    	Uetrv32_Uart_Tx('\n');
		Uetrv32_Uart_Tx('\r');
	   	 
  }  

}

