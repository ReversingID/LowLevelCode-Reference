/**
    hello-extern.c
 
    Panggil function eksternal cetak() kemudian exit.
    Function akan mencetak "Hello, World!".

Compile:
	$ gcc -c -o cetak.o cetak.c
 
*/
#include <stdio.h>

extern int cetak();

int cetak()
{
    printf("Hello, World\n");
    return 0;
}