; 	hello-32b.asm
; 
; 	Cetak "Hello, World!" kemudian exit.
;	Kode ini bergantung pada libc (C library) dari compiler sehingga perlu
;	dilakukan perlakuan ekstra untuk linking.
;
; Assemble:
;	$ nasm -felf32 -o hello-32b.o hello-32b.asm
;
; Link:
;	(gcc and libc)
;   $ gcc -m32 -o hello-32b hello-32b.o
;
;-----------------------------------------------------

	global main
	extern printf

section .data
	message: db 'Hello, World!', 10, 0	

section .text
main:
	push 	message
	call 	printf
	add 	esp, 4

	mov 	eax, 0
	
	ret
	
