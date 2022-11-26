#ifndef UART_H
#define UART_H

#define UART_TX_R       *(volatile char *)(0x2001)
#define UART_RX_R       *(volatile char *)(0x2000)
#define UART_STATUS_R   *(volatile char *)(0x2004)
#define UART_INT_MASK_R *(volatile char *)(0x2005)

// Baud rate divisor
#define UART_BAUD_DIV   217


/** UART module prototype */
typedef struct __attribute__((packed,aligned(4))) {
	uint8_t rx_data;
	uint8_t tx_data;  
	uint8_t baud;  
	uint8_t control; 
	uint8_t status; 
	uint8_t int_mask;   
} UART_Struct;

/** UART module hardware access */
#define UART_Module (*((volatile UART_Struct*) (0x00002000UL)))


// Function prototypes
void UART_Init(uint8_t baud);
void UART_Tx(uint8_t tx_data);
void UART_Isr(void);
void UART_Print(const char *s);

#endif
