;   swap.asm
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o scan.o scan.asm
;
;   (win32)
;   $ nasm -f win32 -o scan.o scan.asm
;
; Link:
;   $ gcc -m32 -o scan scan.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

    global _start

; balikkan (reverse) urutan byte dari register, mengubah Endian
; bit 0 hingga 7 ditukar (swap) dengan bit 24 hingga 31
; bit 8 hingga 15 ditukar (swap) dengan bit 16 hingga 23

section .text
_start:

; bswap reg
    bswap   ebx                         ; 32-bit
    bswap   rbx                         ; 64-bit


    hlt         ; Hentikan eksekusi