; 	hello-32b.asm
; 
; 	Cetak "Hello, World!" kemudian exit.
;	Kode ini bergantung pada libc (C library) dari compiler sehingga perlu
;	dilakukan perlakuan ekstra untuk linking.
;
; Assemble:
;	$ nasm -fwin32 -o hello-32b.obj hello-32b.asm
;
; Link:
;	(gcc and libc)
;   $ gcc -m32 -o hello-32b.exe hello-32b.obj
;
;-----------------------------------------------------

; GCC di WIndows memerlukan awalan _ (underscore) untuk nama fungsi
	global _main
	extern _printf

section .data
	message: db 'Hello, World!', 10, 0	

section .text
_main:
	push 	message
	call 	_printf
	add 	esp, 4
	ret
	
