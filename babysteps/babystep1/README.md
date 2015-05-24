# BabyStep1
> _Your first boot sector_

### Code

This code is the smallest possible example of booting code from a floppy. The CPU starts in REAL MODE and the BIOS loads this code at Address 0000:7c00.

### Quick review:

1. Boot sector loaded by BIOS is 512 bytes
2. The code in the boot sector of the disk is loaded by the BIOS at 0000:7c00
3. Machine starts in Real Mode (16 bits with direct access to BIOS routines)
4. Be aware that the CPU is being interrupted unless you issue the CLI assembly command 

### Creating disk image

The code is assembled in NASM and copied to floppy using partcopy,dd, or debug (Windows). Then you simply boot from the /dev/fd0 (floppy). 

	$ nasm boot.asm -f bin -o boot.bin
	$ dd if=boot.bin of=/dev/fd0 

