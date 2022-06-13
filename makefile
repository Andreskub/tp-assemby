AS = nasm
CC = gcc
NASMFLAGS = win64
MAIN = tp.asm
OBJETO = tp.o
EXEC = tp.exe
FILES = tp.asm makefile  README.md

compile:
	$(AS) -f $(NASMFLAGS) $(MAIN) -o $(OBJETO)
	$(CC) ./$(OBJETO) -o $(EXEC)

run: compile
	cls	
	- ./$(EXEC)

zip: 
	zip -r $(EXEC).zip *.c *.h $(FILES)

.PHONY: clean
clean:
	- del -rf $(OBJETO) $(EXEC) 