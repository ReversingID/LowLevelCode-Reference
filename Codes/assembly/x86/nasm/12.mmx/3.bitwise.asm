;   bitwise.asm
;
;   Operasi pada register SIMD.
;   Operasi bitwise
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o bitwise.o bitwise.asm
;
;   (win32)
;   $ nasm -f win32 -o bitwise.o bitwise.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o bitwise bitwise.o
;
;   (windows)
;   $ ld -m i386pe -o bitwise bitwise.o
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

; AND
    ; pand      mm, mm/m64
    pand        mm0, mm1 
    pand        mm0, qword [qblock]

; AND NOT
    ; pandn     mm, mm/m64
    pandn       mm0, mm1 
    pandn       mm0, qword [qblock]

; OR
    ; por       mm, mm/m64
    por         mm0, mm1 
    por         mm0, qword [qblock]

; XOR
    ; pxor      mm, mm/m64
    pxor        mm0, mm1 
    pxor        mm0, qword [qblock]

; Shift
    ; (logical) shift left words, shift in zeros
    ; psllw     mm1, imm8
    psllw       mm0, 3
    ; psllw     mm1, mm/m64
    psllw       mm0, mm1 
    psllw       mm0, qword [qblock]
    
    ; pslld     mm1, imm8
    pslld       mm0, 3
    ; pslld     mm1, mm/m64
    pslld       mm0, mm1 
    pslld       mm0, qword [qblock]
    
    ; psllq     mm1, imm8
    psllq       mm0, 3
    ; psllq     mm1, mm/m64
    psllq       mm0, mm1 
    psllq       mm0, qword [qblock]


    ; (arithmetic) shift right words, shift in sign bits
    ; psraw     mm1, imm8
    psraw       mm0, 3
    ; psraw     mm1, mm/m64
    psraw       mm0, mm1 
    psraw       mm0, qword [qblock]
    
    ; psrad     mm1, imm8
    psrad       mm0, 3
    ; psrad     mm1, mm/m64
    psrad       mm0, mm1 
    psrad       mm0, qword [qblock]


    ; (logical) shift right words, shift in zeros
    ; psrlw     mm1, imm8
    psrlw       mm0, 3
    ; psrlw     mm1, mm/m64
    psrlw       mm0, mm1 
    psrlw       mm0, qword [qblock]
    
    ; psrld     mm1, imm8
    psrld       mm0, 3
    ; psrld     mm1, mm/m64
    psrld       mm0, mm1 
    psrld       mm0, qword [qblock]
    
    ; psrlq     mm1, imm8
    psrlq       mm0, 3
    ; psrlq     mm1, mm/m64
    psrlq       mm0, mm1 
    psrlq       mm0, qword [qblock]



    hlt         ; Hentikan eksekusi