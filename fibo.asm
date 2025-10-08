.MODEL SMALL
.STACK 100h

.DATA
fib DW 10 DUP(?)
msg DB 'Fibonacci:$'
numbuf DB 6 DUP(?)

.CODE
START:
    MOV AX, SEG fib
    MOV DS, AX

    MOV WORD PTR [fib], 0
    MOV WORD PTR [fib+2], 1

    MOV CX, 8
    MOV SI, 4

FIB_LOOP:
    MOV AX, [fib+SI-4]
    ADD AX, [fib+SI-2]
    MOV [fib+SI], AX
    ADD SI, 2
    LOOP FIB_LOOP

    MOV AH, 09h
    LEA DX, msg
    INT 21h

    MOV CX, 10
    MOV SI, 0

SHOW_LOOP:
    MOV AX, [fib+SI]
    CALL PRINT_NUMBER
    ADD SI, 2
    LOOP SHOW_LOOP

    MOV AH, 4Ch
    INT 21h

PRINT_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    MOV BX, 10
    XOR CX,CX
    CMP AX,0
    JNE PN_NOT_ZERO
    MOV DL,'0'
    MOV AH,02h
    INT 21h
    JMP PN_DONE

PN_NOT_ZERO:
    MOV SI,OFFSET numbuf
    ADD SI,6
PN_DIV_LOOP:
    XOR DX,DX
    DIV BX
    ADD DL,'0'
    DEC SI
    MOV [SI],DL
    INC CX
    CMP AX,0
    JNE PN_DIV_LOOP

    MOV AH,02h
PN_PRINT_LOOP:
    MOV DL,[SI]
    INT 21h
    INC SI
    DEC CX
    JNZ PN_PRINT_LOOP

    MOV DL,' '
    MOV AH,02h
    INT 21h

PN_DONE:
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUMBER ENDP

END START
