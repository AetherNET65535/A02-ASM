section .bss
    number1 resb 100
    number2 resb 100
    total resb 200

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
    mov rdi, 1
    mov rsi, number_msg
    mov rdx, number_len
    syscall

    ret

;获取数字
get_number:
    call request_number

    mov rax, 0
    mov rdi, 0
    mov rsi, number1
    mov rdx, 100
    syscall

    mov rsi, number1
    xor rbx, rbx
    call text_to_number1
    
    call request_number

    mov rax, 0
    mov rdi, 0
    mov rsi, number2
    mov rdx, 100
    syscall
    
    mov rsi, number2
    xor rbx, rbx
    call text_to_number2
    
    jmp calculator

;字符转数字
text_to_number1:
    movzx rax, byte [rsi]

    cmp rax, '\n'
    je return_text1

    sub rax, '0'
    imul rbx, rbx, 10
    add rbx, rax
    
    inc rsi
    jmp text_to_number1

;字符转数字
text_to_number2:
    movzx rax, byte [rsi]

    cmp rax, '\n'
    je return_text2

    sub rax, '0'
    imul rbx, rbx, 10
    add rbx, rax
    
    inc rsi
    jmp text_to_number2

;计算函数
calculator:
    mov rax, [number1]
    add rax, [number2]
    mov [total], rax
    
    jmp to_stack

;把字符放进栈
to_stack:
    mov rbx, [total] ;可能是有点傻逼的行为，不过汇编已经帮我省很多性能了，我霍霍点吧
    
    mov rax, [total]
    cmp rax, 0
    je number_to_text
    
    mov rax, [total] ;AX
    mov rcx, 10      ;除以CX

    xor rdx, rdx
    div rcx          ;RAX = 商，RDX = 余
    
    mov [total], rax

    push rdx
    jmp to_stack

;数字转字符
number_to_text:
    mov rsi, total
    jmp convert_loop ;可有可无，让电脑知道我写的代码不是给他干闲活的

;NTT的子函数
convert_loop:
    pop rax
    add rax, '0'
    mov [rsi], al
    inc rsi

    cmp rsp, rbp
    jne convert_loop
    
    mov byte [rsi], 0
    
    jmp answer

;答案输出
answer:
    

;返回（草，怎么cmp ret不行呀）
return_text1:
    mov [number1], rbx
    ret

return_text2:
    mov [number2], rbx
    ret