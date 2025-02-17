section .data
    prompt db "请输入数字：", 0xA
    prompt_len equ $ - prompt
    finish_msg db "已结束！", 0xA
    finish_len equ $ - finish_msg

section .bss
    user_input resb 100   ; 分配100字节的内存，用于存储用户输入

section .text
    global _start

_start:
    ; 提示用户输入
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    ; 读取用户输入
    mov rax, 0
    mov rdi, 0
    mov rsi, user_input
    mov rdx, 100
    syscall

    ; 计算（转换字符串为数字，加1）
    mov rsi, user_input         ; rsi 指向 user_input
    xor rbx, rbx                ; 清空 rbx（将其用作存储数字）

convert_loop:
    movzx rax, byte[rsi]               ; 将当前字符加载到 rax
    test rax, rax                 ; 检查是否是字符串结束符（0x0A）
    jz done_convert             ; 如果是 0x0A（换行符），结束转换

    sub rax, '0'                 ; 将字符转换为数字（'0' -> 0, '1' -> 1, ..., '9' -> 9）
    imul rbx, rbx, 10           ; 将现有数字乘以 10
    add rbx, rax                 ; 加上当前的数字

    inc rsi                     ; 移动到下一个字符
    jmp convert_loop            ; 继续转换

done_convert:
    add rbx, 1                 ; 加1（例如：65535 -> 65536）

    ; 输出计算结果
    mov rsi, rbx               ; 将结果存入 rsi（输出结果）
    ; 这里可以将 rsi 转回字符串输出（需要进一步实现）

    ; 结束
    mov rax, 1
    mov rdi, 1
    mov rsi, finish_msg
    mov rdx, finish_len
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
