section .bss
    number1 resb 100
    number2 resb 100
    answer resb 200

section .data
    number_msg db "请输入正整数：", 0xA
    number_len equ $ - number_msg
    
section .text
    global _start
    ;函数声明（就是想声明而已，我已经是C的形状了）
    ;request_number 
    ;get_number
    ;text_to_number1
    ;text_to_number2
    ;calculator
    ;to_stack
    ;number_to_text
    ;answer

_start:
    jmp get_number

;索取数字
request_number:
    mov rax, 1
    mov rsi, 1
    mov rdx, number_msg
    mov rcx, number_len
    syscall

    ret

;获取数字
get_number:
    call request_number

    mov rax, 0
    mov rsi, 0
    mov rdx, number1
    mov rcx, 100
    syscall

    mov rsi, number1
    xor rbx, rbx
    call text_to_number1
    
    call request_number

    mov rax, 0
    mov rsi, 0
    mov rdx, number2
    mov rcx, 100
    syscall
    
    mov rsi, number2
    xor rbx, rbx
    call text_to_number2

;字符转数字
text_to_number1:
    movzx rax, byte [rsi]

    cmp rax, '\n'
    je return_back

    sub number1, '0'
    imul rax, rax, 10
    add rbx, rax
    
    inc rsi
    jmp text_to_number1

;字符转数字
text_to_number2:

;计算函数
calculator:

;把字符放进栈
to_stack:

;数字转字符
number_to_text:

;答案输出
answer:

;返回（草，怎么cmp ret不行呀）
return_back:
    ret
