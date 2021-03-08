
CC		= gcc
CFLAGS	= -c -g -Wall -fno-stack-protector -nostdlib
PROGS	= libmini.so libmini64.o libmini.o jmp1 alarm1 alarm2 alarm3

all: $(PROGS)

jmp1: start.o jmp1.c
	$(CC) $(CFLAGS) -I. -I.. -DUSEMINI jmp1.c
	ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -o jmp1 jmp1.o start.o -L. -L.. -lmini
	rm jmp1.o

alarm3: start.o alarm3.c
	$(CC) $(CFLAGS) -I. -I.. -DUSEMINI alarm3.c
	ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -o alarm3 alarm3.o start.o -L. -L.. -lmini
	rm alarm3.o

alarm2: start.o alarm2.c
	$(CC) $(CFLAGS) -I. -I.. -DUSEMINI alarm2.c
	ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -o alarm2 alarm2.o start.o -L. -L.. -lmini
	rm alarm2.o

alarm1: start.o alarm1.c
	$(CC) $(CFLAGS) -I. -I.. -DUSEMINI alarm1.c
	ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -o alarm1 alarm1.o start.o -L. -L.. -lmini
	rm alarm1.o

start.o: start.asm
	yasm -f elf64 -DYASM -D__x86_64__ -DPIC start.asm -o start.o

libmini.so: libmini64.o libmini.o
	ld -shared -o libmini.so libmini64.o libmini.o

libmini64.o: libmini64.asm
	yasm -f elf64 -DYASM -D__x86_64__ -DPIC libmini64.asm -o libmini64.o

libmini.o: libmini.c
	$(CC) $(CFLAGS) -fPIC libmini.c

clean:
	rm -f $(PROGS)

rmo:
	rm -f alarm1.o alarm2.o alarm3.o jmp1.o
