; gcd_nasm.asm - NASM x86-64 Linux
section .data
    prompt db 'Ingrese a b (en una linea, separados por espacio): ',0
    outmsg db 10,'GCD = %llu',10,0
section .bss
    buf resb 128
section .text
    global main
    extern printf, fgets, sscanf
main:
    mov rdi, prompt
    xor rax,rax
    call printf
    mov rdi, buf
    mov esi, 128
    call fgets
    mov rdi, buf
    lea rsi, [rel buf]
    ; parse two unsigned long long with sscanf
    ; simpler: call sscanf(buf, "%llu %llu", &a, &b)
    ; for brevity call sscanf
    mov rdi, buf
    lea rsi, [buf+64]
    mov rdx, 0
    ; Not implementing full sscanf sequence here; use C version below for full behaviour
    xor rax,rax
    ret
