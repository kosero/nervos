org 0x7C00

start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    call clear_screen

    mov si, welcome
    call print_string

    jmp $

clear_screen:
    pusha

    mov ah, 0x00
    mov al, 0x03
    int 0x10

    mov ah, 0x02
    mov bh, 0x00
    mov dh, 0
    mov dl, 0
    int 0x10

    popa
    ret

print_string:
    mov ah, 0x0E
    mov bh, 0x00
.loop:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .loop
.done:
    ret

welcome db 'Starting NERV OS...', 0

times 510 - ($ - $$) db 0
dw 0xAA55

