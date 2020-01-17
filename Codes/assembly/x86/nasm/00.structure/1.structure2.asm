;   structure2.asm
;
;   Kode assembly terdiri atas beberapa komponen yang tersusun secara
;   terstruktur.
;
;   File ini mirip dengan structure.asm dengan perbedaan pada gaya penulisan.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o structure2.o structure2.asm
;
;   (win32)
;   $ nasm -f win32 -o structure2.o structure2.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o structure2 structure2.o
;
;   (windows)
;   $ ld -m i386pe -o structure2 structure2.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
; 
;-----------------------------------------------------------------------------

; Directive

    [global _start]

; Penulisan [section .xyz] dan section .xyz mirip namun memiliki perbedaan.
; Bentuk [section .xyz] merupakan bentuk dasar (primitive)

; Section
; Section '.data' memberitahu assembler bahwa isi yang ada di area memori ini 
; dilihat sebagai data, bukan instruksi.
; Umumnya, semua konstanta diletakkan di section .data

[section .data]
    string: db "A string", 10

; Section
; Section '.text' memberitahu assembler bahwa isi yang ada di area memori ini
; dilihat sebagai instruksi.
; Pada dasarnya, semua instruksi diletakkan pada section .text

[section .text]

; Label
; Label adalah token untuk identifikasi posisi dalam kode (dan memori nantinya).
; Sebuah label dapat dianggap sebagai fungsi, tujuan dari branching, atau bagian
; dari loop.

; Nasm tidak memiliki aturan ketat terhadap whitespace pada sebuah baris.
; Dimungkinkan untuk meletakkan whitespace sebelum dan sesudah sebuah label tanpa
; mengubah maksud secara semantik.
; Penggunaan titik dua (colon :) juga berupakan hal yang opsional.

_start:         ; Label ini global, artinya linker atau kode di luar modul dapat
                ; merujuk ke posisi ini.

; Instruction
; Instruksi adalah statement yang memberitahu processor apa yang harus dikerjakan.
; Lihat juga contoh pada 'data-movement', 'arithmetic-operation', 'comparision',
; dan 'logical'

    mov     eax, 1
    mov     ebx, 2
    cmp     eax, ebx 
    
    hlt         ; Hentikan eksekusi

; Sebuah program terdiri atas dua bagian: data dan instruksi
; Namun sebuah program dapat dibagi menjadi tiga section:
;   - Data section
;   - BSS section
;   - Text section

; Data section digunakan untuk mendeklarasikan data terinisialisasi ataupun konstan.
; Data ini tidak berubah selama runtime. Lihat juga bagian 'declaration'

; BSS section digunakan untuk mendeklarasikan variabel global. Data ini bersifat 
; mutable (dapat berubah selama runtime). Lihat juga bagian 'declaration'

; Text section digunakan untuk menyimpan kode / instruksi. Beberapa compiler
; memiliki aturan umum yaitu instruksi pertama dimulai pada label _start.