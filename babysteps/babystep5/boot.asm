; nasmw boot.asm -f bin -o boot.bin
; partcopy boot.bin 0 200 -f0

; This code is meant to show how the hardware interrupt generated when you press a 
; key can be handled by replacing the seg:offset specified in the IVT (interrupt 
; vector table). This normally points to a BIOS routine. To find the entry in the
; IVT, multiply the interrupt number by 4 (which is the size of each entry).
 
[ORG 0x7c00]      ; add to offsets
    jmp start

start:
    xor ax, ax     ; ax = 0
    mov ds, ax     ; DS = 0
    mov ss, ax     ; Stack starts at segment 0x0 (relative to 0x7C00)
    mov sp, 0x9c00 ; 2000h past code start - Offset 0x9C00 (SS:SP)
    mov ax, 0xb800 ; text video memory
    mov es, ax
    cli               ; Clear interrupt flags (disable interrupts)
    mov bx, 0x09      ; Hardware interrupt
    shl bx, 2         ; Multiply by 4
    xor ax, ax        ; ax = 0
    mov gs, ax        ; gs = 0 (Start of memory)
    mov [gs:bx], word keyhandler
    mov [gs:bx+2], ds ; Segment
    sti               ; Enable interrupt flags
    jmp $             ; Loop forever (jmp for current line $)
 
keyhandler:
    in al, 0x60       ; Get key data
    mov bl, al        ; Save it
    mov byte [port60], al
    in al, 0x61       ; Keyboard Control
    mov ah, al
    or al, 0x80       ; Disable bit 7
    out 0x61, al      ; Send it back
    xchg ah, al       ; Get original
    out 0x61, al      ; Send that back
    mov al, 0x20      ; End of Interrupt
    out 0x20, al      ;
    and bl, 0x80      ; Key released
    jnz done          ; Don't repeat
    mov ax, [port60]
    mov  word [reg16], ax
    call printreg16
done:
    iret

dochar:
    call cprint          ; print one character

sprint:   
    lodsb                ; string char to AL
    cmp al, 0
    jne dochar           ; else, we're done
    add byte [ypos], 1   ; down one row
    mov byte [xpos], 0   ; back to left
    ret

cprint:
    mov ah, 0x0F         ; attrib = white on black
    mov cx, ax           ; save char/attribute
    movzx ax, byte [ypos]
    mov dx, 160          ; 2 bytes (char/attrib)
    mul dx               ; for 80 columns
    movzx bx, byte [xpos]
    shl bx, 1            ; times 2 to skip attrib
    mov di, 0            ; start of video memory
    add di, ax           ; add y offset
    add di, bx           ; add x offset
    mov ax, cx           ; restore char/attribute
    stosw                ; write char/attribute
    add byte [xpos], 1   ; advance to right
    ret

printreg16:
    mov di, outstr16
    mov ax, [reg16]
    mov si, hexstr
    mov cx, 4            ; four places
hexloop:
    rol ax, 4            ; leftmost will
    mov bx, ax           ; become
    and bx, 0x0f         ; rightmost
    mov bl, [si + bx]    ; index into hexstr
    mov [di], bl
    inc di
    dec cx
    jnz hexloop
    mov si, outstr16
    call sprint
    ret

xpos     db 0
ypos     db 0
port60   dw 0
hexstr   db '0123456789ABCDEF'
outstr16 db '0000', 0         ; register value string
reg16    dw  0                ; pass values to printreg16
 
   times 510-($-$$) db 0  ; fill sector w/ 0's
   dw 0xAA55              ; req'd by some BIOSes