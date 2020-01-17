;   complex-condition.asm
;
;   Percabangan dengan pemeriksaan kondisi kompleks. 
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o complex-condition.o complex-condition.asm
;
;   (win32)
;   $ nasm -f win32 -o complex-condition.o complex-condition.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o complex-condition complex-condition.o
;
;   (windows)
;   $ ld -m i386pe -o complex-condition complex-condition.o
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
;   Implementasi percabangan dengan kondisi kompleks.
;   Percabangan dengan pemeriksaan kondisi kompleks dan mengarahkan ke
;   sekelompok instruksi jika kondisi terpenuhi. Kondisi kompleks adalah
;   kombinasi dari kondisi sederhana.
;
; Bentuk umum:
;     if (complex_condition) then
;         do_action
;
;     tipe complex_condition:
;         - condition_1 AND condition_2
;         - condition_1 OR condition_2
;
; Padanan:
;     if not (complex_condition) then goto end
;         do_action
;     end:

section .data
    var1  dd 0
    var2  dd 0

section .text

_start:

; Perlu diketahui bahwa kondisi kompleks adalah kombinasi dari beberapa kombinasi 
; kondisi sederha yang dirangkai. Sehingga perlu dilakukan pemisahan kondisi dan
; identifikasi untuk menentukan struktur yang tepat.


;-----------------------------------------------------------------------------
; condition_1 AND condition_2

; Ekspresi logika ini akan bernilai TRUE jika kedua kondisi bernilai TRUE.
; Karena itu, ketika evaluasi kondisi dari kiri ke kanan, jika terdapat satu kondisi 
; bernilai FALSE, maka aksi tidak akan dieksekusi.

    ; if (var1 > 0 && va1 > 10)
    ; {
    ;     var1 = 10
    ; }

    mov     eax, dword [var1]   ; isi nilai var1 ke EAX
    mov     ebx, dword [var2]   ; isi nilai var2 ke EBX

    ; pemeriksaan kondisi
    cmp     eax, 0
    jle     .fail_1             ; jika var1 lebih kecil atau sama dengan 0,
                                ; kondisi kompleks akan dievaluasi sebagai FALSE
    
    cmp     ebx, 10
    jle     .fail_1             ; jika var2 lebih kecil atau sama dengan 10,
                                ; kondisi kompleks akan dievaluasi sebagai FALSE

    ; eksekusi do_action karena kondisi (asli) terpenuhi.
    mov     dword [var1], 10    ; eksekusi aksi

.fail_1:
    ; instruksi ini akan dieksekusi terlepas dari hasil percabangan.

;-----------------------------------------------------------------------------


; condition_1 OR condition_2

; Ekspresi logika ini akan bernilai TRUE jika salah satu kondisi bernilai TRUE.
; Karena itu, ketika evaluasi kondisi dari kiri ke kanan, jika terdapat satu kondisi
; bernilai TRUE, maka aksi akan dieksekusi.

    ; if (var1 > 0 || va1 > 10)
    ; {
    ;     var1 = 10
    ; }

    mov     eax, dword [var1]   ; isi nilai var1 ke EAX
    mov     ebx, dword [var2]   ; isi nilai var2 ke EBX

    ; pemeriksaan kondisi
    cmp     eax, 0
    jg      .success            ; jika var1 lebih besar daripada 0,
                                ; kondisi kompleks akan dievaluasi sebagai TRUE
    
    cmp     ebx, 10
    jle     .fail_2             ; jika var2 lebih kecil atau sama dengan 10,
                                ; kondisi kompleks akan dievaluasi sebagai FALSE
    
.success:
    ; pada titik ini, salah satu kondisi terpenuhi.
    mov     dword [var1], 10    ; eksekusi aksi.

.fail_2:
    ; instruksi ini akan dieksekusi terlepas dari hasil percabangan.


    hlt         ; Hentikan eksekusi
