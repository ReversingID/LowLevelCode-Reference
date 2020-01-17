;   signed.asm
;
;   Operasi aritmetik terhadap bilangan bulat bertanda (signed integer)
;
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o signed.o signed.asm
;
;   (win32)
;   $ nasm -f win32 -o signed.o signed.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o signed signed.o
;
;   (windows)
;   $ ld -m i386pe -o signed signed.o
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

; ADD (penjumlahan)
    ; Tambahkan nilai dari operan kedua ke operan pertama, dan simpan ke operan pertama.
    
    ; add reg, reg
    add      bl,  al                    ; 8-bit
    add      bh,  ah                    ; 8-bit
    add      bx,  ax                    ; 16-bit
    add     ebx, eax                    ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    add     rbx, rax                    ; 64-bit

    ; add reg, imm
    add      bl,  1                     ; 8-bit
    add      bh,  2                     ; 8-bit
    add      bx,  3                     ; 16-bit
    add     ebx,  4                     ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    add     rbx,  5                     ; 64-bit

    ; add reg, mem
    add      al, byte  [bblock]         ; 8-bit
    add      ah, byte  [bblock+1]       ; 8-bit
    add      ax, word  [wblock]         ; 16-bit
    add     eax, dword [dblock]         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    add     rax, qword [qblock]         ; 64-bit

    ; add mem, reg
    add     byte  [bblock],    al       ; 8-bit
    add     byte  [bblock+1],  ah       ; 8-bit
    add     word  [wblock],    ax       ; 16-bit
    add     dword [dblock],   eax       ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    add     qword [qblock],   rax       ; 64-bit

    ; add mem, imm
    add     byte  [bblock],   1         ; 8-bit
    add     byte  [bblock+1], 2         ; 8-bit
    add     word  [wblock],   3         ; 16-bit
    add     dword [dblock],   4         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    add     qword [qblock],   5         ; 64-bit


; SUB (pengurangan)
    ; Kurangkan nilai kedua dari nilai pertama dan simpan hasilnya di operan pertama.
    ; Operasi ini tidak memperhatikan keberadaan "borrow".
    
    ; sub reg, reg
    sub      bl,  al                    ; 8-bit
    sub      bh,  ah                    ; 8-bit
    sub      bx,  ax                    ; 16-bit
    sub     ebx, eax                    ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    sub     rbx, rax                    ; 64-bit

    ; sub reg, imm
    sub      bl,  1                     ; 8-bit
    sub      bh,  2                     ; 8-bit
    sub      bx,  3                     ; 16-bit
    sub     ebx,  4                     ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    sub     rbx,  5                     ; 64-bit

    ; sub reg, mem
    sub      al, byte  [bblock]         ; 8-bit
    sub      ah, byte  [bblock+1]       ; 8-bit
    sub      ax, word  [wblock]         ; 16-bit
    sub     eax, dword [dblock]         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    sub     rax, qword [qblock]         ; 64-bit

    ; sub mem, reg
    sub     byte  [bblock],    al       ; 8-bit
    sub     byte  [bblock+1],  ah       ; 8-bit
    sub     word  [wblock],    ax       ; 16-bit
    sub     dword [dblock],   eax       ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    sub     qword [qblock],   rax       ; 64-bit

    ; sub mem, imm
    sub     byte  [bblock],   1         ; 8-bit
    sub     byte  [bblock+1], 2         ; 8-bit
    sub     word  [wblock],   3         ; 16-bit
    sub     dword [dblock],   4         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    sub     qword [qblock],   5         ; 64-bit


; SBB (pengurangan dengan borrow)
    ; Kurangkan nilai kedua dari nilai pertama dan simpan hasil di operan pertama.
    ; Jika terdapat borrow (CF bernilai 1), maka borrow (CF) akan disertakan dalam perhitungan.
    ; 
    ; Sepadan dengan
    ;     dst = dst - (src + CF)
    
    ; sbb reg, reg
    sbb      bl,  al                    ; 8-bit
    sbb      bh,  ah                    ; 8-bit
    sbb      bx,  ax                    ; 16-bit
    sbb     ebx, eax                    ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    sbb     rbx, rax                    ; 64-bit

    ; sbb reg, imm
    sbb      bl,  1                     ; 8-bit
    sbb      bh,  2                     ; 8-bit
    sbb      bx,  3                     ; 16-bit
    sbb     ebx,  4                     ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    sbb     rbx,  5                     ; 64-bit

    ; sbb reg, mem
    sbb      al, byte  [bblock]         ; 8-bit
    sbb      ah, byte  [bblock+1]       ; 8-bit
    sbb      ax, word  [wblock]         ; 16-bit
    sbb     eax, dword [dblock]         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    sbb     rax, qword [qblock]         ; 64-bit

    ; sbb mem, reg
    sbb     byte  [bblock],    al       ; 8-bit
    sbb     byte  [bblock+1],  ah       ; 8-bit
    sbb     word  [wblock],    ax       ; 16-bit
    sbb     dword [dblock],   eax       ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    sbb     qword [qblock],   rax       ; 64-bit

    ; sbb mem, imm
    sbb     byte  [bblock],   1         ; 8-bit
    sbb     byte  [bblock+1], 2         ; 8-bit
    sbb     word  [wblock],   3         ; 16-bit
    sbb     dword [dblock],   4         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    sbb     qword [qblock],   5         ; 64-bit



; INC (increment) & DEC (decrement)
    ; Tingkatkan (atau susutkan) nilai dari operan sebanyak 1. 
    
    ; inc reg 
    inc      bl                 ; 8-bit
    inc      bh                 ; 8-bit
    inc      bx                 ; 16-bit
    inc     ebx                 ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    inc     rbx                 ; 64-bit

    ; inc mem 
    inc     byte  [bblock]      ; 8-bit
    inc     byte  [bblock+1]    ; 8-bit
    inc     word  [wblock]      ; 16-bit
    inc     dword [dblock]      ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    inc     qword [qblock]      ; 64-bit

    ; dec reg 
    dec      bl                 ; 8-bit
    dec      bh                 ; 8-bit
    dec      bx                 ; 16-bit
    dec     ebx                 ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    dec     rbx                 ; 64-bit

    ; dec mem 
    dec     byte  [bblock]      ; 8-bit
    dec     byte  [bblock+1]    ; 8-bit
    dec     word  [wblock]      ; 16-bit
    dec     dword [dblock]      ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    dec     qword [qblock]      ; 64-bit


; IMUL (perkalian)
    ; Terdapat dua format dasar dalam perkalian ini: dua-operan dan tiga-operan.
    ;   - pada dua-operan: kedua operan dikalikan dan hasil disimpan pada
    ;     operan pertama
    ;   - pada tiga-operan: kedua operan terakhir dikalikan dan hasil 
    ;     disimpan pada operan pertama.
    ; seluruh operan harus berukuran sesuai.
    
    ; imul reg, reg
    imul     ax,  bx                ; 16-bit
    imul    eax, ebx                ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    imul    rax, rbx                ; 64-bit

    ; imul reg, mem
    imul     ax,  word [wblock]     ; 16-bit
    imul    eax, dword [dblock]     ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    imul    rax, qword [qblock]     ; 64-bit

    ; imul reg, reg, imm
    imul     ax,  bx, 5             ; 16-bit
    imul    eax, ebx, 5             ; 32-bit 
    ; error jika dieksekusi pada program 32-bit
    imul    rax, rbx, 5             ; 64-bit

    ; imul reg, mem, imm
    imul     ax,  word [wblock], 5  ; 16-bit
    imul    eax, dword [dblock], 5  ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    imul    rax, qword [qblock], 5  ; 64-bit


; IDIV (pembagian)
    ; Bagi isi dari pasangan register dengan nilai operan.
    ; Menghasilkan "hasil bagi" (quotient) dan "sisa bagi" (remainder)

    ; idiv reg
    idiv     cl             ; bagi     AX  dengan  CL, hasil disimpan di  AL dan sisa di  AH
    idiv     cx             ; bagi  DX:AX  dengan  CX, hasil disimpan di  AX dan sisa di  DX
    idiv    ecx             ; bagi EDX:EAX dengan ECX, hasil disimpan di EAX dan sisa di EDX
    ; error jika dieksekusi pada program 32-bit
    idiv    rcx             ; bagi RDX:RAX dengan RCX, hasil disimpan di RAX dan sisa di RDX

    ; idiv mem
    idiv     byte [bblock]  ; bagi     AX  dengan mem, hasil disimpan di  AL dan sisa di  AH
    idiv     word [wblock]  ; bagi  DX:AX  dengan mem, hasil disimpan di  AX dan sisa di  DX
    idiv    dword [dblock]  ; bagi EDX:EAX dengan mem, hasil disimpan di EAX dan sisa di EDX
    ; error jika dieksekusi pada program 32-bit
    idiv    qword [qblock]  ; bagi RDX:RAX dengan mem, hasil disimpan di RAX dan sisa di RDX


    hlt         ; Hentikan eksekusi