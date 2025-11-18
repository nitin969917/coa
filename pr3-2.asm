.MODEL SMALL
.STACK 100h
.DATA
    msg1 DB "Enter Your String :$"
    msg2 DB 0Dh,0Ah,"Length of String :$"
    msg3 DB 0Dh,0Ah,"Your String :$"
    buffer DB 50          ; max characters user can type
           DB ?           
           DB 50 DUP('$') 
    lenStr DB 3 DUP('$')  ; space for two-digit length + terminator

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Print first message
    LEA DX, msg1
    MOV AH, 09h
    INT 21h

    ; Take input
    LEA DX, buffer
    MOV AH, 0Ah
    INT 21h

    ; Convert buffer+1 (length) to ASCII
    MOV AL, buffer+1   ; AL = length
    MOV AH, 0
    MOV BL, 10
    DIV BL             ; AX / 10 → AL=quotient (tens), AH=remainder (ones)

    ; Store tens digit if > 0
    CMP AL, 0
    JE ONLY_ONES
    ADD AL, 30h
    MOV lenStr, AL
    ADD AH, 30h
    MOV lenStr+1, AH
    JMP STORE_DONE

ONLY_ONES:
    ADD AH, 30h
    MOV lenStr, AH

STORE_DONE:

    ; Print second message
    LEA DX, msg2
    MOV AH, 09h
    INT 21h

    ; Print length
    LEA DX, lenStr
    MOV AH, 09h
    INT 21h

    ; Replace ENTER with '$'
    MOV BL, buffer+1
    LEA DI, buffer+2
    ADD DI, BX
    MOV BYTE PTR [DI], '$'

    ; Print third message
    LEA DX, msg3
    MOV AH, 09h
    INT 21h

    ; Print entered string
    LEA DX, buffer+2
    MOV AH, 09h
    INT 21h

    ; Exit
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN


