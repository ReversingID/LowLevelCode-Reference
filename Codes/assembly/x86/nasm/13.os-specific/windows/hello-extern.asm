;   hello-extern.asm
;
;   Panggil function eksternal cetak() kemudian exit.
;   Function akan mencetak "Hello, World!".
;
; Assemble:
;   $ gcc -c -o cetak.o cetak.c
;   $ nasm -fwin64 -o hello-extern.obj hello-extern.asm
;
; Link:
;   (gcc)
;   $ ld -o hello-extern cetak.o hello-extern.obj
;
;-----------------------------------------------------

    global  _start
    extern  cetak

section .text
_start:
    ; Panggil fungsi cetak()
    call    cetak

    ; Hentikan program
    mov     rax, 60
    mov     rdi, 0
    syscall