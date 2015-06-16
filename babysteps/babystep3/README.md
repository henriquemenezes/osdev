# BabyStep3
> _A look at machine code_

### A look at machine code (opcodes, prefix, etc)

Assemble the source file:

```bash
nasm encodeN.asm -f bin -o encodeN.bin
```

#### Linux

```bash
$ hexdump encodeN.bin     # Little-endian
$ hexdump -C encodeN.bin  # Big-endian
$ hd encodeN.bin          # Big-endian
```

#### Windows

```bat
c:\>debug encodeN.bin
```

#### Opcodes

```nasm
mov cx, 0xFF
times 510-($-$$) db 0
db 0x55
db 0xAA
```

Results in:

```
00000000  b9 ff 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
```

Look the MOV opcode in [Instruction Format](http://www.baldwin.cx/386htm/s17_02.htm) and [MOV opcode](http://www.baldwin.cx/386htm/s17_02.htm):

| Opcode  | Instruction      | Clocks      | Description                     |
|---------|------------------|-------------|---------------------------------|
| B8 + rw | MOV reg16,imm16  | 2           | Move immediate word to register |

Register code:

|   rb   |  rw    |   rd    |
|--------|--------|---------|
| AL = 0 | AX = 0 | EAX = 0 |
| CL = 1 | **CX = 1** | ECX = 1 |
| DL = 2 | DX = 2 | EDX = 2 |
| BL = 3 | BX = 3 | EBX = 3 |
| AH = 4 | SP = 4 | ESP = 4 |
| CH = 5 | BP = 5 | EBP = 5 |
| DH = 6 | SI = 6 | ESI = 6 |
| BH = 7 | DI = 7 | EDI = 7 |

Where:

+ rb = r8 = register byte (8 bits)
+ rw = r16 = register word (16 bits)
+ rd = r32 = register doubleword (32 bits)

### References

+ http://ref.x86asm.net/coder32.html
+ http://www.baldwin.cx/386htm/s17_02.htm
+ http://www.baldwin.cx/386htm/s17_02.htm