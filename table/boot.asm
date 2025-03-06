[bits 16]
org 0x7C00

buffer: times 256 db 0  ; 预留 256 字节作为输入缓冲区
buf_pos: db 0           ; 当前输入位置（指向 buffer）

start:
    mov ah, 0x00
    int 0x16  ; 读取键盘输入，AL = ASCII 码

    cmp al, 0x08  ; 判断是否是 Backspace（0x08）
    je print
    jne store_char

    ; 处理 Backspace
    cmp byte [buf_pos], 0  ; 是否已经是空缓冲区？
    je start  ; 如果是空的，就不做任何事，直接等下一个输入

    dec byte [buf_pos]  ; 缓冲区回退
    mov al, 0x20  ; 输出空格覆盖字符
    int 0x10
    jmp start

print:
    mov al, '2'
    int 0x10

store_char:
    ; 存入缓冲区
    mov si, buffer
    add si, [buf_pos]
    mov [si], al
    inc byte [buf_pos]

    ; 输出字符
    mov ah, 0x0E
    int 0x10

    jmp start  ; 继续等待输入

times 510 - ($-$$) db 0
dw 0xAA55
