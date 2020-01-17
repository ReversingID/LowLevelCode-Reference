;   comparison.asm
;
;   Operasi pada register SIMD.
;   Perbandingan nilai secara paralel.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o comparison.o comparison.asm
;
;   (win32)
;   $ nasm -f win32 -o comparison.o comparison.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o comparison comparison.o
;
;   (windows)
;   $ ld -m i386pe -o comparison comparison.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

; Terdapat 8 register MMX 64-bit:
;   MM0, MM1, MM2, MM3, MM4, MM5, MM6, MM7

    global _start

section .data 
    qblock  dq 0xCAFEBABE, 0x13510030


section .text 
_start:

; Equality
; bandingkan setiap unit di grup untuk periksa persamaan

    ; pcmpeqb   mm, mm/64
    pcmpeqb     mm1, mm0 
    pcmpeqb     mm0, qword [qblock]

    ; pcmpeqw   mm, mm/64
    pcmpeqw     mm1, mm0 
    pcmpeqw     mm0, qword [qblock]

    ; pcmpeqd   mm, mm/64
    pcmpeqd     mm1, mm0 
    pcmpeqd     mm0, qword [qblock]

; Greater than
; bandingkan setiap unit di grup untuk nilai lebih besar

    ; pcmpgtb   mm, mm/64
    pcmpgtb     mm1, mm0 
    pcmpgtb     mm0, qword [qblock]

    ; pcmpgtw   mm, mm/64
    pcmpgtw     mm1, mm0 
    pcmpgtw     mm0, qword [qblock]

    ; pcmpgtd   mm, mm/64
    pcmpgtd     mm1, mm0 
    pcmpgtd     mm0, qword [qblock]



    hlt         ; Hentikan eksekusi