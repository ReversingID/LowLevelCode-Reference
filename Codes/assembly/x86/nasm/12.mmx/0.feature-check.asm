;   feature-check.asm
;
;   Operasi pada register SIMD.
;   Periksa keberadaan register MMX
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o feature-check.o feature-check.asm
;
;   (win32)
;   $ nasm -f win32 -o feature-check.o feature-check.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o feature-check feature-check.o
;
;   (windows)
;   $ ld -m i386pe -o feature-check.exe feature-check.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

; Terdapat 8 register MMX 64-bit:
;   MM0, MM1, MM2, MM3, MM4, MM5, MM6, MM7

    global _start

section .data 


section .text 
_start:

; Periksa dukungan fitur MMX dengan instruksi CPUID
; Bit 23 di CPUID akan aktif bila MMX didukung oleh processor

    mov     eax, 1
    cpuid
    
    mov     eax, edx
    shr     eax, 23
    and     eax, 1


    hlt         ; Hentikan eksekusi