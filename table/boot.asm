[bits 16]
org 0x7C00

print:
    mov ah, 0x0E
    mov al, 'H'  ; 先输出一个标记
    int 0x10
    mov al, 'E'
    int 0x10
    mov al, 'X'
    int 0x10

    mov al, '0' + ((al >> 4) & 0x0F)  ; 取高 4 位
    int 0x10
    mov al, '0' + (al & 0x0F)         ; 取低 4 位
    int 0x10

    jmp start

times 510 - ($-$$) db 0
dw 0xAA55
