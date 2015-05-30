# QEMU
> _Quick Emulator is a free and open-source hosted hypervisor that performs hardware virtualization_

Once QEMU has been installed, it should be ready to run a guest OS from a disk image. This image is a file that represents the data on a hard disk. From the perspective of the guest OS, it actually is a hard disk, and it can create its own filesystem on the virtual disc.

You can download a few guest OS images from the QEMU website, including a simple 8MB image of a Linux distro. To run it, download and unzip the image in a folder and run the QEMU command.

	$ qemu linux-0.2.img

Replace linux-0.2.img with the name of your guest OS image file.

If it has a GUI and you want to use your mouse with it, double-click on the window and QEMU will grab your mouse. To make QEMU release your mouse again, hold down the Control and Alt keys simultaneously, then let go - your mouse will be released back to X.

### Image types

QEMU supports several image types. The "native" and most flexible type is qcow2, which supports copy on write, encryption, compression, and VM snapshots.

raw 
	(default) the raw format is a plain binary image of the disc image, and is very portable. On filesystems that support sparse files, images in this format only use the space actually used by the data recorded in them.
cloop 
	Compressed Loop format, mainly used for reading Knoppix and similar live CD image formats
cow 
	copy-on-write format, supported for historical reasons only and not available to QEMU on Windows
qcow 
	the old QEMU copy-on-write format, supported for historical reasons and superseded 	by qcow2
qcow2 
	QEMU copy-on-write format with a range of special features, including the ability to take multiple snapshots, smaller images on filesystems that don't support sparse files, optional AES encryption, and optional zlib compression
vmdk 
	VMware 3 & 4, or 6 image format, for exchanging images with that product
vdi 
	VirtualBox 1.1 compatible image format, for exchanging images with VirtualBox.

### Creating an image

To set up your own guest OS image, you first need to create a blank disc image. QEMU has the qemu-img command for creating and manipulating disc images, and supports a variety of formats. If you don't tell it what format to use, it will use raw files. The "native" format for QEMU is qcow2, and this format offers some flexibility. Here we'll create a 3GB qcow2 image to install Windows XP on:

	$ qemu-img create -f qcow2 winxp.img 3G

The easiest way to install a guest OS is to create an ISO image of a boot CD/DVD and tell QEMU to boot off it. Many free operating systems can be downloaded from the Internet as bootable ISO images, and you can use them directly without having to burn them to disc.

Here we'll boot off an ISO image of a properly licensed Windows XP boot disc. We'll also give it 256MB of RAM.

	$ qemu -m 256 -hda winxp.img -cdrom winxpsp2.iso -boot d

To boot from a real CD or DVD, tell QEMU where to find it. On Linux systems, you can usually use a logical device name like /dev/cdrom or /dev/dvd, or the physical name of the device, e.g. /dev/sr0

	$ qemu -m 256 -hda winxp.img -cdrom /dev/cdrom -boot d

QEMU will boot from the ISO image or CD/DVD and run the install program. If you have two screens, move the QEMU screen off to the spare one where you can keep an eye on the installer, but get on with something else - it will take a while!

Once the guest OS has installed successfully, you can shutdown the guest OS (e.g. in Windows XP, click on Start and then Shutdown). Once it has shutdown, start QEMU up with the kqemu kernel module to give it a little more speed.

	$ qemu -m 256 -hda winxp.img -cdrom winxpsp2.iso -kernel-kqemu

If you are running an x86-64 Linux (i.e. 64-bit), you will need to run the x86-64 version of QEMU to be able to utilise kqemu:

	$ qemu-system-x86_64 -m 256 -hda winxp.img -cdrom winxpsp2.iso -kernel-kqemu
