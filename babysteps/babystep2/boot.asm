; boot.asm
; NASM

; BabyStep2 - Writing a message using the BIOS 

; Code - macro BiosPrint
; 1. Move word address of argument 1 to si (source index register)
; 2. lodsb - Loads a byte at address DS:SI into AL
; 3. or al, al - If al is 0 then the print is done
; 4. Call BIOS interruption (INT 10h/AH=0Eh) to print
; 5. Jump to loop until print all string (\0 at the end)

%macro BiosPrint 1
    mov si, word %1
ch_loop:
    lodsb
    or al, al
    jz done
    mov ah, 0x0E
    int 0x10
    jmp ch_loop
done:
%endmacro

; Code - bootloader
; 1. Set 0 into ax
; 2. Move 0 to ds (data segment register)
; 3. Call macro BiosPrint with msg data
; 4. Hanging loop
 
[ORG 0x7c00]
    xor ax, ax
    mov ds, ax
    BiosPrint msg
hang:
    jmp hang
 
msg db 'Hello World', 13, 10, 0
 
   times 510-($-$$) db 0
   db 0x55
   db 0xAA