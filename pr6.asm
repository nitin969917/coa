.MODEL SMALL
.STACK 100H
.DATA
msg1 DB 0Dh,0Ah,"Enter Password: $"
success DB 0Dh,0Ah,"Access Granted!$"
fail    DB 0Dh,0Ah,"Access Denied$"
locked  DB 0Dh,0Ah,"System Locked!$"
invalid DB 0Dh,0Ah,"Invalid Length. Try Again.$"
newline DB 0Dh,0Ah,"$"
welcome DB 0Dh,0Ah,"Welcome to Secure System!$"

buffer  DB 8 DUP(?)
predefined DB "8086$"
passlen EQU 4

caseInsensitive DB 1   ; 1 = case-insensitive, 0 = case-sensitive

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    MOV BL,3         ; attempt counter

TryAgain:
    LEA DX,msg1
    MOV AH,09H
    INT 21H

    ; Read password input
    LEA SI,buffer
    XOR CX,CX         ; length counter = 0
ReadLoop:
    MOV AH,07H
    INT 21H
    CMP AL,0Dh        ; Enter key pressed?
    JE EndInput
    CMP CX,8
    JAE EndInput
    MOV BYTE PTR [SI],AL
    INC SI
    INC CX
    MOV DL,'*'
    MOV AH,02H
    INT 21H
    JMP ReadLoop

EndInput:
    MOV BYTE PTR [SI],'$'   ; null terminator

    ; Check length
    CMP CX,passlen
    JNE InvalidLength

    ; Convert to uppercase if caseInsensitive = 1
    MOV AL,caseInsensitive
    CMP AL,1
    JNE SkipCaseConvert
    LEA SI,buffer
    MOV CX,passlen
ToUpperLoop:
    MOV AL,BYTE PTR [SI]
    CMP AL,'a'
    JB SkipConvert
    CMP AL,'z'
    JA SkipConvert
    SUB AL,20H
    MOV BYTE PTR [SI],AL
SkipConvert:
    INC SI
    LOOP ToUpperLoop
SkipCaseConvert:

    ; Compare input with predefined password
    LEA SI,buffer
    LEA DI,predefined
    MOV CX,passlen
CheckLoop:
    MOV AL,BYTE PTR [SI]
    CMP AL,BYTE PTR [DI]
    JNE Wrong
    INC SI
    INC DI
    LOOP CheckLoop

Correct:
    LEA DX,success
    MOV AH,09H
    INT 21H

    LEA DX,welcome
    MOV AH,09H
    INT 21H

    ; ===== Creative Extension: Display current date/time =====
    MOV AH,2Ah
    INT 21H      ; Get system date
    MOV AH,09H
    LEA DX,newline
    INT 21H

    MOV AH,2Ch
    INT 21H      ; Get system time
    MOV AH,09H
    LEA DX,newline
    INT 21H

    JMP ExitProg

Wrong:
    LEA DX,fail
    MOV AH,09H
    INT 21H
    DEC BL
    JZ LockSystem
    JMP TryAgain

InvalidLength:
    LEA DX,invalid
    MOV AH,09H
    INT 21H
    JMP TryAgain

LockSystem:
    LEA DX,locked
    MOV AH,09H
    INT 21H

ExitProg:
    MOV AH,4Ch
    INT 21H
MAIN ENDP
END MAIN