;   section-ext-pe.asm
;
;   Section extension untuk PE.
;
; Assemble:
;   (win32)
;   $ nasm -f win32 -o section-ext-pe.o section-ext-pe.asm
;
; Link:
;   (windows)
;   $ ld -m i386pe -o section-ext-pe section-ext-pe.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
; 
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
; Directive tambahan tersedia untuk mengendalikan tipe dan properti dari sections.
; Jika tidak dideklarasikan, NASM akan menghasilkan perkiraan properti yang sesuai.
; Section dengan nama standard akan di-assign secara otomatis.
; Properti umumnya berguna untuk custom-section.
;-----------------------------------------------------------------------------

    global _start

; The available qualifier:
;   - code (or text): section merupakan code section, menjadi readable dan executable
;                     namun bukan tidak writable.
;   - data & bss:     section merupakan data section, menjadi readable dan writable
;                     namun tidak executable. Perbedaan antara data dan bss terletak
;                     pada keadaan inisialisasi.
;   - info:           section merupakan bersifat informational, tidak ada padanan yang
;                     dihasilkan ke binary oleh linker.

; NASM membebaskan alignment, umumnya bernilai perpangkatan 2.

; Section .data merupakan "data section" dengan alignment 4
section .data data align=4
    immutable_data: db 10

; Section .bss merupakan "bss section" dengan alignment 4
section .bss  bss align=4
    mutable_data: resb 1

; Section .text merupakan "code section" dengan alignment 16
section .text code align=16
_start:

    hlt         ; Hentikan eksekusi