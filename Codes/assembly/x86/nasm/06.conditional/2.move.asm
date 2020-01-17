;   move.asm
;
;   Instruksi Conditional Move
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o move.o move.asm
;
;   (win32)
;   $ nasm -f win32 -o move.o move.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o move move.o
;
;   (windows)
;   $ ld -m i386pe -o move move.o
; 
;-----------------------------------------------------------------------------

    global _start

; Conditional Move adalah jenis instruksi yang mirip dengan Move pada umumnya.
; Perbedaannya adalah pada pada evaluasi dimana instruksi terjadi jika kondisi
; telah terpenuhi.

; Operan sumber dan tujuan harus memiliki ukuran sesuai.

section .text
_start:

; signed
; CMOVE  (Move if Equal)
    ; move jika status ZF aktif
    cmove   eax, ebx

; CMOVNE (Move if Not Equal) 
    ; move jika status ZF nonaktif
    cmovne  eax, ebx

; CMOVG  (Move if Greater)
    ; move jika status ~(SF^OF) & ~ZF terpenuhi
    cmovg   eax, ebx 
    cmovnle eax, ebx    ; sepadan dengan CMOVG   

; CMOVGE (Move if Greater or Equal)
    ; move jika status ~(SF^OF) terpenuhi
    cmovge  eax, ebx 
    cmovnl  eax, ebx     ; sepadan dengan CMOVGE

; CMOVL  (Move if lower)
    ; move jika status SF^OF
    cmovl   eax, ebx
    cmovnge eax, ebx    ; sepadan dengan CMOVL

; CMOVLE (Move if lower or Equal)
    ; move jika status (SF^OF) | ZF
    cmovle  eax, ebx
    cmovng  eax, ebx     ; sepadan dengan CMOVLE

; CMOVS (Move if negative)
    ; move jika status SF aktif
    cmovs   eax, ebx 

; CMOVNS (Move is nonnegative)
    ; move jika status SF nonaktif
    cmovns  eax, ebx


; unsigned
; CMOVZ  (Move if zero)
    ; move jika status ZF aktif
    cmovz   eax, ebx     ; sepadan dengan CMOVE

; CMOVNZ (Move if Not zero)
    ; move jika status ZF nonaktif
    cmovnz  eax, ebx     ; sepadan dengan CMOVNE

; CMOVA  (Move if Above)
    ; move jika status ~CF & ~ZF terpenuhi
    cmova   eax, ebx
    cmovnbe eax, ebx    ; sepadan dengan CMOVA

; CMOVAE (Move if Above or Equal)
    ; move jika status CF nonaktif
    cmovae  eax, ebx
    cmovnb  eax, ebx    ; sepadan dengan CMOVAE

; CMOVB  (Move if Below)
    ; move jika status CF aktif
    cmovb   eax, ebx
    cmovnae eax, ebx    ; sepadan dengan CMOVB

; CMOVBE (Move if Below or Equal)
    ; move jika status CF | ZF terpenuhi
    cmovbe  eax, ebx 
    cmovna  eax, ebx    ; sepadan dengan CMOVBE

    hlt         ; Hentikan eksekusi