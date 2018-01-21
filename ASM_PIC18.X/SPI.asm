#include "P18F14K22_mod.inc"
    
    GLOBAL SPI_Init
    GLOBAL SPI_Transmit

    CODE
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SPI_Init: Configures spi module for master mode, 4 MHz
;; Inputs: none
;; Outputs: none
SPI_Init:
    BCF		TRISB, 6	    ; SCK on RB6
    BCF		TRISC, 7	    ; MOSI on RC7
    BSF		TRISB, 4	    ; MISO on RB4
    
    BSF		SSPSTAT, 7	    ; SMP = 1
    BSF		SSPSTAT, 6	    ; CKE = 1
    MOVLW	H'21'		    ; CKP = 0, SPI Master at Fosc = 64/16
    MOVWF	SSPCON1

    RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SPI_Transmit: Sends and receives a byte
;; Inputs: WREG(8 bit send)
;; Outputs: WREG(8 bit receive)
SPI_Transmit:
    MOVWF	SSPBUF		    ; Load buffer
SPI_Wait:
    BTFSS	SSPSTAT, BF	    ; Wait for buffer to fill
    BRA		SPI_Wait
    MOVF	SSPBUF, W	    ; Get response

    RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    END