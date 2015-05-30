# NASM

The Netwide Assembler, NASM, is an 80x86 and x86-64 assembler designed for portability and modularity. It supports a range of object file formats, including Linux and BSD a.out, ELF, COFF, Mach-O, Microsoft 16-bit OBJ, Win32 and Win64. It will also output plain binary files. Its syntax is designed to be simple and easy to understand, similar to Intel's but less complex. It supports all currently known x86 architectural extensions, and has strong support for macros. 

### Running NASM

To assemble a file, you issue a command of the form

	$ nasm -f <format> <filename> [-o <output>]

For example,

	$ nasm -f elf myfile.asm

will assemble myfile.asm into an ELF object file myfile.o. And

	$ nasm -f bin myfile.asm -o myfile.com

will assemble myfile.asm into a raw binary file myfile.com.

To produce a listing file, with the hex codes output from NASM displayed on the left of the original sources, use the -l option to give a listing file name, for example:

	$ nasm -f coff myfile.asm -l myfile.lst

### Reference

- http://www.nasm.us/doc/nasmdoc1.html