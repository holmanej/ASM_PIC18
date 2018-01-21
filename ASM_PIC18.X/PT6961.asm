    #include "P18F14K22_mod.inc"

    GLOBAL PT6961_Init
    GLOBAL PT6961_SetDigit
    GLOBAL PT6961_luDigit
    GLOBAL PT6961_luValue

    EXTERN SPI_Transmit
    EXTERN Delay

    UDATA
temp

    CODE

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
    MOVWF	temp
    ANDLW	H'F0'
    SWAPF	WREG
    MOVWF	ARG0
; Extract value
    MOVF	temp, W
    ANDLW	H'0F'
    MOVWF	ARG1
; Lookup and transmit
    BCF		PORTB, 7
    CALL	PT6961_luDigit
    CALL	SPI_Transmit	    ; Set digit
    CALL	PT6961_luValue
    CALL	SPI_Transmit	    ; Set value
    BSF		PORTB, 7

    RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PT6961_luDigit: looks up digit pos
;; Inputs: ARG0(digit pos)
;; Outputs: none
PT6961_luDigit:
    MOVLW	high(PT6961_Digits)
    MOVWF	PCLATH
    BCF		STATUS, 0
    RLCF	ARG0
    MOVF	ARG0, W
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
;; PT6961_luValue: looks up 7seg value
;; Inputs: ARG1(value)
;; Outputs: WREG(transmit byte)
PT6961_luValue:
    MOVLW	high(PT6961_Values)
    MOVWF	PCLATH
    BCF		STATUS, 0
    RLCF	ARG1
    MOVF	ARG1, W
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