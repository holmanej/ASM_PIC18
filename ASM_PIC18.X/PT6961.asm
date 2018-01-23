    #include "P18F14K22_mod.inc"

    GLOBAL PT6961_Init
    GLOBAL PT6961_SetDigit
    GLOBAL PT6961_luDigit
    GLOBAL PT6961_luValue

    EXTERN SPI_Transmit
    EXTERN Delay

PT6961	    UDATA
gp0	    RES 1
;; end local variables ;;

    CODE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PT6961_Init
;; Initializes a 7seg display
;; Inputs: none
;; Outputs: none
PT6961_Init:
    BCF		TRISA, RA5	    ; CS on RA5

    IOSET	LCD_CS
    MOVLW	D'200'
    CALL	Delay

    IOCLR	LCD_CS
    MOVLW	H'40'
    CALL	SPI_Transmit	    ; Set display mode
    IOSET	LCD_CS

    IOCLR	LCD_CS
    MOVLW	H'02'
    CALL	SPI_Transmit	    ; Set data
    IOSET	LCD_CS

    IOCLR	LCD_CS
    MOVLW	H'03'
    CALL	SPI_Transmit	    ; Clear RAM
    CLRF	gp0
LOOP:
    CLRF	WREG
    CALL	SPI_Transmit
    INCF	gp0
    BTFSS	gp0, 3
    BRA		LOOP
    IOSET	LCD_CS

    IOCLR	LCD_CS
    MOVLW	H'F1'
    CALL	SPI_Transmit	    ; Display on
    IOSET	LCD_CS

    MOVLW	H'26'
    CALL	PT6961_SetDigit

    RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PT6961_SetDigit: sends a value for a digit to the 7seg
;; Inputs: WREG(digit, value)
;; Outputs: none
PT6961_SetDigit:
; Extract digit
    MOVWF	gp0
    IOCLR	LCD_CS
    CALL	PT6961_luDigit
    CALL	SPI_Transmit	    ; Set digit
    CALL	PT6961_luValue
    CALL	SPI_Transmit	    ; Set value
    IOSET	LCD_CS

    RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PT6961_luDigit: looks up digit pos
;; Inputs: gp0(digit pos)
;; Outputs: WREG(transmit byte)
PT6961_luDigit:
    MOVLW	high(PT6961_Digits)
    MOVWF	PCLATH
    MOVF	gp0, W
    SWAPF	WREG
    ANDLW	H'0F'
    RLNCF	WREG
    ADDLW	low(PT6961_Digits)
    BTFSC	STATUS, C
    INCF	PCLATH, F
    MOVWF	PCL
PT6961_Digits:
    RETLW	H'63'		    ; left
    RETLW	H'23'		    ; mid-left
    RETLW	H'43'		    ; mid-right
    RETLW	H'03'		    ; right
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PT6961_luValue: looks up 7seg value
;; Inputs: gp0(value)
;; Outputs: WREG(transmit byte)
PT6961_luValue:
    MOVLW	high(PT6961_Values)
    MOVWF	PCLATH
    MOVF	gp0, W
    ANDLW	H'0F'
    RLNCF	WREG
    ADDLW	low(PT6961_Values)
    BTFSC	STATUS, C
    INCF	PCLATH, F
    MOVWF	PCL
PT6961_Values:
    RETLW	H'FC'		    ; 0
    RETLW	H'60'		    ; 1
    RETLW	H'DA'		    ; 2
    RETLW	H'F2'		    ; 3
    RETLW	H'66'		    ; 4
    RETLW	H'B6'		    ; 5
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