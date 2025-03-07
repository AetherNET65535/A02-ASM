[bits 16]
org 0x7C00  ; 传统 BIOS 启动扇区地址

start:
    mov ah, 0x00   ; 读取按键
    int 0x16       ; BIOS 键盘输入中断
    mov ah, 0x0E   ; 让 BIOS 在屏幕上显示字符
    int 0x10       ; 显示 AL 里的字符

    jmp start      ; 继续读取输入

times 510-($-$$) db 0
dw 0xAA55  ; BIOS 启动标志
