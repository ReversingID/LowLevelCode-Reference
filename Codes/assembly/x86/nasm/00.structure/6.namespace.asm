;   namespace.asm
;
;   Membuat namespace
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o namespace.o namespace.asm
;
;   (win32)
;   $ nasm -f win32 -o namespace.o namespace.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o namespace namespace.o
;
;   (windows)
;   $ ld -m i386pe -o namespace namespace.o
;
; Note:
;   Jalankan di lingkungan debugging / emulator
; 
;-----------------------------------------------------------------------------

    global _start

section .data

section .text

; Label merupakan sebuah token yang mengidentifikasi posisi dalam kode.
; Label dapat dilihat sebagai fungsi, tujuan percabangan, serta bagian loop.

_start:

; Label yang berawalan titik '.' akan mendapatkan label non-local sebelumnya
; sebagai bagian namana, yang akan memberikan keunikan.

; Namespace sangat berguna untuk membagi program ke dalam komponen-komponen kecil
; tanpa mencemari penamaan secara global.

labelspace:

;   Hal ini sebaiknya tidak dilakukan, tapi ini memberikan informasi apa yang
;   terjadi sebenarnya.

    jmp     labelspace.inside_label
    mov     eax, 1
    hlt

.inside_label:
    
;   Ini praktik yang disarankan ketika merujuk ke sebuah label.
    
    jmp     .inside_label2
    mov     eax, 2
    hlt 

.inside_label2:
    mov     eax, 3
    hlt 

; Label .inside_label dan .inside_label2 merupakan label di dalam namespace 'labelspace'.
; Keduanya dapat diakses berdasarkan nama utuh dan parsial. Dimungkinkan juga untuk 
; membuat hierarki lebih dalam.

    hlt         ; Hentikan eksekusi