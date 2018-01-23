#include "P18F14K22_mod.inc"
    
    GLOBAL ISRH
    GLOBAL ISRL

    EXTERN SPI_Transmit
   
    CODE
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Interrupt Handler ;;
ISRH:
    BTFSC	PIR1, TMR2IF
    INCF	msCnt
    BCF		PIR1, TMR2IF

    RETFIE
;;;;;;;;;;;;;;
ISRL:

    RETFIE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    END


