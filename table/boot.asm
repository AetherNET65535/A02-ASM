; 数据段定义
section .bss
    number1 resb 100    ; 第一个输入数字的存储空间
    number2 resb 100    ; 第二个输入数字的存储空间
    result  resb 200    ; 计算结果的存储空间

section .data
    input_prompt db "请输入一个正整数: ", 0xA    ; 输入提示信息
    input_len    equ $ - input_prompt
    
    output_msg   db "计算结果: "                  ; 输出提示信息
    output_len   equ $ - output_msg

section .text
    global _start

; 程序入口点
_start:
    ; 获取两个输入数字
    call get_two_numbers
    ; 计算它们的和并显示结果
    call calculate_and_display
    ; 退出程序
    call exit_program

; 获取用户输入的提示函数
display_prompt:
    mov rax, 1                  ; sys_write系统调用号
    mov rdi, 1                  ; 标准输出文件描述符
    mov rsi, input_prompt       ; 提示信息的地址
    mov rdx, input_len          ; 提示信息的长度
    syscall
    ret

; 获取两个数字的输入
get_two_numbers:
    ; 获取第一个数字
    call display_prompt
    mov rax, 0                  ; sys_read系统调用号
    mov rdi, 0                  ; 标准输入文件描述符
    mov rsi, number1           ; 存储位置
    mov rdx, 100               ; 最大读取长度
    syscall
    
    ; 将第一个数字的字符串转换为数值
    mov rsi, number1
    call string_to_number
    mov rbx, rax               ; 保存第一个数字
    
    ; 获取第二个数字
    call display_prompt
    mov rax, 0
    mov rdi, 0
    mov rsi, number2
    mov rdx, 100
    syscall
    
    ; 将第二个数字的字符串转换为数值
    mov rsi, number2
    call string_to_number
    mov rcx, rax               ; 保存第二个数字
    
    ret

; 字符串转换为数字
string_to_number:
    xor rax, rax               ; 清零rax(用于存储结果)
    xor rdx, rdx               ; 清零rdx(用于临时存储)

.convert_loop:
    movzx rdx, byte [rsi]      ; 读取一个字符
    cmp rdx, 0xA               ; 检查是否为换行符
    je .done
    cmp rdx, '0'               ; 检查是否小于'0'
    jl .error
    cmp rdx, '9'               ; 检查是否大于'9'
    jg .error
    
    sub rdx, '0'               ; 转换为数字
    imul rax, 10               ; 当前结果乘10
    add rax, rdx               ; 加上新的数字
    inc rsi                    ; 移动到下一个字符
    jmp .convert_loop

.error:
    xor rax, rax               ; 发生错误时返回0

.done:
    ret

; 计算结果并显示
calculate_and_display:
    ; 计算两数之和
    mov rax, rbx
    add rax, rcx
    
    ; 转换结果为字符串
    mov rdi, result            ; 结果存储位置
    call number_to_string
    
    ; 显示结果标签
    mov rax, 1
    mov rdi, 1
    mov rsi, output_msg
    mov rdx, output_len
    syscall
    
    ; 显示计算结果
    mov rax, 1
    mov rdi, 1
    mov rsi, result
    mov rdx, 100
    syscall
    
    ret

; 数字转换为字符串
number_to_string:
    push rbp
    mov rbp, rsp
    mov rbx, 10                ; 除数

.divide_loop:
    xor rdx, rdx               ; 清零rdx
    div rbx                    ; 除以10
    add dl, '0'                ; 转换为ASCII
    push rdx                   ; 将数字字符压入栈
    test rax, rax              ; 检查商是否为0
    jnz .divide_loop

.store_loop:
    pop rdx                    ; 弹出数字字符
    mov [rdi], dl              ; 存储到结果字符串
    inc rdi
    cmp rsp, rbp              ; 检查是否处理完所有数字
    jne .store_loop
    
    mov byte [rdi], 0xA        ; 添加换行符
    inc rdi
    mov byte [rdi], 0          ; 添加字符串结束符
    
    mov rsp, rbp
    pop rbp
    ret

; 退出程序
exit_program:
    mov rax, 60                ; sys_exit系统调用号
    xor rdi, rdi               ; 返回值0
    syscall