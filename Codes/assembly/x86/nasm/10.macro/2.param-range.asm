;   param-range.asm
;
;   NASM Macro Preprocessing.
;   Konstruksi khusus digunakan untuk penanganan rentang dan elemen
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o param-range.o param-range.asm
;
;   (win32)
;   $ nasm -f win32 -o param-range.o param-range.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o param-range param-range.o
;
;   (windows)
;   $ ld -m i386pe -o param-range param-range.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
; 
;-----------------------------------------------------------------------------

    global _start

; NASM dapat ekspansi parameter melalui konstruksi khusus %{x:y} dimana x adalah
; indeks parameter pertama dan y adalah indeks terakhir.

; Indeks dapat berupa bilangan negatif atau positif tapi tidak dapat nol.

; macro ini menerima jumlah parameter bervariasi

; this macro receive variable number of parameter
%macro mpar 1-*
    db %{3:5}
%endmacro

; Valid range:
; Positive range
;   %{1:3}

; Negative range, urutan dari belakang ke depan.
; ekspansi 1,2,3,4 menjadi 4,3,2
;   %{-1:-3}

; Mix range
;   %{3:-3}

; Single element
;   %{-1:-1}



section .data
    ; ekspansi macro terjadi ketika digunakan

    ; ekspansi macro untuk menerima elemen 3, 4, 5
arr:  mpr 1,2,3,4,5,6
    ; db 3, 4, 5

section .text 
_start:

    hlt