all:
	nasm -f bin boot.asm -o boot.bin

run: all
	qemu-system-x86_64 -drive format=raw,file=boot.bin

clean:
	rm -f boot.bin
