;   memory.asm
;
;   Data movement untuk nilai di memory.
;   Nilai di memory dapat mengisi lokasi lain, tapi hanya register yang
;   valid sebagai operan tujuan.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o memory.o memory.asm
;
;   (win32)
;   $ nasm -f win32 -o memory.o memory.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o memory memory.o
;
;   (windows)
;   $ ld -m i386pe -o memory memory.o
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
    ; tetapkan nilai register dengan nilai dari memory
    ; register dan memory harus berukuran sesuai.
    mov      bl, byte  [bblock]             ; 8-bit 
    mov      bh, byte  [bblock]             ; 8-bit 
    mov      bx, word  [wblock]             ; 16-bit
    mov     ebx, dword [dblock]             ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    mov     rbx, qword [qblock]             ; 64-bit


; PUSH
    ; Simpan nilai dari alamat tertentu ke stack (alamat yang ditunjuk oleh ESP/RSP).
    ; Stack harus selalu aligned, ukuran elemen sama dengan ukuran memory alignment.
    ; Dimana alignment selalu:
    ;   * 4-byte pada program 32-bit
    ;   * 8-byte pada program 64-bit

    ; error jika dieksekusi pada program 64-bit
    push    dword [dblock]      ; push 32-bit data

    ; error jika dieksekusi pada program 32-bit
    push    qword [qblock]      ; push 64-bit data


; STOSB / STOSW / STOSD / STOSQ
    ; store byte / word / dword.
    ; Menyimpan data dari AL / AX / EAX ke alamat yang ditunjuk oleh DS:SI.
    ; Setelah load selesai, SI akan menunjuk ke posisi berikutnya pada string, 
    ; berdasarkan Direction Flag (DF).

    ; operasi ini sepadan dengan kode C berikut:
    ;   if (DF == 0)   *SI ++ = AL;
    ;   else           *SI -- = AL; 

    stosb       ; store dari  AL
    stosw       ; store dari  AX
    stosd       ; store dari EAX
    ; error jika dieksekusi pada program 32-bit
    stosq       ; store dari RAX


; MOVSB / MOVSW / MOVSD / MOVSQ
    ; Salin data dari DS:SI ke ES:DI
    ; Setelah pemindahan selesai, SI dan DI akan menunjuk ke posisi berikutnya pada string,
    ; berdasarkan Direction Flag (DF).

    ; operasi ini sepadan dengan kode C berikut:
    ;   if (DF == 0)    *DI ++ = *SI ++;
    ;   else            *DI -- = *SI --;

    movsb
    movsw
    movsd
    ; error jika dieksekusi pada program 32-bit
    movsq


; XCHG 
    ; Exchange (swap) nilai kedua operan 

    ; operasi ini sepadan dengan kode C berikut:
    ;   tmp = eax;
    ;   eax = *;
    ;   ebx = tmp;

    xchg    eax, [dblock]    


    hlt         ; Hentikan eksekusi