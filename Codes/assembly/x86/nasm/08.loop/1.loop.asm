;   loop.asm
;
;   Instruksi perulangan sederhana 
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o loop.o loop.asm
;
;   (win32)
;   $ nasm -f win32 -o loop.o loop.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o loop loop.o
;
;   (windows)
;   $ ld -m i386pe -o loop loop.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

    global _start

; Loop (perulangan) adalah serangkaian instruksi yang ditulis sekali namun dapat 
; dieksekusi berkali-kali secara berturut-turut.
;
; Instruksi perulangan dapat dapat dikendalikan berdasarkan banyaknya perulangan
; maupun kondisi perulangan yang harus dipenuhi
;
; Di x86, loop dapat didefinisikan dengan tiga mekanisme berbeda:
;   - REP (dan turunannya)
;   - LOOP (dan turunannya)
;   - Branching.

; LOOP (dan turunannya) adalah perulangan di level block.
; Eksekusi sekelompok instruksi secara berulang sebanyak sekian kali yang didefinisikan
; dalam count register ECX atau sampai kondisi yang diindikasikan flag ZF tak terpenuhi.
;
; Keluarga instruksi LOOP memiliki berapa instruksi:
;   - LOOP   (Loop)
;   - LOOPE  (Loop while Equal)
;   - LOOPNE (Loop while Not Equal)
;   - LOOPZ  (Loop while Zero)
;   - LOOPNZ (Loop while Not Zero)
;
; LOOP need a label which will be a destination jump.

section .bss 
    dstd    resd 5  
    

section .text

_start:

; LOOP (Loop)
    ; ulangi blok instruksi hingga ECX bernilai 0.

    ; mengisi array dengan counter
    mov     ecx, 5              ; counter ECX
    mov     edi, dstd           ; destination
    mov     eax, 0
    mov     ebx, 0
loop_label:
    stosd  
    inc     ebx 
    add     eax, ebx 
    loop    loop_label          ; loop

    ; dstd = 0, 1, 3, 6, 10


; LOOPE (Loop while Equal)
; LOOPZ (Loop while Zero)
    ; ulangi blok instruksi hingga ECX bernilai 0 atau ZF = 0

    ; cari nilai yang tak sama di [EDI] dan [ESI]
    mov     ecx, 5              ; counter ECX
    mov     edi, dstd           ; destination
loope_label:
    loope   loope_label         ; loop


; LOOPNE (Loop while Not Equal)
; LOOPNZ (Loop while Not Zero)
    ; ulangi blok instruksi hingga ECX bernilai 0 atau ZF = 1

    ; cari nilai yang sama di [EDI] and [ESI]
    mov     ecx, 5              ; counter ECX
    mov     edi, dstd           ; destination
loopnz_label:
    loopnz  loopnz_label        ; loop

    
    hlt         ; Hentikan eksekusi