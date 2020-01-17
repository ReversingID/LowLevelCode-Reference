;   if-else.asm
;
;   Percabangan dengan pengecekan tunggal, aksi dan alternatifnya
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o if-else.o if-else.asm
;
;   (win32)
;   $ nasm -f win32 -o if-else.o if-else.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o if-else if-else.o
;
;   (windows)
;   $ ld -m i386pe -o if-else if-else.o
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
;   Implementasi statement "If-Else"
;   Percabangan sederhana yang mengarahkan ke sekelompok instruksi jika kondisi
;   terpenuhi, jika tidak lakukan instruksi alternatif.
;
; Bentuk umum:
;     if (condition) then
;         do_action
;     else
;         do_alternative_action
;
; Padanan:
;     if not (condition) then goto else
;         do_action
;         goto end
;     else:
;         do_alternative_action
;     end:

section .data
    var  dd 0

section .text

_start:

    ; if (var == 0)
    ; {
    ;     var = 1
    ; }
    ; else
    ; {
    ;     var = 2;    
    ; }
    
    ; Periksa apakah kondisi terpenuhi dan lakukan Jump jika false 
    ; (negasi dari kondisi terpenuhi).
    ; Ini adalah implementasi efisien karena hanya butuh dua jump.

    mov     eax, dword [var]    ; isi nilai ke EAX

    ; pemeriksaan kondisi
    cmp     eax, 0              ; if (var == 0)

    ; lompati / lewati jika negasi dari kondisi terpenuhi
    jne     .else               ; jump ketika tak nol

    ; eksekusi do_action karena kondisi (asli) terpenuhi.
    mov     dword [var], eax    ; eksekusi aksi
    jmp     .end                ; hindari block untuk "else" atau aksi alternatif

.else:
    ; eksekusi do_alternative_action karena kondisi (asli) tak terpenuhi.
    mov     dword [var], eax 

.end:
    ; instruksi ini akan dieksekusi terlepas dari hasil percabangan.


    hlt         ; Hentikan eksekusi
