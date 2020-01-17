;   for.asm
;
;   Instruksi perulangan sederhana 
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o for.o for.asm
;
;   (win32)
;   $ nasm -f win32 -o for.o for.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o for for.o
;
;   (windows)
;   $ ld -m i386pe -o for for.o
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

; For adalah konstruksi perulangan yang dikontrol menggunakan sebuah counter untuk
; mengeksekusi blok sebanyak sekian kali. Selain implementasi dengan instruksi LOOP,
; FOR dapat diimplementasikan dengan konstruksi instruksi Jump.
;
; Bentuk umum:
;     for (initialization; condition; counter_increment)
;     {
;         do_action
;     }
;
; Padanan:
;     initialization
;     if not (condition) then goto loop_end
;     loop_body:
;         do_action
;         counter_increment
;     if not (condition) then goto loop_body
;     loop_end:

section .bss
    arrd    resd  10
    

section .text

_start:

    ; for (i = 0; i < 10; i++)
    ; {
    ;     arrd[i] = x;
    ; } 
    ;
    ; Pecah struktur loop menjadi empat bagian:
    ;   - initialization
    ;   - condition checking
    ;   - counter increment
    ;   - loop body
    ; 
    ; sehingga didapatkan konstruksi dengan semantik sama.
    ;
    ;   initialization;
    ;   while (condition)
    ;   {
    ;       action;
    ;       counter increment;   
    ;   }
    
    mov     edi, arrd

    ; Inisialisasi
    mov     eax, 0              ; i = 0

    ; Conditional jump, periksa apakah eksekusi dilakukan atau dilewati
    cmp     eax, 10
    jg      loop_end

loop_body:                      ; blok instruksi dimulai di sini
    ; action
    mov     dword [edi], eax    ; pindahkan konten EAX ke [EDI]

    ; tingkatkan nilai counter 
    inc     eax 
    add     edi, 4              ; EDI mengarah ke elemen berikutnya

    ; Conditional jump, periksa apakah perulangan dilanjutkan atau tidak
    cmp     eax, 10
    jl      loop_body           ; kembali ke loop_body jika kondisi terpenuhi
    
loop_end:
    ; di luar loop
    mov     dword [arrd], eax 

    
    hlt         ; Hentikan eksekusi