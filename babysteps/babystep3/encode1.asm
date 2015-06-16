; nasm encode1.asm -f bin -o encode1.bin
; hd encode1.bin
 
    mov cx, 0xFF
    times 510-($-$$) db 0
    db 0x55
    db 0xAA