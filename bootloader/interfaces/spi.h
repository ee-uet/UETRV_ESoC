
#define SPI_TX_RDY  0x10


/** SPI module prototype */
typedef struct __attribute__((packed,aligned(4))) {
	uint8_t rx_data;
	uint8_t tx_data;
	uint8_t baud;  
	uint8_t control;  
	uint8_t status; 
	uint8_t ss_mask;   
} uetrv32_spi_struct;

/** SPI module hardware access */
#define SPI_Module (*((volatile uetrv32_spi_struct*) (0x00003000UL)))

#define SPI_CS_EN()    SPI_Module.ss_mask |= 0x01;
#define SPI_CS_DIS()   SPI_Module.ss_mask &= 0xFE;


// Function prototypes
void SPI_Init(uint8_t baud);
uint8_t SPI_Transfer(uint8_t tx_data);
