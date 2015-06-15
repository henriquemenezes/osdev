# BabyStep2
> _Writing a message using the BIOS_

### BIOS

Many, but not all, BIOS interrupts expect *DS* register to be filled with a *segment* value in __Real Mode__. This is why many BIOS interrupts won't work in protected mode. So if you want to use *INT 10h/AH=0Eh* to print to the screen, then you need to make sure that your *segment:offset* for the characters to print is correct.

### BIOS Interruption call

+ **INT 10h** = Video BIOS Services
+ **AH=0Eh**  = Write Character in TTY Mode

### Addresses in Real Mode

In Real Mode, addresses are calculated as: 

> **(SEGMENT * 16) + OFFSET**

So, there are many pairs of segment and offset that point to the same addresses. For example, the bootloader is loaded at **0000:7c00** or **07c00:0000**, in fact they are same address **0x7c00**.

It doesn't matter if you use 0000:7c00 or 07c0:0000, but if you use **ORG** you need to be aware of what's happening. 

> _The ORG (origin) directive is used to specify the location to load program in memory._

By default, the offset is 0x0000, so if we need access the msg variable we must set the segment to 0x07c0. 

```nasm
   mov ax, 0x07c0 ; set 0x07c0 in ax
   mov ds, ax     ; data segment = 0x07c0
 
   mov si, msg
ch_loop:lodsb
   or al, al
   jz hang
   mov ah, 0x0E
   int 0x10
   jmp ch_loop
 
hang:
   jmp hang
 
msg   db 'Hello World', 13, 10, 0

   times 510-($-$$) db 0
   db 0x55
   db 0xAA
```

But, if we use **ORG** directive we have set ds (segment) register to 0x0000 with ORG offset 0x7c00:

```nasm
[ORG 0x7c00]
   xor ax, ax ; make it zero
   mov ds, ax ; data segment = 0x0000
 
   mov si, msg
ch_loop:lodsb
   or al, al
   jz hang
   mov ah, 0x0E
   int 0x10
   jmp ch_loop
 
hang:
   jmp hang
 
msg   db 'Hello World', 13, 10, 0
 
   times 510-($-$$) db 0
   db 0x55
   db 0xAA
```

### Procedures

To reuse code often we write a separated code using **call** and **ret** instructions like the following.

```nasm
[ORG 0x7c00]
   xor ax, ax 
   mov ds, ax
 
   mov si, msg
   call bios_print ; call procedure
 
hang:
   jmp hang
 
msg   db 'Hello World', 13, 10, 0
 
bios_print: ; procedure label
   lodsb
   or al, al
   jz done
   mov ah, 0x0E
   int 0x10
   jmp bios_print
done:
   ret     ; return to caller point
 
   times 510-($-$$) db 0
   db 0x55
   db 0xAA
```

### NASM Macros

NASM macros let you pass a parameter to macro. Macros definition has to go before it`s being called.

```nasm
%macro BiosPrint 1
    mov si, word %1
ch_loop:lodsb
    or al, al
    jz done
    mov ah, 0x0E
    int 0x10
    jmp ch_loop
done:
%endmacro
 
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
```

### Include code

You can separate your long code in several files and include the files at the beging of your main code:

```nasm
jmp main
 
%include "othercode.inc"
 
main:
   ; ... rest of code here
```

### Reference

- http://wiki.osdev.org/Babystep2
- http://en.wikipedia.org/wiki/BIOS_interrupt_call

