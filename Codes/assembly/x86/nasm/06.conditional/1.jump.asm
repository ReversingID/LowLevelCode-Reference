;   jump.asm
;
;   Jumps dan pengalihan alur programn.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o jump.o jump.asm
;
;   (win32)
;   $ nasm -f win32 -o jump.o jump.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o jump jump.o
;
;   (windows)
;   $ ld -m i386pe -o jump jump.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

    global _start

; Jump (lompat) adalah perpindahan alur eksekusi (execution flow) ke alamat lain.
; Alamat dapat berupa label atau nilai di dalam register.

; Tersedia dua tipe jump: unconditional jump dan conditional jump.

; Unconditional Jump adalah jump dimana eksekusi akan dipaksa untuk berpindah ke 
; alamat tertentu, apapun state atau kondisi dari CPU (dan flag).

; Conditional Jump adalah jump dimana perpindahan hanya terjadi apabila kondisi
; tertentu terpenuhi. Kondisi dilihat dari status register (EFLAGS).
; Lihat juga 'platform.md' untuk informasi tambahan tentang Status Register.

; Umumnya terdapat instruksi CMP atau TEST yang akan mempengaruhi EFLAGS sebelum
; dilakukan Conditional Jump.

; Jump sebagai basic block dapat membangun beragam control-flow di bahasa pemrograman
; tingkat tinggi.

section .text
_start:

; JMP (unconditional jump)
    ; lompat ke target (label) seketika.
    jmp     .target

; conditional jump
; signed
; JE  (Jump if Equal)
    ; lompat jika status ZF aktif.
    je      .target

; JNE (Jump if Not Equal) 
    ; lompat jika status ZF nonaktif
    jne     .target

; JG  (Jump if Greater)
    ; lompat jika status ~(SF^OF) & ~ZF terpenuhi
    jg      .target 
    jnle    .target    ; sepadan dengan JG   

; JGE (Jump if Greater or Equal)
    ; lompat jika status ~(SF^OF) terpenuhi
    jge     .target 
    jnl     .target     ; sepadan dengan JGE

; JL  (Jump if Lower)
    ; lompat jika status SF^OF
    jl      .target
    jnge    .target    ; sepadan dengan JL

; JLE (Jump if Lower or Equal)
    ; lompat jika status (SF^OF) | ZF
    jle     .target
    jng     .target     ; sepadan dengan JLE

; JS (Jump if negative / Signed)
    ; lompat jika status SF is set
    js      .target 

; JNS (Jump is nonnegative / Not Signed)
    ; lompat jika status SF nonaktif
    jns     .target


; unsigned
; JZ  (Jump if Zero)
    ; lompat jika status ZF is set
    jz      .target     ; sepadan dengan JE

; JNZ (Jump if Not Zero)
    ; lompat jika status ZF nonaktif
    jnz     .target     ; sepadan dengan JNE

; JA  (Jump if above)
    ; lompat jika status ~CF & ~ZF terpenuhi
    ja      .target
    jnbe    .target    ; sepadan dengan JA

; JAE (Jump if above or Equal)
    ; lompat jika status CF nonaktif
    jae     .target
    jnb     .target    ; sepadan dengan JAE

; JB  (Jump if below)
    ; lompat jika status CF is set
    jb      .target
    jnae    .target    ; sepadan dengan JB

; JBE (Jump if below or Equal)
    ; lompat jika status CF | ZF terpenuhi
    jbe     .target 
    jna     .target    ; sepadan dengan JBE

.target:

    hlt         ; Hentikan eksekusi