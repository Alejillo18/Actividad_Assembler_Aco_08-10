
.MODEL SMALL
.STACK 100h

.DATA
fibArray DW 10 DUP(?)
msg DB 'Serie Fibonacci:$'
tempBuffer DB 6 DUP(?)

.CODE
MAIN:
    ; Inicializar segmento de datos
    MOV AX, SEG fibArray
    MOV DS, AX

    ; Primeros dos números de Fibonacci
    MOV WORD PTR [fibArray], 0
    MOV WORD PTR [fibArray+2], 1

    ; Calcular los siguientes 8 números
    MOV CX, 8
    MOV SI, 4

CALC_FIB:
    MOV AX, [fibArray+SI-4] ; n-2
    ADD AX, [fibArray+SI-2] ; n-1
    MOV [fibArray+SI], AX
    ADD SI, 2
    LOOP CALC_FIB

    ; Mostrar mensaje
    MOV AH, 09h
    LEA DX, msg
    INT 21h

    ; Mostrar todos los números
    MOV CX, 10
    MOV SI, 0

DISPLAY_LOOP:
    MOV AX, [fibArray+SI]
    CALL PrintNum
    ADD SI, 2
    LOOP DISPLAY_LOOP

    ; Terminar programa
    MOV AH, 4Ch
    INT 21h

; -------------------------------
; Procedimiento para imprimir número
; -------------------------------
PrintNum PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    MOV BX, 10
    XOR CX, CX

    CMP AX, 0
    JNE NotZero
    ; Caso 0
    MOV DL, '0'
    MOV AH, 02h
    INT 21h
    JMP DonePrint

NotZero:
    LEA SI, tempBuffer
    ADD SI, 6

DivLoop:
    XOR DX, DX
    DIV BX
    ADD DL, '0'
    DEC SI
    MOV [SI], DL
    INC CX
    CMP AX, 0
    JNE DivLoop

PrintLoop:
    MOV DL, [SI]
    INT 21h
    INC SI
    DEC CX
    JNZ PrintLoop

    ; Espacio después del número
    MOV DL, ' '
    MOV AH, 02h
    INT 21h

DonePrint:
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PrintNum ENDP

END MAIN
