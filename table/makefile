boot: boot.o
	ld boot.o -o boot

boot.o: boot.asm
	nasm -f elf64 boot.asm -o boot.o

run: boot
	./boot

clean:
	rm -f boot.o boot

