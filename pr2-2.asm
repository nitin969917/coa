.MODEL SMALL
.STACK 100H
.DATA
    A DB 10H
    B DB 05H
    RESULT DB ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AL, A
    MOV AH, 00H       ; clear upper byte
    MOV BL, B

    ; Subtract
    SUB AL, BL
    MOV RESULT, AL

    ; Debug Breakpoint
    INT 3

    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN