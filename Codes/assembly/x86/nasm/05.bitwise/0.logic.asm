;   logic.asm
;
;   Operasi bitwise pada operasi logic.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o logic.o logic.asm
;
;   (win32)
;   $ nasm -f win32 -o logic.o logic.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o logic logic.o
;
;   (windows)
;   $ ld -m i386pe -o logic logic.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
;   Comment beberapa instruksi untuk menyesuaikan dengan target platform.
; 
;-----------------------------------------------------------------------------

    global _start

section .bss 
    bblock  resb    2
    wblock  resw    1
    dblock  resd    1
    qblock  resq    1


section .text
_start:

; AND (bitwise logical add)
    ; and reg, reg
    and      bl,  al                    ; 8-bit
    and      bh,  ah                    ; 8-bit
    and      bx,  ax                    ; 16-bit
    and     ebx, eax                    ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    and     rbx, rax                    ; 64-bit

    ; and reg, imm
    and      bl,  1                     ; 8-bit
    and      bh,  2                     ; 8-bit
    and      bx,  3                     ; 16-bit
    and     ebx,  4                     ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    and     rbx,  5                     ; 64-bit

    ; and reg, mem
    and      al, byte  [bblock]         ; 8-bit
    and      ah, byte  [bblock+1]       ; 8-bit
    and      ax, word  [wblock]         ; 16-bit
    and     eax, dword [dblock]         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    and     rax, qword [qblock]         ; 64-bit

    ; and mem, reg
    and     byte  [bblock],    al       ; 8-bit
    and     byte  [bblock+1],  ah       ; 8-bit
    and     word  [wblock],    ax       ; 16-bit
    and     dword [dblock],   eax       ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    and     qword [qblock],   rax       ; 64-bit

    ; and mem, imm
    and     byte  [bblock],   1         ; 8-bit
    and     byte  [bblock+1], 2         ; 8-bit
    and     word  [wblock],   3         ; 16-bit
    and     dword [dblock],   4         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    and     qword [qblock],   5         ; 64-bit


; OR  (bitwise logical or)
    ; or  reg, reg
    or       bl,  al                    ; 8-bit
    or       bh,  ah                    ; 8-bit
    or       bx,  ax                    ; 16-bit
    or      ebx, eax                    ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    or      rbx, rax                    ; 64-bit

    ; or  reg, imm
    or       bl,  1                     ; 8-bit
    or       bh,  2                     ; 8-bit
    or       bx,  3                     ; 16-bit
    or      ebx,  4                     ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    or      rbx,  5                     ; 64-bit

    ; or  reg, mem
    or       al, byte  [bblock]         ; 8-bit
    or       ah, byte  [bblock+1]       ; 8-bit
    or       ax, word  [wblock]         ; 16-bit
    or      eax, dword [dblock]         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    or      rax, qword [qblock]         ; 64-bit

    ; or  mem, reg
    or      byte  [bblock],    al       ; 8-bit
    or      byte  [bblock+1],  ah       ; 8-bit
    or      word  [wblock],    ax       ; 16-bit
    or      dword [dblock],   eax       ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    or      qword [qblock],   rax       ; 64-bit

    ; or  mem, imm
    or      byte  [bblock],   1         ; 8-bit
    or      byte  [bblock+1], 2         ; 8-bit
    or      word  [wblock],   3         ; 16-bit
    or      dword [dblock],   4         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    or      qword [qblock],   5         ; 64-bit


; XOR (bitwise logical exclusive or)
    ; xor reg, reg
    xor      bl,  al                    ; 8-bit
    xor      bh,  ah                    ; 8-bit
    xor      bx,  ax                    ; 16-bit
    xor     ebx, eax                    ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    xor     rbx, rax                    ; 64-bit

    ; xor reg, imm
    xor      bl,  1                     ; 8-bit
    xor      bh,  2                     ; 8-bit
    xor      bx,  3                     ; 16-bit
    xor     ebx,  4                     ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    xor     rbx,  5                     ; 64-bit

    ; xor reg, mem
    xor      al, byte  [bblock]         ; 8-bit
    xor      ah, byte  [bblock+1]       ; 8-bit
    xor      ax, word  [wblock]         ; 16-bit
    xor     eax, dword [dblock]         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    xor     rax, qword [qblock]         ; 64-bit

    ; xor mem, reg
    xor     byte  [bblock],    al       ; 8-bit
    xor     byte  [bblock+1],  ah       ; 8-bit
    xor     word  [wblock],    ax       ; 16-bit
    xor     dword [dblock],   eax       ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    xor     qword [qblock],   rax       ; 64-bit

    ; xor mem, imm
    xor     byte  [bblock],   1         ; 8-bit
    xor     byte  [bblock+1], 2         ; 8-bit
    xor     word  [wblock],   3         ; 16-bit
    xor     dword [dblock],   4         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    xor     qword [qblock],   5         ; 64-bit


; NOT (bitwise logical not)
    ; not reg 
    not      bl                 ; 8-bit
    not      bh                 ; 8-bit
    not      bx                 ; 16-bit
    not     ebx                 ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    not     rbx                 ; 64-bit

    ; not mem 
    not     byte  [bblock]      ; 8-bit
    not     byte  [bblock+1]    ; 8-bit
    not     word  [wblock]      ; 16-bit
    not     dword [dblock]      ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    not     qword [qblock]      ; 64-bit


; NEG (negation)
    ; neg reg 
    neg      bl                 ; 8-bit
    neg      bh                 ; 8-bit
    neg      bx                 ; 16-bit
    neg     ebx                 ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    neg     rbx                 ; 64-bit

    ; neg mem 
    neg     byte  [bblock]      ; 8-bit
    neg     byte  [bblock+1]    ; 8-bit
    neg     word  [wblock]      ; 16-bit
    neg     dword [dblock]      ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    neg     qword [qblock]      ; 64-bit


    hlt         ; Hentikan eksekusi