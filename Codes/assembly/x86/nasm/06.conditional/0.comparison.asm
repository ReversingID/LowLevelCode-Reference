;   comparison.asm
;
;   Mekanisme perbandingan sederhana.
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
;-----------------------------------------------------------------------------

    global _start

; Comparison (perbandingan) adalah sekelompok instruksi untuk membandingkan dua nilai
; dan menghasilkan kondisi sama (equal) atau tidak sama (inequal).
; Terdapat dua instruksi: cmp, test.
; Kedua instruksi membutuhkan dua nilai: LHS (Left-Hand Side) dan RHS (Right-Hand Side).
;
; Perbandingan akan menghasilkan perubahan pada flag register dan dapat diartikan 
; sebagai tiga kondisi:
;   - bilangan positif: nilai DST lebih besar daripada nilai SRC
;   - nol: nilai DST sama dengan nilai SRC
;   - bilangan negatif: nilai DST lebih kecil daripada nilai SRC 

section .data
    bblock db 135
    wblock dw 0xCAFE
    dblock dd 0xCAFEBABE
    qblock dq 0x13510030


section .text
_start:

; CMP (Compare)
    ; cmp LHS, RHS
    ;
    ; Instruksi ini mengurangkan operan sumber (RHS) dari operan tujuan (LHS),
    ; kemudian mengecek hasil. Hasil operasi tidak disimpan di manapun.

    ; cmp   reg, reg
    cmp      bl,  al                    ; 8-bit
    cmp      bh,  ah                    ; 8-bit
    cmp      bx,  ax                    ; 16-bit
    cmp     ebx, eax                    ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    cmp     rbx, rax                    ; 64-bit

    ; cmp   reg, imm
    cmp      bl,  1                     ; 8-bit
    cmp      bh,  2                     ; 8-bit
    cmp      bx,  3                     ; 16-bit
    cmp     ebx,  4                     ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    cmp     rbx,  5                     ; 64-bit

    ; cmp   reg, mem
    cmp      al, byte  [bblock]         ; 8-bit
    cmp      ah, byte  [bblock]         ; 8-bit
    cmp      ax, word  [wblock]         ; 16-bit
    cmp     eax, dword [dblock]         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    cmp     rax, qword [qblock]         ; 64-bit

    ; cmp   mem, reg
    cmp     byte  [bblock],    al       ; 8-bit
    cmp     byte  [bblock],    ah       ; 8-bit
    cmp     word  [wblock],    ax       ; 16-bit
    cmp     dword [dblock],   eax       ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    cmp     qword [qblock],   rax       ; 64-bit

    ; cmp   mem, imm
    cmp     byte  [bblock],   1         ; 8-bit
    cmp     word  [wblock],   3         ; 16-bit
    cmp     dword [dblock],   4         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    cmp     qword [qblock],   5         ; 64-bit


; TEST
    ; test LHS, RHS
    ;
    ; Instruksi ini melakukan operasi bitwise AND antara kedua operan dan
    ; memodifikasi flag. Hasil operasi tidak disimpan di manapun.

    ; test  reg, reg
    test     bl,  al                    ; 8-bit
    test     bh,  ah                    ; 8-bit
    test     bx,  ax                    ; 16-bit
    test    ebx, eax                    ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    test    rbx, rax                    ; 64-bit

    ; test  reg, mem
    test     al, byte  [bblock]         ; 8-bit
    test     ah, byte  [bblock]         ; 8-bit
    test     ax, word  [wblock]         ; 16-bit
    test    eax, dword [dblock]         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    test    rax, qword [qblock]         ; 64-bit

    ; test  reg, imm
    test     bl,  1                     ; 8-bit
    test     bh,  2                     ; 8-bit
    test     bx,  3                     ; 16-bit
    test    ebx,  4                     ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    test    rbx,  5                     ; 64-bit

    ; test  mem, reg
    test    byte  [bblock],    al       ; 8-bit
    test    byte  [bblock],    ah       ; 8-bit
    test    word  [wblock],    ax       ; 16-bit
    test    dword [dblock],   eax       ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    test    qword [qblock],   rax       ; 64-bit

    ; test  mem, imm
    test    byte  [bblock],   1         ; 8-bit
    test    byte  [bblock],   2         ; 8-bit
    test    word  [wblock],   3         ; 16-bit
    test    dword [dblock],   4         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    test    qword [qblock],   5         ; 64-bit


; SCAS / SCASB / SCASW / SCASD / SCASQ
    ; Bandingkan data pada alamat ES:SI dan register EAX.

    scasb       ; bandingkan dengan AL
    scasw       ; bandingkan dengan AX
    scasd       ; bandingkan dengan EAX
    ; error jika dieksekusi pada program 32-bit
    scasq       ; bandingkan dengan RAX



    hlt         ; Hentikan eksekusi