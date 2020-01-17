;   rotate.asm
;
;   Bit rotating.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o rotate.o rotate.asm
;
;   (win32)
;   $ nasm -f win32 -o rotate.o rotate.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o rotate rotate.o
;
;   (windows)
;   $ ld -m i386pe -o rotate rotate.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
;   Comment beberapa instruksi untuk menyesuaikan dengan target platform.
; 
;-----------------------------------------------------------------------------

    global _start

; Rotate (rotasi) memindahkan bit dari ke kiri (atau kanan).
; Bit yang melebihi ujung register, akan dimasukkan kembali ke lokasi yang kosong.

section .bss 
    bblock  resb    2
    wblock  resw    1
    dblock  resd    1
    qblock  resq    1


section .text
_start:

; ROL (rotate left)
    ; rol reg, imm
    rol      bl,  1                     ; 8-bit
    rol      bh,  2                     ; 8-bit
    rol      bx,  3                     ; 16-bit
    rol     ebx,  4                     ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    rol     rbx,  5                     ; 64-bit

    ; rol mem, imm
    rol     byte  [bblock],   1         ; 8-bit
    rol     byte  [bblock+1], 2         ; 8-bit
    rol     word  [wblock],   3         ; 16-bit
    rol     dword [dblock],   4         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    rol     qword [qblock],   5         ; 64-bit


; ROR (rotate right)
    ; ror reg, imm
    ror      bl,  1                     ; 8-bit
    ror      bh,  2                     ; 8-bit
    ror      bx,  3                     ; 16-bit
    ror     ebx,  4                     ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    ror     rbx,  5                     ; 64-bit

    ; ror mem, imm
    ror     byte  [bblock],   1         ; 8-bit
    ror     byte  [bblock+1], 2         ; 8-bit
    ror     word  [wblock],   3         ; 16-bit
    ror     dword [dblock],   4         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    ror     qword [qblock],   5         ; 64-bit
    

; RCL (rotate left with carry)
    ; rcl reg, imm
    rcl      bl,  1                     ; 8-bit
    rcl      bh,  2                     ; 8-bit
    rcl      bx,  3                     ; 16-bit
    rcl     ebx,  4                     ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    rcl     rbx,  5                     ; 64-bit

    ; rcl mem, imm
    rcl     byte  [bblock],   1         ; 8-bit
    rcl     byte  [bblock+1], 2         ; 8-bit
    rcl     word  [wblock],   3         ; 16-bit
    rcl     dword [dblock],   4         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    rcl     qword [qblock],   5         ; 64-bit


; RCR (rotate right with carry)
    ; rcr reg, imm
    rcr      bl,  1                     ; 8-bit
    rcr      bh,  2                     ; 8-bit
    rcr      bx,  3                     ; 16-bit
    rcr     ebx,  4                     ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    rcr     rbx,  5                     ; 64-bit

    ; rcr mem, imm
    rcr     byte  [bblock],   1         ; 8-bit
    rcr     byte  [bblock+1], 2         ; 8-bit
    rcr     word  [wblock],   3         ; 16-bit
    rcr     dword [dblock],   4         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    rcr     qword [qblock],   5         ; 64-bit


    hlt         ; Hentikan eksekusi