;   hello-extern.asm
;
;   Panggil function eksternal cetak() kemudian exit.
;   Function akan mencetak "Hello, World!".
;
; Assemble:
;   $ gcc -c -o cetak.o cetak.c
;	$ nasm -felf64 -o hello-extern.o hello-extern.asm
;
; Link:
;   (gcc)
;   $ ld -o hello-extern -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc cetak.o hello-extern.o
;
;-----------------------------------------------------

    global  _start
    extern  cetak

section .text
_start:
    ; Panggil fungsi cetak()
    call   cetak

    ; Terminate program
    mov     rax, 60
    mov     rdi, 0
    syscall