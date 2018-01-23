; File:	    Main.asm
; Author:   holmanej
;
; Project: ASM_PIC18
; Created: January 20, 2018, 12:00 PM
;
; Device: PIC18F14K22
;

#include "P18F14K22_mod.inc"

; CONFIG1H
  CONFIG  FOSC = IRC            ; Oscillator Selection bits (Internal RC oscillator)
  CONFIG  PLLEN = ON            ; 4 X PLL Enable bit (Oscillator multiplied by 4)
  CONFIG  PCLKEN = ON           ; Primary Clock Enable bit (Primary clock enabled)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)
; CONFIG4L
  CONFIG  STVREN = OFF          ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will not cause Reset)

    ORG 0x0000
    GOTO MAIN

    ORG 0x0008
    GOTO ISRH

    ORG 0x0018
    GOTO ISRL

    EXTERN ISRH
    EXTERN ISRL
    EXTERN MCU_Init
    EXTERN Delay
    EXTERN SPI_Init
    EXTERN PT6961_Init

    CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAIN PROGRAM ;;
MAIN:
    CALL	MCU_Init
    CALL	SPI_Init
    CALL	PT6961_Init

;; MAIN LOOP ;;
LOOP:
    
    IOTOG	LED
    MOVLW	D'250'
    CALL	Delay

    BRA		LOOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    END