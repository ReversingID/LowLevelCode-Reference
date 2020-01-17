;   section-ext-elf.asm
;
;   Section extension untuk ELF
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o section-ext-elf.o section-ext-elf.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o section-ext-elf section-ext-elf.o
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
;   - alloc / noalloc:   definisikan apabila section dimuat ke memory ketika runtime.
;   - exec / no exec:    definisikan apakah section merupakan bagian executable ketika runtime.
;   - write / nowrite:   definisikan apakah section merupakan bagian writable ketika runtime.
;   - progbits / nobits: definisikan apakah section section secara eksplisit disimpan 
;                        ke object file.
;   - align:             definisikan alignment yang digunakan section
;   - tls:               definisikan section memiliki Thread Local variables.

section .data progbits alloc noexec write align=4
    immutable_data: db 10

section .bss  nobits alloc noexec wrie align=4
    mutable_data: resb 1

section .text progbits alloc exec nowrite align=16
_start:

    hlt         ; Hentikan eksekusi

; Sample:
;   section .rodata    progbits alloc noexec nowrite align=4
;   section .lrodata   progbits alloc noexec nowrite align=4
;   section .ldata     progbits alloc noexec write align=4
;   section .lbss      nogbits  alloc noexec write align=4
;   section .tdata     progbits alloc noexec write align=4 tls
;   section .tbss      nobits   alloc noexec write align=4 tls
;   section .comment   progbits alloc noexec nowrite align=1
;   section other      progbits alloc noexec nowrite align=1
