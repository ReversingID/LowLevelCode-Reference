;   repeat.asm
;
;   Instruksi perulangan sederhana 
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o repeat.o repeat.asm
;
;   (win32)
;   $ nasm -f win32 -o repeat.o repeat.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o repeat repeat.o
;
;   (windows)
;   $ ld -m i386pe -o repeat repeat.o
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

; REP (dan turunannya) adalah perulangan di level instruksi.
; Instruksi ini akan mengulang instruksi tunggal (operasi string) sebanyak 
; sekian kali yang didefinisikan dalam count register ECX atau sampai kondisi 
; yang diindikasikan flag ZF tak terpenuhi.
;
; Keluarga instruksi REP memiliki berapa instruksi:
;   - REP   (Repeat)
;   - REPE  (Repeat while Equal)
;   - REPNE (Repeat while Not Equal)
;   - REPZ  (Repeat while Zero)
;   - REPNZ (Repeat while Not Zero)

section .bss 
    dstd    resd 5  

section .data
    srcd    dd  1, 2 ,3 ,4, 5
    

section .text

_start:

; REP (Repeat)
    ; ulangi instruksi hingga ECX bernilai 0.

    ; move data dari [ESI] ke [EDI]
    mov     ecx, 5                      ; counter ECX
    mov     edi, dstd                   ; destination
    mov     esi, srcd                   ; source
    rep     movsd                       ; repeat

    ; dstd = 1, 2, 3, 4, 5
    ; srcd = 1, 2, 3, 4, 5

    ; move data dari EAX ke [EDI]
    mov     ecx, 2                      ; counter ECX
    mov     edi, dstd 
    add     edi, 8                      ; destination (index 2 dstd)
    mov     eax, 0                      ; source
    rep     stosd                       ; repeat

    ; dstd = 1, 2, 0, 0, 5
    ; srcd = 1, 2, 3, 4, 5


; REPE (Repeat while Equal)
; REPZ (Repeat while Zero)
    ; ulangi instruksi hingga ECX bernilai 0 atau ZF = 0

    ; cari nilai yang tak sama di [EDI] dan [ESI]
    mov     ecx, 5                      ; counter ECX
    mov     edi, dstd                   ; destination
    mov     esi, srcd                   ; source
    repe    cmpsd                       ; Repeat, berhenti pada dstd[2]


; REPNE (Repeat while Not Equal)
; REPNZ (Repeat while Not Zero)
    ; ulangi instruksi hingga ECX bernilai 0 atau ZF = 1

    ; cari nilai yang sama di [EDI] and [ESI]
    mov     ecx, 3                      ; counter ECX
    mov     edi, dstd 
    add     edi, 8                      ; destination (index 2 of dstd)
    mov     esi, srcd                   ; source
    repnz   cmpsd                       ; repeat, berhenti pada dstd[4]

    
    hlt         ; Hentikan eksekusi