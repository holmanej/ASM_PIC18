; File:	    Main.asm
; Author:   holmanej
;
; Project: ASM_PIC18
; Created: January 20, 2018, 12:00 PM
;
; Device: PIC18F14K22
;

#include "P18F14K22.inc"

; CONFIG1H
  CONFIG  FOSC = IRC            ; Oscillator Selection bits (Internal RC oscillator)
  CONFIG  PLLEN = ON            ; 4 X PLL Enable bit (Oscillator multiplied by 4)
  CONFIG  PCLKEN = ON           ; Primary Clock Enable bit (Primary clock enabled)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)
; CONFIG4L
  CONFIG  STVREN = OFF          ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will not cause Reset)

    ORG 0x0000
    GOTO MCU_Init

    ORG 0x0008
    GOTO ISRH

    ORG 0x0018
    GOTO ISRL

    CBLOCK 0x000
	gp0
	gp1
	;
	arg0
	arg1
	;
	msCnt
    ENDC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAIN LOOP ;;
LOOP:
    
    BTG		PORTA, 2
    MOVLW	D'250'
    CALL	Delay

    BRA		LOOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Interrupt Handler ;;
ISRH:
    BTFSC	PIR1, 1
    INCF	msCnt
    BCF		PIR1, 1

    RETFIE
;;;;;;;;;;;;;;
ISRL:

    RETFIE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Subroutines ;;

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

; Configure SPI
    BCF		TRISB, 6	    ; SCK on RB6
    BCF		TRISC, 7	    ; MOSI on RC7
    BSF		TRISB, 4	    ; MISO on RB4
    
    BSF		SSPSTAT, 7	    ; SMP = 1
    BSF		SSPSTAT, 6	    ; CKE = 1
    MOVLW	H'21'		    ; CKP = 0, SPI Master at Fosc = 64/4
    MOVWF	SSPCON1

; Global interrupt enable
    BSF		INTCON, 6
    BSF		INTCON, 7    

; Init 7seg
    CALL	PT6961_Init

    GOTO LOOP
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
;; SPI_Transmit
;; Sends and receives a byte
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
;; PT6961_Init
;; Initializes a 7seg display
;; Inputs: none
;; Outputs: none
PT6961_Init:
    BCF		TRISB, 7	    ; CS on RB7
    BSF		PORTB, 7
    MOVLW	D'200'
    CALL	Delay

    BCF		PORTB, 7
    MOVLW	H'40'
    CALL	SPI_Transmit	    ; Set display mode
    BSF		PORTB, 7

    BCF		PORTB, 7
    MOVLW	H'02'
    CALL	SPI_Transmit	    ; Set data
    BSF		PORTB, 7

    BCF		PORTB, 7
    MOVLW	H'03'
    CALL	SPI_Transmit	    ; Clear RAM
    CLRF	WREG
    CALL	SPI_Transmit
    CALL	SPI_Transmit
    CALL	SPI_Transmit
    CALL	SPI_Transmit
    CALL	SPI_Transmit
    CALL	SPI_Transmit
    CALL	SPI_Transmit
    CALL	SPI_Transmit
    BSF		PORTB, 7

    BCF		PORTB, 7
    MOVLW	H'F1'
    CALL	SPI_Transmit	    ; Display on
    BSF		PORTB, 7

    MOVLW	H'1A'
    CALL	PT6961_SetDigit

    RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PT6961_SetDigit: sends a value for a digit to the 7seg
;; Inputs: WREG(digit, value)
;; Outputs: none
PT6961_SetDigit:
; Extract digit
    MOVWF	gp0
    ANDLW	H'F0'
    SWAPF	WREG
    MOVWF	arg0
; Extract value
    MOVF	gp0, W
    ANDLW	H'0F'
    MOVWF	arg1
; Lookup and transmit
    BCF		PORTB, 7
    CALL	PT6961_luDigit
    CALL	SPI_Transmit	    ; Set digit
    CALL	PT6961_luValue
    CALL	SPI_Transmit	    ; Set value
    BSF		PORTB, 7

    RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PT6961_SetDigit: Transmits digit select
;; Inputs: WREG(digit pos)
;; Outputs: none
PT6961_luDigit:
    MOVLW	high(PT6961_Digits)
    MOVWF	PCLATH
    BCF		STATUS, 0
    RLCF	arg0
    MOVF	arg0, W
    ADDLW	low(PT6961_Digits)
    BTFSC	STATUS, 3
    INCF	PCLATH, F
    MOVWF	PCL
PT6961_Digits:
    RETLW	H'63'		    ; left
    RETLW	H'23'		    ; mid-left
    RETLW	H'43'		    ; mid-right
    RETLW	H'03'		    ; right
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PT6961_luValue: translates [15..0] into transmit byte
;; Inputs: arg1(value)
;; Outputs: WREG(transmit byte)
PT6961_luValue:
    MOVLW	high(PT6961_Values)
    MOVWF	PCLATH
    BCF		STATUS, 0
    RLCF	arg1
    MOVF	arg1, W
    ADDLW	low(PT6961_Values)
    BTFSC	STATUS, 3
    INCF	PCLATH, F
    MOVWF	PCL
PT6961_Values:
    RETLW	H'FC'		    ; 0
    RETLW	H'60'		    ; 1
    RETLW	H'DA'		    ; 2
    RETLW	H'F2'		    ; 3
    RETLW	H'66'		    ; 4
    RETLW	H'B2'		    ; 5
    RETLW	H'BE'		    ; 6
    RETLW	H'E0'		    ; 7
    RETLW	H'FE'		    ; 8
    RETLW	H'F6'		    ; 9
    RETLW	H'EE'		    ; A
    RETLW	H'3E'		    ; B
    RETLW	H'9C'		    ; C
    RETLW	H'7A'		    ; D
    RETLW	H'9E'		    ; E
    RETLW	H'8E'		    ; F
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    END