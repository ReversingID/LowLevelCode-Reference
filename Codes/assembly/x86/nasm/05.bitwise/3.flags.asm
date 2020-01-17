;   flags.asm
;
;   set / clear bit tertentu di register flag (EFLAGS)
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o flags.o flags.asm
;
;   (win32)
;   $ nasm -f win32 -o flags.o flags.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o flags flags.o
;
;   (windows)
;   $ ld -m i386pe -o flags flags.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
;   Comment beberapa instruksi untuk menyesuaikan dengan target platform.
; 
;-----------------------------------------------------------------------------

    global _start


section .text
_start:

; CF (Carry Flag)
    ; Carry Flag aktif otomatis ketika terdapat Carry pada operasi sebelumnya,
    ; entah dari operasi aritmetik maupun bitwise.
    ; Flag ini dapat diaktifkan (set) / dinonaktifkan (clear) secara manual.

    ; CLC (clear carry flag)
    clc 

    ; STC (set carry flag)
    stc 

    ; CMC (complement / toggling carry flag)
    cmc 


; IF (Interrupt Flag)
    ; Interrupt Flag adalah flag sistem yang menentukan apakah CPU akan
    ; menangani Maskable Hardware Interrupt.
    ; Flag ini dapat diaktifkan (set) / dinonaktifkan (clear) secara manual.

    ; CLI (clear interrupt flag)
    cli 

    ; STI (set interrupt flag)
    sti 


; DF (Direction Flag)
    ; Direction Flag adalah flag yang mengendalikan arah (kiri ke kanan atau kanan ke kiri)
    ; pada pemrosesan string.
    ; Flag ini dapat diaktifkan (set) / dinonaktifkan (clear) secara manual.

    ; CLD (clear direction flag)
    cld 

    ; STD (set direction flag)
    std 


; Load / Store flags into register
    ; LAHF (load flags into AH register)
    lahf 

    ; SAHF (store flags from AH register)
    sahf 




    hlt         ; Hentikan eksekusi