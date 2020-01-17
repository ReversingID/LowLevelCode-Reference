;   nested-if.asm
;
;   Percabangan bersarang.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o nested-if.o nested-if.asm
;
;   (win32)
;   $ nasm -f win32 -o nested-if.o nested-if.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o nested-if nested-if.o
;
;   (windows)
;   $ ld -m i386pe -o nested-if nested-if.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

    global _start
 
; Branching (percabangan) adalah perpindahan eksekusi ke sekumpulan instruksi
; berbeda menggunakan satu atau lebih instruksi Jump.

; Instruksi percabangan dapat berupa Unconditional Jump (selalu berpindah)
; ataupun Conditional Jump (mungkin berpindah). Satu atau lebih instruksi Jump
; dapat dikombinasikan untuk mengevaluasi kondisi yang kompleks dan memastikan
; apakah block instruksi akan dieksekusi atau tidak.
;
; Tujuan:
;   Implementasi percabangan bersarang.
;   Sebuah percabangan dapat didefinisikan di dalam blok aksi percabangan lain.
;
; Bentuk umum:
;   if (condition_1) then
;       do_action_1
;       if (condition_2) then
;           do_action_2

section .data 
    var1    dd 0
    var2    dd 0

section .text 

_start:

; Perlu dicatat bahwa pemeriksaan kondisi condition_2 hanya terjadi jika condition_1 terpenuhi.
; Dapat dikatakan bahwa pemeriksaan condition_2 berada pada block sama dengan do_action_1

    ;   if (var1 == 0) then
    ;       var1 = 10
    ;       if (var2 == 0) then
    ;           var2 = 20

    mov     eax, dword [var1]   ; isi nilai var1 ke EAX

    ; pemeriksaan kondisi condition_1
    cmp     eax, 0
    jne     .end                ; jump jika tak nol

    ; eksekusi do_action_1
    mov     dword [var1], 10

    ; pemeriksaan kondisi condition_2
    mov     ebx, dword [var2]   ; isi nilai var2 ke EBX
    cmp     ebx, 0
    jne     .end                ; jump jika tak nol

    ; eksekusi do_action_2
    mov     dword [var2], 20

.end:
    ; instruksi ini akan dieksekusi terlepas dari hasil percabangan.


    hlt         ; Hentikan eksekusi
