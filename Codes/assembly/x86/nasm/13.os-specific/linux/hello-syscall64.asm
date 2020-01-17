;   hello-syscall64.asm
; 
; 	Cetak "Hello, World!" kemudian exit.
;   Kode ini menggunakan Linux Syscall.
;
; Assemble:
;	$ nasm -felf64 -o hello-syscall64.o hello-syscall64.asm
;
; Link:
;   (gcc)
;   $ ld -o hello-syscall64 hello-syscall64.o
;
;-----------------------------------------------------

; // Padanan C program
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
;       RDI, RSI, RDX, RCX, R10, R8, R9
; Nilai kembalian disimpan di RAX

section .text
_start:
    ; cetak pesan
    mov     rax, 1          ; syscall = 1 (write)
    mov     rdi, 1          ; file descriptor = 1 (write to stdout)
    mov     rsi, message    ; the message 
    mov     rdx, msglen     ; the length of message
    syscall                 ; call the kernel

    ; keluar
    mov     rax, 60
    mov     rdi, 0
    syscall