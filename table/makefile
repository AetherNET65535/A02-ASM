boot: boot.o
	ld boot.o -o boot

boot.o: boot.asm
	nasm -f bin boot.asm -o boot.bin

run: boot
	./boot

clean:
	rm -f boot.o boot

