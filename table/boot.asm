[bits 16]
org 0x7C00  

start:
    mov ah, 0x00   ; BIOS 读取键盘输入
    int 0x16       ; AL = ASCII 码

print:
    mov ah, 0x0E   ; BIOS 显示字符
    mov bl, al     ; 备份 AL（因为 AL 会被修改）

    mov al, 'H'    ; 显示 "HEX:"
    int 0x10
    mov al, 'E'
    int 0x10
    mov al, 'X'
    int 0x10
    mov al, ':'
    int 0x10

    mov al, '0' + ((bl >> 4) & 0x0F)  ; 显示高 4 位
    int 0x10
    mov al, '0' + (bl & 0x0F)         ; 显示低 4 位
    int 0x10

    jmp start

times 510-($-$$) db 0
dw 0xAA55  
