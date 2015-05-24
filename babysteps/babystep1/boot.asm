; boot.asm
; NASM

; Data (512 bytes)
; 1. Fill up 512 bytes with zeros
; 2. Boot signature 0xAA55

; Code
; 1. Clear the interrupts flag
; 2. Hanging loop

    cli ; Clear interrupt flags
hang:
    jmp hang

    times 510-($-$$) db 0
    db 0x55
    db 0xAA

    
