.ORIG x3000
INIT LDI R0, NUM
    LD R1, DATA
    LDR R2, R1, #0
    ADD R3, R2, #0
    ADD R1, R1, #1
    ADD R5, R5, #1
    ADD R4, R4, #1
    ADD R0, R0, #-1
WHILE BRz UPDATE
    LDR R2, R1, #0
    ADD R1, R1, #1
    NOT R6, R3
    ADD R6, R6, #1
    ADD R6, R2, R6
    BRnp UPDATE
    ADD R4, R4, #1
BACK ADD R3, R2, #0
    ADD R0, R0, #-1
    BRnzp WHILE
    
UPDATE NOT R6, R4
    ADD R6, R6, #1
    ADD R6, R5, R6
    BRzp #1
    ADD R5, R4, #0
    AND R4, R4, #0
    ADD R4, R4, #1
    ADD R0, R0, #0
    BRz OUTPUT
    BRnzp BACK


OUTPUT STI R5, RESULT

HALT

RESULT .FILL x3050
NUM .FILL x3100
DATA .FILL x3101
.END

