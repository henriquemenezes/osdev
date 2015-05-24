# x86
>  _is a family of backward compatible instruction set architectures (ISA) based on the Intel 8086 CPU._

### History of x86 ISA

The 8086 was introduced in 1978 as a fully 16-bit extension of Intel's 8-bit based 8080 microprocessor, with memory segmentation as a solution for addressing more memory than can be covered by a plain 16-bit address.

### Origin the term x86

The term "x86" came into being because the names of several successors to the Intel's 8086 processor ended in "86", including 80186, 80286, 80386 and 80486 processors.

### Intel x86 Microprocessors

8086  (1978) - 16-bit - First x86 microprocessors
80186 (1982) - 16-bit - New instructions and optimizations (clock)
80286 (1982) - 16-bit - MMU, Protected Mode and a larger address space
80386 (1985) IA-32 - 32-bit - 32-bit instruction set, MMU with paging
80486 (1989) - 32-bit - RISC-like pipelining, integrated x87 FPU, on-chip cache
Pentium (1993) - 32-bit - Superscalar 64-bit databus, faster FPU, MMX (2× 32-bit)
...

### x86 memory segmentation

About Address: 
	
	SEGMENT:OFFSET

There are often many different Segment:Offset pairs which can be used to address the same  location in your computer's memory. This scheme is a relative way of viewing computer memory as opposed to a Linear or Absolute addressing scheme.

Segment:Offset addressing was introduced at a time when the largest register in a CPU was only 16-bits long which meant it could address only 65,536 bytes (64 KiB[1]) of memory, directly. 

But everyone was hungry for a way to run much larger programs! Rather than create a CPU with larger register sizes (as some CPU manufacturers had done), the designers at Intel decided to keep the 16-bit registers for their new 8086 CPU and added a different way to access more memory,

If the designers had allowed the CPU to combine two registers into a high and low pair of 32-bits, it could have referenced up to 4 GiB[2] of memory in a linear fashion! 

	Absolute Memory Location = (Segment value * 16) + Offset value 

or Segment shifted one hexadecimal byte to the left; add an extra 0 to the end of the hex number

Example: F000:FFFD

          F0000 (Segment shifted one byte to left)
         + FFFD
         ------
Absolute: FFFFD

### Reference

- http://en.wikipedia.org/wiki/X86
- http://en.wikibooks.org/wiki/X86_Assembly/X86_Family
- http://en.wikipedia.org/wiki/Instruction_set
- http://thestarman.pcministry.com/asm/debug/Segments.html
- http://wiki.osdev.org/Segmentation
- http://en.wikipedia.org/wiki/X86_memory_segmentation
