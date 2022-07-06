AS = nasm
CC = gcc
NASMFLAGS = win64
MAIN = 7503-TP-12-105238
OBJETO = 7503-TP-12-105238.o
EXEC = 7503-TP-12-105238.exe
FILES = 7503-TP-12-105238.asm makefile  README.md

#nasm -f win64 7503-TP-12-105238.asm -o 7503-TP-12-105238.o
#gcc 7503-TP-12-105238.o -o 7503-TP-12-105238.exe
#./7503-TP-12-105238.exe

compile:
	$(AS) -f $(NASMFLAGS) $(MAIN).asm -o $(OBJETO)
	$(CC) $(OBJETO) -o $(EXEC)

run: compile
	cls 			
	- ./$(EXEC)

zip: 
	zip -r $(MAIN).zip $(FILES)

.PHONY: clean
clean:
	- del -rf $(OBJETO) $(EXEC) 