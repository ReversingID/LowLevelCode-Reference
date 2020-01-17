;   register.asm
;
;   Data movement untuk nilai di register.
;   Nilai di dalam register dapat mengisi lokasi lain, baik register 
;   maupun alamat memory lain.
; 
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o register.o register.asm
;
;   (win32)
;   $ nasm -f win32 -o register.o register.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o register register.o
;
;   (windows)
;   $ ld -m i386pe -o register register.o
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

; MOV
    ; tetapkan nilai register dengan nilai dari register lain.
    ; kedua register harus berukuran sesuai.

    mov      bl,  al                ; 8-bit         88 c3
    mov      bh,  ah                ; 8-bit         88 e7
    mov      bx,  ax                ; 16-bit        66 89 c3
    mov     ebx, eax                ; 32-bit        89 c3
    ; error jika dieksekusi pada program 32-bit
    mov     rbx, rax                ; 64-bit        48 89 c3
    
    ; tetapkan nilai pada alamat memory dengan nilai dari register.
    ; register dan memory harus berukuran sesuai.
    mov     byte  [bblock], al      ; 8-bit
    mov     byte  [bblock+1], bh    ; 8-bit
    mov     word  [wblock], cx      ; 16-bit
    mov     dword [dblock], edx     ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    mov     qword [qblock], r8      ; 64-bit


; PUSH
    ; Simpan nilai register ke stack (alamat yang ditunjuk oleh ESP/RSP).
    ; Stack harus selalu aligned, ukuran elemen sama dengan ukuran memory alignment.
    ; Dimana alignment selalu:
    ;   * 4-byte pada program 32-bit
    ;   * 8-byte pada program 64-bit

    ; error jika dieksekusi pada program 64-bit
    push    eax         ; push 32-bit data

    ; error jika dieksekusi pada program 32-bit
    push    rax         ; push 64-bit data


; POP
    ; Memuat nilai dari posisi puncak stack ke register dan menghapus posisi puncak.
    ; Stack harus selalu aligned, ukuran elemen sama dengan ukuran memory alignment.
    ; Dimana alignment selalu:
    ;   * 4-byte pada program 32-bit
    ;   * 8-byte pada program 64-bit

    ; error jika dieksekusi pada program 64-bit
    pop     eax         ; push 32-bit data

    ; error jika dieksekusi pada program 32-bit
    pop     rax         ; push 64-bit data


; LEA (Load Effective Address)
    ; Letakkan alamat memori ke tujuan, alih-alih meletakkan nilai yang disimpan 
    ; pada alamat memori rujukan. Alamat memori dihitung dari operan sumber yang 
    ; memenuhi addressing mode.
    
    ; lea reg, <address>
    ; [1] Displacement
    lea     eax, [bblock]                       ; eax = bblock
    lea     eax, [0x12345678]                   ; eax = 0x12345678

    ; [2] Base
    lea     eax, [ecx]                          ; eax = ecx

    ; [3] Base + Displacement
    lea     eax, [ecx + 4]                      ; eax = ecx + 4

    ; [4] (Index * Scale) + Displacement
    lea     eax, [wblock + ecx*4]               ; eax = wblock + ecx * 4

    ; [5] Base + Index + Displacement
    lea     eax, [wblock + ecx + 4]             ; eax = wblock + ecx + 4

    ; [6] Base + Index * Scale + Displacement
    lea     eax, [wblock + ecx * 4 + 4]         ; eax = wblock + ecx * 4 + 4

    ; LEA sering digunakan untuk melakukan perhitungan nilai.


; LODSB / LODSW / LODSD / LODSQ
    ; Load byte / word / dword.
    ; Memuat data pada alamat DS:SI ke AL / AX / EAX.
    ; Setelah load selesai, SI akan menunjuk ke posisi berikutnya pada string, 
    ; berdasarkan Direction Flag (DF).

    ; operasi ini sepadan dengan kode C berikut:
    ;   if (DF == 0)   AL = *SI ++;
    ;   else           AL = *SI --; 

    lodsb       ; load data ke AL
    lodsw       ; load data ke AX
    lodsd       ; load data ke EAX
    ; error jika dieksekusi pada program 32-bit
    lodsq       ; load data ke RAX


; XCHG 
    ; Exchange (swap) nilai kedua operan 

    ; operasi ini sepadan dengan kode C berikut:
    ;   tmp = eax;
    ;   eax = ebx;
    ;   ebx = tmp;

    xchg    eax, ebx



    hlt         ; Hentikan eksekusi

