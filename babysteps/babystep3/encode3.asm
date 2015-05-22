; nasm encode3.asm -f bin -o encode3.bin
; hd encode.bin

; The '66' is an Operand Size Override Prefix generated by the assembler when
; there is a discrepancy with the default mode, which when NASM assembles binary 
; files, it is 16-bit.  

[BITS 32]
   mov cx, 0xFF
   times 510-($-$$) db 0
   db 0x55
   db 0xAA