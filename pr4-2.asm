.MODEL SMALL
.STACK 100h
.DATA
    arr1 DB 11h,22h,33h,44h,55h   
    arr2 DB 5 DUP(?)            

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX        

    LEA SI, arr1      
    LEA DI, arr2        
    MOV CX, 5           

    CLD                 
    REP MOVSB           
  
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN

