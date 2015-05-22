; boot.asm
; NASM

; BabyStep1

; Quick review:
; 1. Boot sector loaded by BIOS is 512 bytes
; 2. The code in the boot sector of the disk is loaded by the BIOS at 0000:7c00
; 3. Machine starts in Real Mode (16 bits with direct access to BIOS routines)
; 4. Be aware that the CPU is being interrupted unless you issue the CLI assembly command 

; Compile instructions: 
;  $ nasm boot.asm -f bin -o boot.bin

; Creating disk image
; The code is assembled in NASM and copied to floppy using partcopy,dd,or debug. 
; Then you simply boot from the /dev/fd0 (floppy). 
;  $ dd if=boot.bin of=/dev/fd0 

; The CPU starts in REAL MODE and the BIOS loads this code at Address 0000:7c00

; About Addressing: 
;   SEGMENT:OFFSET
; There are often many different Segment:Offset pairs which can be used to address the same 
; location in your computer's memory. This scheme is a relative way of viewing computer memory
; as opposed to a Linear or Absolute addressing scheme.
; 
; Segment:Offset addressing was introduced at a time when the largest register in a CPU was only
; 16-bits long which meant it could address only 65,536 bytes (64 KiB[1]) of memory, directly. 
; But everyone was hungry for a way to run much larger programs! Rather than create a CPU with 
; larger register sizes (as some CPU manufacturers had done), the designers at Intel decided to
; keep the 16-bit registers for their new 8086 CPU and added a different way to access more memory,
;
; If the designers had allowed the CPU to combine two registers into a high and low pair of 32-bits,
; it could have referenced up to 4 GiB[2] of memory in a linear fashion! 
;
; Absolute Memory Location = (Segment value * 16) + Offset value 
; 
; or Segment shifted one hexadecimal byte to the left; add an extra 0 to the end of the hex number
; 
; Example: F000:FFFD
;
;           F0000 (Segment shifted one byte to left)
;          + FFFD
;          ------
; Absolute: FFFFD

    cli ; Clear interrupt flags
hang:
    jmp hang

    ; Fill up 512 bytes with zeros
    times 510-($-$$) db 0 ; 2 bytes less now
    ; Boot signature 0xAA55
    db 0x55
    db 0xAA

    
