;   multi-if.asm
;
;   Banyak pilihan percabangan dengan masing-masing cabang memiliki kondisi sederhana.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o multi-if.o multi-if.asm
;
;   (win32)
;   $ nasm -f win32 -o multi-if.o multi-if.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o multi-if multi-if.o
;
;   (windows)
;   $ ld -m i386pe -o multi-if multi-if.o
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
;   Implementasi statement "Multi-If"
;   Setiap cabang memiliki kondisi sederhana dan akan mengarahkan eksekusi ke
;   blok tertentu jika kondisi terpenuhi.

section .data
    var  dd 0
    var2 dd 0

section .text

_start:


;-----------------------------------------------------------------------------

; Jika kondisi dihasilkan dari ekspresi yang sama, maka serangkaian instruksi Jump
; akan ditulis berdekatan setelah instruksi perbandingan.

    mov     eax, dword [var]    ; isi nilai ke EAX

    ; pemeriksaan kondisi
    cmp     eax, 0              ; berdasarkan nilai EAX dibandingkan dengna 0

    ; jlompati / lewati jika negasi dari kondisi terpenuhi
    jg      .greater            ; jump ketika EAX lebih besar
    jl      .less               ; jump ketika EAX lebih kecil

    ; eksekusi do_action karena kondisi (asli) terpenuhi.
    mov     dword [var], 0
    jmp     .end                 ; hindari block lain

.greater:
    mov     dword [var], 1 
    jmp     .end                 ; hindari block lain

.less:
    mov     dword [var], 2 

.end:
    ; instruksi ini akan dieksekusi terlepas dari hasil percabangan.

;-----------------------------------------------------------------------------


; Jika kondisi dihasilkan dari ekspresi berbeda, maka berbagai pemeriksaan
; akan dihasilkan dan digunakan berantai.

; Bentuk umum (3 cases):
;     if (condition_1) then
;         do_action_1
;     else if (condition_2)
;         do_action_2
;     else
;         do_alternative_action
;
; Padanan:
;     if not (condition_1) then goto check_2
;         do_action_1
;         goto end
;     check_2:
;     if not (condition_2) then goto else
;         do_action_2
;         goto end
;     else:
;         do_alternative_action
;     end:

    ; if (var == 0)
    ;     var = 1;
    ; else if (var2 == 0)
    ;     var2 = 1;
    ; else 
    ;     var1 = var2 = 0;

    mov     eax, dword [var]    ; isi nilai ke EAX

    ; pemeriksaan kondisi untuk condition_1
    cmp     eax, 0              ; if (var == 0)

    ; lompati / lewati jika negasi dari kondisi terpenuhi
    jne     .check2             ; Jump jika EAX tak nol

    ; eksekusi do_action_1 karena kondisi terpenuhi.
    mov     dword [var], 1
    jmp     .finish             ; hindari block lain

.check2:
    mov     ebx, dword [var2]   ; isi nilai ke EBX

    ; pemeriksaan kondisi untuk condition_2
    cmp     ebx, 0              ; else if (var1 == 0)

    ; lompati / lewati jika negasi dari kondisi terpenuhi
    jne     .else               ; hindari block lain

    ; eksekusi do_action_2 karena kondisi terpenuhi.
    mov     dword [var], 1 
    jmp     .finish             ; hindari block lain

.else:
    ; eksekusi do_alternative_action karena kondisi lain tak terpenuhi.
    mov     dword [var], 0
    mov     dword [var2], 0

.finish:
    ; instruksi ini akan dieksekusi terlepas dari hasil percabangan.


    hlt         ; Hentikan eksekusi
