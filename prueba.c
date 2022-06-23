#include <stdio.h>
#include <string.h>

//gcc -S -masm=intel prueba.c -o prueba.asm

char conjutnoA[] = "JKA6AS48DFAL";
char conjutnoB[] = "JKA6AS48DFAL";


int main(){
    int i;
    for (i = 0; i < strlen(conjutnoA); i++){
        char actual = conjutnoA[i];
        printf("Tenemos el caracter '%c'\n", actual);
    }
}
