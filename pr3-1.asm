.MODEL SMALL
.STACK 100h
.DATA
    msg1 DB "Enter Your String :$"
    msg2 DB 0DH,0AH,"Your String :$"
	buffer DB 20          ; max characters user can type
           DB ?           ; actual number of characters entered 
           DB 20 DUP('$') ; space for input + terminator
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
	
	; Print first message
	LEA DX, msg1
	MOV AH, 09H
    INT 21H

    ; Take input
    LEA DX, buffer
    MOV AH, 0Ah
    INT 21h

	; Print second message
	LEA DX, msg2
    MOV AH, 09h
    INT 21h

 	; Print the entered string (cleanly once)
    LEA DX, buffer+2
    MOV AH, 09h
    INT 21h

    ; Exit
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN



