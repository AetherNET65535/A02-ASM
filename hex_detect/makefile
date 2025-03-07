all: boot.bin os.img

boot.bin: boot.asm
	nasm -f bin boot.asm -o boot.bin

os.img: boot.bin
	# 创建 50M 大小的空磁盘镜像
	qemu-img create -f raw os.img 50M
	dd if=boot.bin of=os.img bs=512 count=1 conv=notrunc

run: os.img
	qemu-system-i386 -drive format=raw,file=os.img -nographic

clean:
	rm -f boot.bin os.img
