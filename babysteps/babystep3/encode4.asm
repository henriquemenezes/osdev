; nasm encode4.asm -f bin -o encode4.bin
; hd encode4.bin

; Addresses
; Address encoding is a bit more complicated 

    mov cx, [temp]
 
temp db 0x99
    times 510-($-$$) db 0
    db 0x55
    db 0xAA