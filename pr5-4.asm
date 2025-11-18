; SIMPLE_RECT.ASM
.MODEL SMALL
.STACK 100H
.DATA
Color DB 12    ; Red color

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Set graphics mode 13h (320x200, 256 colors)
    MOV AX, 0013h
    INT 10h

    ; ------------------------------------
    ; Draw a rectangle using simple loops
    ; Top-left corner = (80, 60)
    ; Bottom-right corner = (200, 140)
    ; ------------------------------------

    ; Top horizontal line (x = 80 → 200, y = 60)
    MOV CX, 80
TopLine:
    MOV DX, 60
    MOV AL, Color
    MOV AH, 0Ch
    MOV BH, 0
    INT 10h
    INC CX
    CMP CX, 200
    JLE TopLine

    ; Bottom horizontal line (x = 80 → 200, y = 140)
    MOV CX, 80
BottomLine:
    MOV DX, 140
    MOV AL, Color
    MOV AH, 0Ch
    MOV BH, 0
    INT 10h
    INC CX
    CMP CX, 200
    JLE BottomLine

    ; Left vertical line (y = 60 → 140, x = 80)
    MOV DX, 60
LeftLine:
    MOV CX, 80
    MOV AL, Color
    MOV AH, 0Ch
    MOV BH, 0
    INT 10h
    INC DX
    CMP DX, 140
    JLE LeftLine

    ; Right vertical line (y = 60 → 140, x = 200)
    MOV DX, 60
RightLine:
    MOV CX, 200
    MOV AL, Color
    MOV AH, 0Ch
    MOV BH, 0
    INT 10h
    INC DX
    CMP DX, 140
    JLE RightLine

    ; Wait for key
    MOV AH, 0
    INT 16h

    ; Return to text mode
    MOV AX, 0003h
    INT 10h

    ; Exit
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN