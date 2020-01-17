;   if.asm
;
;   Percabangan dengan pengecekan kondisi tunggal
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o if.o if.asm
;
;   (win32)
;   $ nasm -f win32 -o if.o if.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o if if.o
;
;   (windows)
;   $ ld -m i386pe -o if if.o
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
;   Implementasi statement "If-Then"
;   Percabangan sederhana yang mengarahkan ke sekelompok instruksi jika kondisi
;   terpenuhi.
;
; Bentuk umum:
;     if (condition) then
;         do_action
;
; Padanan:
;     if not (condition) then goto end
;         do_action
;     end:

section .data
    var  dd 0

section .text

_start:

    ; if (var == 0)
    ; {
    ;     var = 1
    ; }
    
    ; Periksa apakah kondisi terpenuhi dan lakukan Jump jika false 
    ; (negasi dari kondisi terpenuhi).
    ; Ini adalah implementasi efisien karena hanya butuh satu jump.

    mov     eax, dword [var]    ; isi nilai ke EAX

    ; pemeriksaan kondisi
    cmp     eax, 0              ; bandingkan EAX dan 0

    ; lompati / lewati jika negasi dari kondisi terpenuhi
    jne     .end                ; jump ketika tak nol

    ; eksekusi do_action karena kondisi (asli) terpenuhi.
    mov     dword [var], eax    ; eksekusi aksi.

.end:
    ; instruksi ini akan dieksekusi terlepas dari hasil percabangan.


    hlt         ; Hentikan eksekusi
