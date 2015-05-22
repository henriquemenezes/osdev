
boot.bin: boot.asm
	nasm -f bin boot.asm -o boot.bin

floppy: boot.bin
	sudo dd if=boot.bin of=/dev/fd0

qemu: floppy
	sudo qemu-system-x86_64 -fda /dev/fd0

clean: 
	rm *.bin