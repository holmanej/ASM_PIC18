#include "P18F14K22_mod.inc"
    
    GLOBAL ISRH
    GLOBAL ISRL
   
    CODE
    
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

    END


