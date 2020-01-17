;   struc.asm
;
;   Mendefinisikan struktur data dengan macro
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o struc.o struc.asm
;
;   (win32)
;   $ nasm -f win32 -o struc.o struc.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o struc struc.o
;
;   (windows)
;   $ ld -m i386pe -o struc struc.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
; 
;-----------------------------------------------------------------------------

; Sebuah struktur adalah koleksi / kumpulan data yang disusun menjadi satu kesatuan.
; Semua struc harus didefinisikan di dalam "struc" dan "endstruct".

; Definisikan struktur data
struc person
    .name: resb 10
    .age:  resb 1
endstruc


    global _start

section .data
    ; buat instance dari struktur "person"
    xathrya: istruc person 
        at person.name, db "Xathrya"
        at person.age,  db 19
    iend 

section .text 
_start:
    ; akses field dari struktur
    mov     eax, [xathrya + person.name]

    hlt