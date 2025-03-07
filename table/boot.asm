[bits 16]
org 0x7C00

start:
    mov ah, 0x00
    int 0x16   ; 读取按键

    ; 检查是否是 Backspace（0x7F）
    cmp al, 0x7F
    je handle_backspace

    ; 正常字符显示
    mov ah, 0x0E
    int 0x10
    jmp start

handle_backspace:
    ; 退格处理三步曲：
    mov ah, 0x0E
    mov al, 0x08  ; 1. 光标左移
    int 0x10

    mov al, ' '   ; 2. 覆盖字符
    int 0x10

    mov al, 0x08  ; 3. 再次左移光标
    int 0x10

    jmp start

times 510-($-$$) db 0
dw 0xAA55
