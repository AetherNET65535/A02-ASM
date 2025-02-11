section .bss
    buffer resb 100
    userInput resb 100

section .data
    prompt db "请输入文字：", 0 
    promptLen equ $ - prompt

section .text
    global _start

_start:
    ;提示输出信息   
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, promptLen
    syscall

    ;读取用户输入
    mov rax, 0
    mov rdi, 0
    mov rsi, userInput
    mov rdx, 100
    syscall

    mov rbx, rax

    ;输出用户输入
    mov rax, 1
    mov rdi, 1
    mov rsi, userInput
    mov rdx, rbx
    syscall

    ;退出
    mov rax, 60
    xor rdi, rdi
    syscall
