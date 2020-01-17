;   while.asm
;
;   Instruksi perulangan sederhana 
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o while.o while.asm
;
;   (win32)
;   $ nasm -f win32 -o while.o while.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o while while.o
;
;   (windows)
;   $ ld -m i386pe -o while while.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

    global _start

; Loop (perulangan) adalah serangkaian instruksi yang ditulis sekali namun dapat 
; dieksekusi berkali-kali secara berturut-turut.
;
; Instruksi perulangan dapat dikendalikan berdasarkan banyaknya perulangan
; maupun kondisi perulangan yang harus dipenuhi
;
; Di x86, loop dapat didefinisikan dengan tiga mekanisme berbeda:
;   - REP (dan turunannya)
;   - LOOP (dan turunannya)
;   - Branching.

; While memiliki konstruksi yang mirip dengan Do-While namun dengan pemeriksaan kondisi
; dilakukan di awal. 
;
; Bentuk umum:
;     while (condition)
;         do_action
;
; Padanan:
;     if not (condition) then goto loop_end
;     loop_body:
;         do_action
;     if (condition) then goto loop_body
;     loop_end:

section .data
    var     dd  0
    

section .text

_start:

    ; while (var <= 10)
    ; {
    ;     var ++;
    ; } 
    
    ; Konstruksi While terlihat sederhana namun memiliki pemeriksaan kondisi lebih 
    ; (dibandingkan Do-While) untuk dapat menciptakan perulangan.
    
; -- alternatif 1 ---------------------------

    ; Terdapat dua percabangan yang membentuk loop While
    ;   - Conditional Jump untuk mengeksekusi blok atau melewatinya
    ;   - Conditional Jump untuk melanjutkan perulangan atau tidak.
    
    mov     eax, dword [var]

    ; Conditional Jump, periksa apakah eksekusi dilakukan atau dilewati
    cmp     eax, 10
    jg      loop_end

loop_body_1:                    ; blok instruksi dimulai di sini
    inc     eax 

    ; Pada kasus tertentu, beberapa instruksi dapat mengubah kondisi.
    ; Misal, perubahan counter, perubahan treshold, dsb.

    ; Conditional Jump, periksa apakah perulangan dilanjutkan atau tidak
    cmp     eax, 10
    jle     loop_body           ; ulangi jika kondisi terpenuhi.

loop_end:
    ; di luar loop
    mov     dword [var], eax 


; -- alternatif 2 ---------------------------

    ; Terdapat dua percabangan yang membentuk loop While
    ;   - Unconditional Jump untuk mengarah ke pemeriksaan kondisi 
    ;   - Conditional Jump untuk melanjutkan perulangan atau tidak.

    mov     eax, dword [var]

    ; Lakukan pemeriksaan kondisi
    jmp     loop_check

loop_body_2:                    ; blok instruksi dimulai di sini
    inc     eax 

    ; Pada kasus tertentu, beberapa instruksi dapat mengubah kondisi.
    ; Misal, perubahan counter, perubahan treshold, dsb.

loop_check:
    ; Conditional Jump, periksa apakah perulangan dilanjutkan atau tidak
    cmp     eax, 10
    jle     loop_body_2         ; ulangi jika kondisi terpenuhi.

    ; di luar loop
    mov     dword [var], eax 

    
    hlt         ; Hentikan eksekusi