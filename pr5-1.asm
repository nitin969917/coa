.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
    ; Set graphics mode 320x200, 256 colors
    MOV AH,0
    MOV AL,13H
    INT 10H

    ; Plot 5 dots at different coordinates
    ; INT 10h, AH=0Ch → Write Pixel
    ; AL = color, CX = X, DX = Y, BH = page (0)

    ; Dot 1 (red at 50,50)
    MOV AH,0Ch
    MOV AL,4
    MOV CX,50
    MOV DX,50
    MOV BH,0
    INT 10H

    ; Dot 2 (blue at 100,80)
    MOV AH,0Ch
    MOV AL,1
    MOV CX,100
    MOV DX,80
    INT 10H

    ; Dot 3 (green at 150,120)
    MOV AH,0Ch
    MOV AL,2
    MOV CX,150
    MOV DX,120
    INT 10H

    ; Dot 4 (yellow at 200,160)
    MOV AH,0Ch
    MOV AL,14
    MOV CX,200
    MOV DX,160
    INT 10H

    ; Dot 5 (white at 250,100)
    MOV AH,0Ch
    MOV AL,15
    MOV CX,250
    MOV DX,100
    INT 10H

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

