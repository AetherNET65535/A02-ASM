[bits 16]
org 0x7C00

start:
    mov ah, 0x00   ; 读取按键
    int 0x16       ; AL=ASCII码, AH=扫描码

    ; 检查是否是退格键
    cmp al, 0x08
    je handle_backspace

    ; 正常字符显示
    mov ah, 0x0E
    int 0x10
    jmp start

handle_backspace:
    ; 退格处理三步曲：
    mov ah, 0x0E
    ; 1. 光标左移一位
    mov al, 0x08
    int 0x10
    ; 2. 用空格覆盖原字符
    mov al, ' '
    int 0x10
    ; 3. 再次左移光标
    mov al, 0x08
    int 0x10
    jmp start

times 510-($-$$) db 0
dw 0xAA55