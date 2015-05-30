; boot.asm
; NASM

; Code
; 1. Clear the interrupts flag
; 2. Hanging loop

; Data (512 bytes)
; 1. Fill up 510 bytes with zeros
; 2. And two last bytes with Boot signature 0xAA55

    cli
hang:
    jmp hang

    times 510-($-$$) db 0
    db 0x55
    db 0xAA

    
