section .bss
    userInput resb 100

section .data
    prompt db "请输入您的名字：", 0xA
    promptLen equ $ - prompt
    
    shortMsg db "小杂鱼♡～名字这么短，估计那玩意也差不多吧♡～", 0xA
    shortLen equ $ - shortMsg
    
    longMsg db "名字这么长吗？还是说那里太短了所以故意把名字弄长呢？果然是个小杂鱼呢♡～", 0xA
    longLen equ $ - longMsg
    
    normalMsg db "小杂鱼♡～你也就只有名字的长度是正常了吧，杂鱼♡～杂鱼♡～", 0xA
    normalLen equ $ - normalMsg

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

    ;移除回车换行
    mov rbx, rax ;获取用户字节数
    cmp rbx, 1 ;除了回车，什么都会+回车都会大于1
    jle return_0 ;所以能触发的只能是空了
    
    mov rax, userInput ;rax去第一个字母s
    add rax, rbx ;rax去回车
    mov byte [rax-1], 0 ;去rax的回车那里替换为结束

    ;看看长短
    cmp rbx, 10
    jle short_name

    cmp rbx, 50
    jg long_name
    
    jmp normal_name

;短短函数
short_name:
    mov rax, 1
    mov rdi, 1
    mov rsi, shortMsg
    mov rdx, shortLen
    syscall
    
    jmp return_0

;长长函数
long_name:
    mov rax, 1
    mov rdi, 1
    mov rsi, longMsg
    mov rdx, longLen
    syscall
    
    jmp return_0

;正常函数
normal_name:
    mov rax, 1
    mov rdi, 1
    mov rsi, normalMsg
    mov rdx, normalLen
    syscall
    
    jmp return_0

;退出
return_0:
    mov rax, 60
    xor rdi, rdi
    syscall