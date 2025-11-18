.MODEL SMALL
.STACK 100h
.DATA
    msg1 DB "Enter first string: $"
    msg2 DB 0Dh,0Ah,"Enter second string: $"
    same DB 0Dh,0Ah,"Strings are Equal$"
    diff DB 0Dh,0Ah,"Strings are NOT Equal$"

    str1 DB 20,?,20 DUP('$')
    str2 DB 20,?,20 DUP('$')

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Input first string
    LEA DX, msg1
    MOV AH, 09h
    INT 21h
    LEA DX, str1
    MOV AH, 0Ah
    INT 21h

    ; Input second string
    LEA DX, msg2
    MOV AH, 09h
    INT 21h
    LEA DX, str2
    MOV AH, 0Ah
    INT 21h

    ; Compare lengths
    MOV AL, str1+1
    CMP AL, str2+1
    JNE NotEqual

    ; Compare characters
    MOV CL, AL
    LEA SI, str1+2
    LEA DI, str2+2

NextChar:
    CMP CL, 0
    JE Equal
    MOV AL, [SI]
    CMP AL, [DI]
    JNE NotEqual
    INC SI
    INC DI
    DEC CL
    JMP NextChar

Equal:
    LEA DX, same
    MOV AH, 09h
    INT 21h
    JMP ExitProg

NotEqual:
    LEA DX, diff
    MOV AH, 09h
    INT 21h

ExitProg:
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN

