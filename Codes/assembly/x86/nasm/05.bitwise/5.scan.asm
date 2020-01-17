;   scan.asm
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

; Scan posisi kemunculan pertama bit aktif di sebuah word atau dword dan menyimpan
; index tersebut ke operan tujuan.
; ZF akan bernilai 1 jika keseluruhan bit bernilai 0, jika tidak ZF bernilai 0

section .bss
    wblock  resw    1
    dblock  resd    1
    qblock  resq    1


section .text
_start:

; BSF (Bit Scan Forward)
    ; bsf reg, reg
    bsf      bx, ax                     ; 16-bit
    bsf     ebx, eax                    ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    bsf     rbx, rax                    ; 32-bit
    
    ; bsf reg, mem
    bsf      ax, word  [wblock]         ; 16-bit
    bsf     eax, dword [dblock]         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    bsf     rax, qword [qblock]         ; 64-bit

; BSR (Bit Scan Reverse)
    ; bsf reg, reg
    bsr      bx, ax                     ; 16-bit
    bsr     ebx, eax                    ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    bsr     rbx, rax                    ; 32-bit
    
    ; bsf reg, mem
    bsr      ax, word  [wblock]         ; 16-bit
    bsr     eax, dword [dblock]         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    bsr     rax, qword [qblock]         ; 64-bit


    hlt         ; Hentikan eksekusi