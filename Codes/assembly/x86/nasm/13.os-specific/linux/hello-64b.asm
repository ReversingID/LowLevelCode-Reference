; 	hello-64b.asm
; 
; 	Cetak "Hello, World!" kemudian exit.
;	Kode ini bergantung pada libc (C library) dari compiler sehingga perlu
;	dilakukan perlakuan ekstra untuk linking.
;
; Assemble:
;	$ nasm -felf64 -o hello-64b.o hello-64b.asm
;
; Link:
;	(gcc and libc)
;   $ gcc -o hello-64b hello-64b.o
;
;-----------------------------------------------------

	global main
	extern printf

section .data
	message: db 'Hello, World!', 10, 0

section .text
main:
	; sesuaikan alignment
	sub		rsp, 8

	; push message
	mov  	rdi, message
	call 	printf

	add		rsp, 8
	ret
	
