;   custom-section.asm
;
;   NASM mendukung custom section.
;   Mendeklarasikan custom-section, mengisinya, dan merujuk dari manapun.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o custom-section.o custom-section.asm
;
;   (win32)
;   $ nasm -f win32 -o custom-section.o custom-section.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o custom-section custom-section.o
;
;   (windows)
;   $ ld -m i386pe -o custom-section custom-section.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
;
;   Gunakan viewer untuk melihat sections pada executable header.
; 
;-----------------------------------------------------------------------------

    global _start

; Konstanta
MAGIC   equ 0xBADBABE
MBALIGN equ 1 << 0
MEMINFO equ 1 << 1

; Deklarasi user-defined section
section .custom
align 4         ; the data here should be 4-byte aligned
    magic: dd MAGIC
    dd MBALIGN
    dd MEMINFO


section .text
_start:

; Akses konten dari custom-section dapat dilakukan seperti akses
; section lain.
    push        dword magic
    hlt         ; Hentikan eksekusi
