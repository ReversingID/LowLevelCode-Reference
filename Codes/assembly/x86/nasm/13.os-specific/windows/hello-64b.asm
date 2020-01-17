; 	hello-64b.asm
; 
; 	Cetak "Hello, World!" kemudian exit.
;	Kode ini bergantung pada libc (C library) dari compiler sehingga perlu
;	dilakukan perlakuan ekstra untuk linking.
;
; Assemble:
;	$ nasm -fwin64 -o hello-64b.obj hello-64b.asm
;
; Link:
;	(gcc and libc)
;   $ gcc -o hello-64b.exe hello-64b.obj
;
; Note:
;	Kode menghasilkan segmentation fault di akhir eksekusi karena 
;	tidak menggunakan CRT. Ketika return dari main(), processor akan
; 	mencoba mengeksekusi instruksi pada alamat 0.
;
;-----------------------------------------------------

	global main
	extern printf

section .data
	message: db 'Hello, World!', 13, 10, 0	

section .text
main:
	mov 	rcx, qword message 
	call 	printf
	ret
	
