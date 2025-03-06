[bits 16]
org 0x7C00

start:
    mov ah, 0x00
    int 0x16

    cmp al, 0x08
    jne print

    mov al, 0x08
    int 0x10
    mov al, 0x20
    int 0x10
    mov al, 0x08
    int 0x10
    jmp start

print:
    mov ah, 0x0E
    int 0x10

    jmp start

times 510 - ($-$$) db 0
dw 0xAA55