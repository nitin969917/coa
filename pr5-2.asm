.MODEL SMALL
.STACK 100H
.DATA
X1 DW 50
Y1 DW 60
X2 DW 200
Y2 DW 60     ; Horizontal line
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ; Set graphics mode
    MOV AH,0
    MOV AL,13H
    INT 10H

    ; Draw line from (X1,Y1) → (X2,Y2)
    MOV CX,X1
    MOV DX,Y1
LineLoop:
    MOV AH,0Ch
    MOV AL,10      ; Color
    MOV BH,0
    INT 10H

    INC CX
    CMP CX,X2
    JLE LineLoop

    ; Wait for key
    MOV AH,0
    INT 16H

    ; Restore text mode
    MOV AH,0
    MOV AL,03H
    INT 10H

    MOV AH,4Ch
    INT 21H
MAIN ENDP
END MAIN