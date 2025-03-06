[bits 16]
org 0x7C00

start:
    mov ah, 0x00
    int 0x16
    mov ah, 0x0E
    int 0x10

    jmp start

times 510 - ($-$$) db 0
dw 0xAA55