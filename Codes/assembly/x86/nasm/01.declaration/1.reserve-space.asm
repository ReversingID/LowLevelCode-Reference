;   reserve-space.asm
;
;   Pesan ruang untuk uninitialized data di section .bss.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o reserve-space.o reserve-space.asm
;
;   (win32)
;   $ nasm -f win32 -o reserve-space.o reserve-space.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o reserve-space reserve-space.o
;
;   (windows)
;   $ ld -m i386pe -o reserve-space reserve-space.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
; 
;-----------------------------------------------------------------------------

    global _start

; Pesan ruang di memory
;
; Ketika menghasilkan binary code, NASM akan mengalokasikan ruang untuk untaian
; byte di section terkait. untaian data ini bersifat tak terinisiasi (uninitialized)
; atau akan terisi dengan angka 0.
;
;
; Pemberian label tidak diwajibkan, tapi jika data akan diakses maka pelabelan
; harus dilakukan.
;
; Reservasi ruang memori dapat dilakukan dengan instruksi resX dengan X adalah 
; tipe data yang diinginkan.
;   resb = pesan bytes (8-bit)
;   resw = pesan words (16-bits)
;   resd = pesan double words (32-bits)
;   resq = pesan quad words (64-bits) atau double-precision float
;   rest = pesan 80-bits floating-point constant (extended-precision float)

section .bss
    bbuffer:    resb    5       ; pesan 5 bytes space 
    wbuffer:    resw    1       ; pesan a word
    qbuffer:    resd    10      ; array of qword

section .text
_start:
    hlt         ; Hentikan eksekusi