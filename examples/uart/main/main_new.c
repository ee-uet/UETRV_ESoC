#define UART_TX_R       *(volatile char *)(0x2001)
#define UART_RX_R       *(volatile char *)(0x2000)
#define UART_STATUS_R   *(volatile char *)(0x2004)

#define MOTOR_PWM_CFG_R  *(volatile char *)(0x4000)
#define MOTOR_PWM_DUTY_R *(volatile int  *)(0x400C)


extern unsigned int _sidata, _sdata, _edata, _sbss, _ebss;

char Lookup[8] = {'H', 'e', 'l', 'l', 'o', '\n', '\r'};

void UART_User_ISR(void){
     // clear the Uart Interrupt	
	char status = 0;
     status = UART_STATUS_R;
     UART_STATUS_R = (status & 0xFE); 
}

void myMemCpy(void *dest, void *src, int n) 
{ 
   // Typecast src and dest addresses to (char *) 
   int *csrc = (int *)src; 
   int *cdest = (int *)dest; 
   int counter = n >> 2;
  
   // Copy contents of src[] to dest[] 
   for (int i=0; i<counter ; i++) 
       cdest[i] = csrc[i]; 
}

void Motor_Init(void){

	MOTOR_PWM_CFG_R = 0x2F;
} 

char main(void)
{
	// declare some variables
	int mduty = 0;
	char x, y, z=0;
     
	// Copy initialized data from .sidata (Flash) to .data (RAM)
  	myMemCpy( &_sdata, &_sidata, (int)( ( void* )&_edata -    	     				( void* )&_sdata ) );

	Motor_Init();

	for(z=0; z < 6; z++){
		while (!(UART_STATUS_R & 0x02));
		UART_TX_R = Lookup[z];
	}
	
     while(1){

		mduty = MOTOR_PWM_DUTY_R;
		UART_TX_R = (((mduty) & 0x3F));
		while (!(UART_STATUS_R & 0x02));
		UART_TX_R = '\n';
		while (!(UART_STATUS_R & 0x02));
		UART_TX_R = '\r';
		while (!(UART_STATUS_R & 0x02));
	
	} 

	return z;
}
