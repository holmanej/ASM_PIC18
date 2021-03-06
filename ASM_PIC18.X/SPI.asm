#include "P18F14K22_mod.inc"
    
    GLOBAL SPI_Init
    GLOBAL SPI_Transmit

    CODE
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SPI_Init: Configures spi module for master mode, 4 MHz
;; Inputs: none
;; Outputs: none
SPI_Init:
    BCF		TRISB, RB6	    ; SCK on RB6
    BCF		TRISC, RC7	    ; MOSI on RC7
    BSF		TRISB, RB4	    ; MISO on RB4
    
    BSF		SSPSTAT, SMP	    ; SMP = 1
    BSF		SSPSTAT, CKE	    ; CKE = 1
    MOVLW	H'21'		    ; CKP = 0, SPI Master at Fosc = 64/16
    MOVWF	SSPCON1

    RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SPI_Transmit: performs blocking spi transmit
;; Inputs: WREG(byte send)
;; Outputs: WREG(byte received)
SPI_Transmit:
    MOVWF	SSPBUF
SPI_Wait:
    BTFSS	SSPSTAT, BF
    BRA		SPI_Wait

    RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    END