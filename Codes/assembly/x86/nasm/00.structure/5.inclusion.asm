;   inclusion.asm
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o inclusion.o inclusion.asm
;
;   (win32)
;   $ nasm -f win32 -o inclusion.o inclusion.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o inclusion inclusion.o
;
;   (windows)
;   $ ld -m i386pe -o inclusion inclusion.o
; 
;-----------------------------------------------------------------------------

; Modul eksternal (code, data, atau keduanya) dapat disertakan / dimasukkan ke
; dalam module ini, seperti halnya melakukan import pada bahasa lain.

%include "external.inc"

    global _start


section .data


section .text
_start:
;   Modul lain dimasukkan sebagai bagian dari fungsi.
;   Dengan kata lain, isi dari modul akan disalin ke sini. Fungsi _start akan dikembangkan
;   dan instruksi di "instr.inc" akan disalin.

    %include "instr.inc"
    
    hlt         ; Hentikan eksekusi