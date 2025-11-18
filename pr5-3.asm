
.MODEL SMALL
.STACK 100H
.DATA
Color DB 14    ; Yellow color

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; set graphics mode 13h (320x200, 256 colors)
    MOV AX, 0013h
    INT 10h

    ; Base line  (x = 100 → 200 , y = 150)
    MOV CX, 100
BaseLine:
    MOV DX, 150
    MOV AL, Color
    MOV AH, 0Ch
    MOV BH, 0
    INT 10h
    INC CX
    CMP CX, 200
    JLE BaseLine

    ; Left side  (from 100,150 → 150,50)
    MOV CX, 100
    MOV DX, 150
LeftLine:
    MOV AL, Color
    MOV AH, 0Ch
    MOV BH, 0
    INT 10h
    INC CX
    DEC DX
    CMP CX, 150
    JLE LeftLine

    ; Right side (from 200,150 → 150,50)
    MOV CX, 200
    MOV DX, 150
RightLine:
    MOV AL, Color
    MOV AH, 0Ch
    MOV BH, 0
    INT 10h
    DEC CX
    DEC DX
    CMP CX, 150
    JGE RightLine

    ; Wait for key press
    MOV AH, 0
    INT 16h

    ; return to text mode
    MOV AX, 0003h
    INT 10h

    ; exit
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN





