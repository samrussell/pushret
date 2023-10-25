nasm -f elf pushret.asm -o build/pushret.o
ld -m elf_i386 -s -o build/pushret build/pushret.o
nasm -f elf stackops.asm -o build/stackops.o
ld -m elf_i386 -s -o build/stackops build/stackops.o
