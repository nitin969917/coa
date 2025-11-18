.MODEL SMALL
.STACK 100h
.DATA
    msg1 DB "Enter your string :$"
    msg2 DB 0Dh,0Ah,"Reversed string :$"
    buffer DB 50
           DB ?
           DB 50 DUP(?)

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Print "Enter your string"
    LEA DX, msg1
    MOV AH, 09h
    INT 21h

    ; Input string
    LEA DX, buffer
    MOV AH, 0Ah
    INT 21h

    ; Print "Reversed string"
    LEA DX, msg2
    MOV AH, 09h
    INT 21h

    ; Print string in reverse (char by char)
    MOV CL, buffer+1      ; length of input
    LEA SI, buffer+2      ; start of string
    ADD SI, CX            ; point to last char

PRINT_LOOP:
    DEC SI                ; move to character
    MOV DL, [SI]          ; load character
    MOV AH, 02h           ; print single char
    INT 21h
    LOOP PRINT_LOOP       ; repeat until done

    ; Exit
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN

