;   signness.asm
;
;   Data adalah untaian byte.
;   Dapat merepresentasikan apa saja dari angka sederhana hingga
;   user-defined data.
;   Bilangan dapat dilihat sebagai bilangan bertanda atau tak bertanda
;   (sign / unsigned number)
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o signness.o signness.asm
;
;   (win32)
;   $ nasm -f win32 -o signness.o signness.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o signness signness.o
;
;   (windows)
;   $ ld -m i386pe -o signness signness.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
; 
;-----------------------------------------------------------------------------

    global _start

; Sign adalah pertanda bahwa bilangan memiliki kemampuan untuk mengakomodasi
; bilangan negatif di sistem bilangan.

section .data

; Memory hanyalah untaian byte, dapat diisi dengan nilai signed ataupun unsigned.
; Tidak dapat dipastikan apakah sebuah data biner merupakan data sign atau unsigned.
;
; Nilai negatif dapat disimpulkan dalam serangkaian instruksi yang melibatkannya.
; Namun tidak ada cara yang pasti untuk meyakinkan apakah benar nilai tersebut
; merupakan nilai negatif.

    data1: db    15     ; data1 = 0F
    data2: db   -15     ; data2 = F1
    data3: db  0xF1     ; data3 = F1
    data4: dw  -135     ; data4 = FF 79
    data5: dw 65401     ; data5 = FF 79

; data2 merupakan bilangan signed, sementara data3 unsigned. Pada akhirnya kedua bilangan
; akan menghasilkan nilai yang sama yaitu 0xF1. Hal ini dapat diverifikasi dengan 
; hexdump atau disassembler.

; Dengan melihat source code, diketahui bahwa data dideklarasikan sebagai signed, tapi
; ketika melihat binary, hal itu tidak dapat dipastikan.
;
; Pertanyaannya, bagaimana dapat diketahui bahwa sebuah nilai merupakan bilangan negatif?
; Tidak ada cara yang jitu untuk menentukannya dengan melihat untaian byte saja. Perlu
; analisis dari instruksi yang memanipulasi data tersebut.

section .text
_start:
    hlt         ; Hentikan eksekusi