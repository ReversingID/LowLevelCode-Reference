;   do-while.asm
;
;   Instruksi perulangan sederhana 
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o do-while.o do-while.asm
;
;   (win32)
;   $ nasm -f win32 -o do-while.o do-while.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o do-while do-while.o
;
;   (windows)
;   $ ld -m i386pe -o do-while do-while.o
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

; Do-While loop adalah konstruksi perulangan sederhana dimana sekelompok instruksi
; dieksekusi setidaknya sebanyak sekali.
;
; Bentuk umum:
;     do
;         do_action
;     while (condition)
;
; Padanan:
;     loop_body:
;         do_action
;     if not (condition) then goto loop_body

section .data
    var     dd  0
    

section .text

_start:

    ; do
    ; {
    ;     var ++;
    ; } while (var <= 10);

    ; blok instruksi dieksekusi, kondisi diperiksa saat akhir perulangan dan lompat
    ; kembali ke awal blok jika kondisi terpenuhi.
    
    ; lakukan inisialisasi apapun jika diperlukan di sini.
    mov     eax, dword [var]

loop_body:                      ; blok instruksi dimulai di sini.
    inc     eax 

    ; Pada kasus tertentu, beberapa instruksi dapat mengubah kondisi.
    ; Misal, perubahan counter, perubahan treshold, dsb.
    
    ; Conditional Jump, periksa apakah perulangan akan dilakukan kembali.
    cmp     eax, 10
    jle     loop_body           ; ulangi jika kondisi tidak terpenuhi.

    ; di luar loop
    mov     dword [var], eax 

    
    hlt         ; Hentikan eksekusi