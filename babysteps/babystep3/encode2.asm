; nasm encode2.asm -f bin -o encode2.bin
; hd encode2.bin

    mov ecx, 0xFF
    times 510-($-$$) db 0
    db 0x55
    db 0xAA