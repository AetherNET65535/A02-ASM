[bits 16]
org 0x7C00

start:
    ; 读取按键
    mov ah, 0x00
    int 0x16

    ; 退格键处理
    cmp al, 0x08
    je handle_backspace

    ; 显示字符
    call print_char
    jmp start

handle_backspace:
    cmp cx, 0  ; 如果光标已经在最左侧，跳过
    je start

    dec cx      ; 左移光标
    mov bx, cx  ; 计算写入位置
    shl bx, 1   ; 每个字符占 2 字节（字符 + 颜色）
    mov word [es:bx], 0x0720  ; 0x07=白色，0x20=空格
    jmp start

print_char:
    mov bx, cx
    shl bx, 1
    mov [es:bx], al   ; 写入字符
    mov byte [es:bx+1], 0x07  ; 颜色：白色

    inc cx  ; 右移光标
    ret

setup_video:
    mov ax, 0xB800
    mov es, ax   ; 设置 ES 指向 VGA 文本缓冲区
    mov cx, 0    ; 初始化光标位置
    ret

call setup_video
jmp start

times 510-($-$$) db 0
dw 0xAA55
