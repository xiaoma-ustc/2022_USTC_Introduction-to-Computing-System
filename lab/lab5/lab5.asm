.ORIG x800
        ; (1) Initialize interrupt vector table.
        LD R0, VEC
        LD R1, ISR
        STR R1, R0, #0

        ; (2) Set bit 14 of KBSR.
        LDI R0, KBSR
        LD R1, MASK
        NOT R1, R1
        AND R0, R0, R1
        NOT R1, R1
        ADD R0, R0, R1
        STI R0, KBSR

        ; (3) Set up system stack to enter user space.
        LD R0, PSR
        ADD R6, R6, #-1
        STR R0, R6, #0
        LD R0, PC
        ADD R6, R6, #-1
        STR R0, R6, #0
        ; Enter user space.
        RTI
        
VEC     .FILL x0180
ISR     .FILL x1000
KBSR    .FILL xFE00
MASK    .FILL x4000
PSR     .FILL x8002
PC      .FILL x3000
        .END

        .ORIG x3000
        ; *** Begin user program code here ***
START   LD R0, SITESTU
        trap x22
        JSR DELAY
DONE1   LDI R2, KBSR1
        BRzp START
        JSR DELAY
DONE3   ADD R4, R4, #0
        BRnz RENEW
        AND R4, R4, #0
        LD R0, SITEH  
        trap x22
        ADD R5, R3, #0
        AND R0, R0, #0
        LD R6, STACK
        JSR HONOI
        AND R1, R1, #0
        AND R6, R6, #0
L5      ADD R6, R6, #1
        LD R3, NUM2
        ADD R0, R0, R3
        BRzp L5
        LD R3, NUM3
        ADD R1, R0, R3
        ADD R6, R6, #-1
        LD R3, NUM4
        ADD R0, R6, #0
        BRz #2
        ADD R0, R0, R3
OUT1    trap x21
        ADD R0, R1, #0
        AND R6, R6, #0
L6      ADD R6, R6, #1
        ADD R0, R0, #-10
        BRzp L6
        ADD R1, R0, #10
        ADD R6, R6, #-1
        ADD R0, R6, #0
        BRz #2
        ADD R0, R0, R3
OUT2    trap x21
        ADD R0, R1, #0
        ADD R0, R0, R3
OUT3    trap x21
        LD R0, SITELINE 
        trap x22
        HALT
RENEW   BRnzp START
   
HONOI   ADD R5, R5, #0
        BRz RETURN1
        ADD R5, R5, #-1
        ADD R6, R6, #-1
        STR R7, R6, #0
        JSR HONOI
        LDR R0, R6, #0
        ADD R6, R6, #1
        LDR R7, R6, #0
        ADD R6, R6, #1
        ADD R0, R0, R0
        ADD R0, R0, #1
        ADD R6, R6, #-1
        STR R0, R6, #0
        RET
RETURN1 ADD R0, R0, #0
        ADD R6, R6, #-1
        STR R0, R6, #0
        RET
        
 

        
DELAY   ST R1, Save1
        LD R1, COUNT
REP     ADD R1, R1, #-1
        BRp REP
        LD R1, Save1
        RET
NUM1    .FILL #-48
NUM2    .FILL #-100
NUM3    .FILL #100
NUM4    .FILL #48
SITESTU    .FILL StuNum
SITEH       .FILL StrH
SITELINE    .FILL RELINE
DONE2   .FILL x3FFF    
Save1   .BLKW   1

COUNT   .FILL   5000
KBDR    .FILL xFE02
KBSR1    .FILL xFE00
STACK   .FILL x4100
StuNum .STRINGZ "PB20061376\n"
StrH    .STRINGZ "HONOI move(s): "
RELINE  .STRINGZ "\n"
        ; *** End user program code here ***
        .END

        .ORIG x3FFF
        ; *** Begin honoi data here ***
HONOI_N .FILL xFFFF



        ; *** End honoi data here ***
        .END

        .ORIG x1000
        ; *** Begin interrupt service routine code here ***
        ST R0, Save2
        ST R1, Save3
        ST R2, Save4
        LDI R3, KBDR1
        AND R4, R4, #0
        LD R2, JUDGE2
        ADD R1, R3, R2
        BRp NOTDEC
        LD R2, JUDGE1
        ADD R1, R3, R2
        BRn NOTDEC
DEC     ST R1, HONIOM 
        ADD R4, R4, #1
        ADD R0, R3, #0
        trap x21
        LD R0, SITE1
        trap x22
        ADD R3, R1, #0
        BRnzp RETURN
NOTDEC  ADD R0, R3, #0
        trap x21
        LD R0, SITE2
        trap x22
RETURN  AND R0, R0, #0
        STI R0, KBDR1
        LD R0, PSR1
        ADD R6, R6, #-1
        STR R0, R6, #0
        LD R0, PC1
        ADD R6, R6, #-1
        STR R0, R6, #0
        LD R0, Save2
        LD R1, Save3
        LD R2, Save4
        RTI
JUDGE1  .FILL #-48
JUDGE2  .FILL #-58
DSR1     .FILL xFE04   
DDR1     .FILL xFE06
KBDR1    .FILL xFE02
HONIOM   .FILL x3FFF
SITE1   .FILL SDEC
SITE2   .FILL SNOTDEC
SDEC    .STRINGZ " is a decimal number \n"
SNOTDEC .STRINGZ " is not a decimal number \n"
Save2   .BLKW 1
Save3   .BLKW 1
Save4   .BLKW 1
PSR1     .FILL x8002
PC1      .FILL x3005

        ; *** End interrupt service routine code here ***
        .END