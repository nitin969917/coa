.MODEL SMALL
.STACK 100H
.DATA
    A DB 14H          ; 20 decimal
    B DB 05H          ; 5 decimal
    QUOTIENT DB ?
    REMAINDER DB ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AL, A
    MOV AH, 00H       ; clear upper byte for division
    MOV BL, B

    ; Divide
    DIV BL            ; AL = quotient, AH = remainder

    MOV QUOTIENT, AL
    MOV REMAINDER, AH

    ; Debug Breakpoint
    INT 3

    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN