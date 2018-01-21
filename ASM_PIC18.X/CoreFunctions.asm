#include "P18F14K22_mod.inc"

    GLOBAL MCU_Init
    GLOBAL Delay

    CODE
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MCU_Init
;; Sets base configuration
;; Inputs: none
;; Outputs: none
MCU_Init:
    
; Configure clock for 64 MHz
    MOVLW	H'70'
    MOVWF	OSCCON

; Configure RA2 for debug LED
    CLRF	ANSEL
    CLRF	ANSELH
    CLRF	TRISA
    BCF		PORTA, 2

; Configure TMR2 for 1 ms
    MOVLW	H'7D'
    MOVWF	T2CON
    MOVLW	D'250'
    MOVWF	PR2
    BSF		PIE1, 1

; Global interrupt enable
    BSF		INTCON, 6
    BSF		INTCON, 7

    RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Delay: Delays program for given ms
;; Inputs: WREG(Number of ms up to 255)
;; Outputs: none
Delay:
    CLRF	msCnt
Delay_Wait:
    CPFSGT	msCnt
    BRA		Delay_Wait
    RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    END


