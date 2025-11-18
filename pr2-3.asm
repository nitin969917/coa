.MODEL SMALL
.STACK 100H
.DATA
    A DB 10H
    B DB 05H
    RESULT DW ?       ; word, because MUL gives 16-bit result
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AL, A
    MOV AH, 00H       ; clear upper byte
    MOV BL, B

    ; Multiply
    MUL BL            ; AX = AL * BL
    MOV RESULT, AX    ; store full 16-bit result

    ; Debug Breakpoint
    INT 3

    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN