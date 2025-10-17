section .data
    true_msg db "Es primo", 0
    false_msg db "No es primo", 0
    newline db 10, 0

section .text
    global _start

; Función para verificar si un número es primo
; Entrada: RDI = número a verificar
; Salida: RAX = 1 si es primo, 0 si no lo es
is_prime:
    cmp rdi, 2
    jl not_prime      ; Números menores que 2 no son primos
    je is_prime_num   ; 2 es primo
    
    mov rax, rdi
    and rax, 1
    jz not_prime      ; Números pares mayores que 2 no son primos
    
    mov rcx, 3        ; Empezar a verificar desde 3
    
check_loop:
    mov rax, rcx
    mul rax           ; RAX = RCX * RCX
    cmp rax, rdi
    jg is_prime_num   ; Si divisor^2 > n, es primo
    
    mov rax, rdi
    xor rdx, rdx
    div rcx           ; RAX = RDI / RCX, RDX = RDI % RCX
    
    test rdx, rdx
    jz not_prime      ; Si divisible, no es primo
    
    add rcx, 2        ; Solo verificar números impares
    jmp check_loop

not_prime:
    mov rax, 0
    ret

is_prime_num:
    mov rax, 1
    ret

; Función para imprimir string
; Entrada: RSI = puntero al string
print_string:
    mov rdi, 1        ; stdout
    call strlen
    mov rdx, rax      ; longitud
    mov rax, 1        ; sys_write
    syscall
    ret

; Función para calcular longitud de string
; Entrada: RSI = puntero al string
; Salida: RAX = longitud
strlen:
    mov rcx, 0
strlen_loop:
    cmp byte [rsi + rcx], 0
    je strlen_done
    inc rcx
    jmp strlen_loop
strlen_done:
    mov rax, rcx
    ret

_start:
    mov rdi, 29       ; Número a verificar (cambia este valor)
    call is_prime
    
    test rax, rax
    jz not_prime_msg
    
    ; Es primo
    mov rsi, true_msg
    call print_string
    jmp exit_program
    
not_prime_msg:
    ; No es primo
    mov rsi, false_msg
    call print_string

exit_program:
    ; Nueva línea
    mov rsi, newline
    call print_string
    
    ; Salir
    mov rax, 60       ; sys_exit
    xor rdi, rdi      ; código 0
    syscall