;   hello-syscall32.asm
; 
; 	Cetak "Hello, World!" kemudian exit.
;   Kode ini menggunakan Linux Syscall.
;
; Assemble:
;	$ nasm -felf32 -o hello-syscall32.o hello-syscall32.asm
;
; Link:
;   (gcc)
;   $ gcc -m32 -o hello-syscall32 hello-syscall32.o
;
;-----------------------------------------------------

; // Padanan di C program
; int main()
; {
;   write(1, message, msglen);
; }

    global  _start

section .data
    message db 'Hello, World', 10
    msglen  equ $ - message

; The ABI
; syscall di RAX
; Argumen diletakkan di register, dari kiri ke kanan (awal hingga akhir):
;       EBX, ECX, EDX, ESI, EDI, EBP
; Nilai kembalian disimpan di RAX

section .text
_start:
    ; cetak pesan
    mov     eax, 4          ; syscall = 4 (write)
    mov     ebx, 1          ; file descriptor = 1 (write to stdout)
    mov     ecx, message    ; the message
    mov     edx, msglen     ; the length of message
    int     80h             ; call the kernel

    ; keluar
    mov     eax, 1
    mov     ebx, 0
    int     80h