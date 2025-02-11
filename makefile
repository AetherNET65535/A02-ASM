main: main.o
	ld main.o -o main

main.o: main.asm
	nasm -f elf64 main.asm -o main.o

run: main
	./main

clean:
	rm -f main.o main

