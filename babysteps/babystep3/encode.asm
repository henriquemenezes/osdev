; nasm encode.asm -f bin -o encode.bin
; hd encode.bin
 
    mov cx, 0xFF
    times 510-($-$$) db 0
    db 0x55
    db 0xAA