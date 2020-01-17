;   immediate.asm
;
;   Data movement untuk immediate value.
;   Immediate value hanya dapat digunakan sebagai operan sumber, tidak bisa
;   digunakan sebagai operan tujuan.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o immediate.o immediate.asm
;
;   (win32)
;   $ nasm -f win32 -o immediate.o immediate.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o immediate immediate.o
;
;   (windows)
;   $ ld -m i386pe -o immediate immediate.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
;   Comment beberapa instruksi untuk menyesuaikan dengan target platform.
; 
;-----------------------------------------------------------------------------

    global _start

section .bss 
    bblock  resb    1
    wblock  resw    1
    dblock  resd    1
    qblock  resq    1


section .text
_start:

; MOV 
    ; tetapkan nilai register dengan immediate value.
    ; nilai dan register harus berukuran sesuai.

    mov      al, 0                  ; 8-bit         b0 00
    mov      bh, 1                  ; 8-bit         b7 01
    mov      cx, 2                  ; 16-bit        66 b9 02 00
    mov     edx, 3                  ; 32-bit        ba 03 00 00 00 
    ;  error jika dieksekusi pada 32-bit
    mov      r8, 4                  ; 64-bit        41 b8 04 00 00 00

    ; tetapkan nilai pada alamat memory dengan immediate value.
    ; nilai dan memory harus berukuran sesuai.

    mov     byte  [bblock], 1       ; 8-bit
    mov     word  [wblock], 2       ; 16-bit
    mov     dword [dblock], 3       ; 32-bit
    ;  error jika dieksekusi pada 32-bit
    mov     qword [qblock], 4       ; 64-bit


; PUSH
    ; Simpan immediate value ke stack (alamat yang ditunjuk ESP/RSP).
    ; Stack harus selalu aligned, ukuran elemen sama dengan ukuran memory alignment.
    ; Dimana alignment selalu:
    ;   * 4-byte pada program 32-bit
    ;   * 8-byte pada program 64-bit

    push    1           ; 8-bit         6a 01


    hlt         ; Hentikan eksekusi