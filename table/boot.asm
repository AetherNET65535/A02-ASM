[bits 16]
org 0x7C00

start:
    mov ah, 0x00
    int 0x16   ; 读取按键

    mov dl, al  ; AL = ASCII 码
    call print_hex

    mov dl, ah  ; AH = 扫描码
    call print_hex

    mov al, ' '  ; 空格分隔
    mov ah, 0x0E
    int 0x10

    jmp start  ; 继续读取输入

; 把 DL 转换成十六进制并打印
print_hex:
    push ax
    push bx

    mov bl, dl  ; 备份 DL
    shr bl, 4   ; 取高 4 位
    call print_digit

    mov bl, dl  ; 取低 4 位
    and bl, 0x0F
    call print_digit

    mov al, ' '
    mov ah, 0x0E
    int 0x10

    pop bx
    pop ax
    ret

print_digit:
    add bl, '0'
    cmp bl, '9'
    jbe print_ok
    add bl, 7   ; 'A'-'F' 需要偏移

print_ok:
    mov al, bl
    mov ah, 0x0E
    int 0x10
    ret

times 510-($-$$) db 0
dw 0xAA55
