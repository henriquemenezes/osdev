# BabyStep2
> _Writing a message using the BIOS _

### BIOS

Many, but not all, BIOS interrupts expect *DS* register to be filled with a *segment* value in __Real Mode__. This is why many BIOS interrupts won't work in protected mode. So if you want to use *INT 10h/AH=0Eh* to print to the screen, then you need to make sure that your *segment:offset* for the characters to print is correct.

### BIOS Interruption call

+ INT 10h = Video BIOS Services
+ AH=0Eh  = Write Character in TTY Mode

### 


### Reference

- http://wiki.osdev.org/Babystep2
- http://en.wikipedia.org/wiki/BIOS_interrupt_call

