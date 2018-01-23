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

; Configure RC6 for debug LED
    CLRF	ANSEL
    CLRF	ANSELH
    BCF		TRISC, RC6
    IOCLR	LED

; Configure TMR2 for 1 ms
    MOVLW	H'7D'
    MOVWF	T2CON
    MOVLW	D'250'
    MOVWF	PR2
    BSF		PIE1, TMR2IE

; Global interrupt enable
    BSF		INTCON, PEIE
    BSF		INTCON, GIE

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


