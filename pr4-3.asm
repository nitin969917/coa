.MODEL SMALL
.STACK 100h
.DATA
    array1 DB 11h, 22h, 33h, 44h, 55h   ; First array
    array2 DB 99h, 88h, 77h, 66h, 55h   ; Second array

    msg1  DB 0Dh,0Ah, "Before Exchange - Array1 & Array2$"
    msg2  DB 0Dh,0Ah, "After Exchange  - Array1 & Array2$"

.CODE
MAIN PROC
    ; Initialize DS
    MOV AX, @DATA
    MOV DS, AX

    ; Show before-exchange message
    LEA DX, msg1
    MOV AH, 09h
    INT 21h

    ; Block Exchange
    LEA SI, array1          ; SI -> Array1
    LEA DI, array2          ; DI -> Array2
    MOV CX, 5               ; Number of elements

SwapLoop:
    LODSB                   ; Load Array1 element into AL
    XCHG AL, [DI]           ; Swap AL with Array2 element
    STOSB                   ; Store swapped AL back into Array1
    LOOP SwapLoop           ; Repeat until CX = 0

    ; Show after-exchange message
    LEA DX, msg2
    MOV AH, 09h
    INT 21h

    ; Exit to DOS
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN