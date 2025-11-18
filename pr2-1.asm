.MODEL SMALL
.STACK 100H
.DATA
    A DB 10H       ; 16 decimal
    B DB 05H       ; 5 decimal
    RESULT DB ?    ; To store result
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Load numbers
    MOV AL, A
    MOV AH, 00H       ; clear upper byte
    MOV BL, B

    ; Add
    ADD AL, BL
    MOV RESULT, AL
	
    ; Debug Breakpoint
    INT 3
    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN