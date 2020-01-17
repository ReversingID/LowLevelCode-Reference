;   define-data.asm
;
;   Definisikan data terinisialisasi di section .data
;   Data berupa konstanta dengan ukuran beragam.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o define-data.o define-data.asm
;
;   (win32)
;   $ nasm -f win32 -o define-data.o define-data.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o define-data define-data.o
;
;   (windows)
;   $ ld -m i386pe -o define-data define-data.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
; 
;-----------------------------------------------------------------------------

    global _start

; Definisikan data terinisialisasi
;
;   [label:] dX value [;comment]
;
; Ketika menghasilkan binary code, NASM akan mengalokasikan ruang untuk untaian
; byte di section terkait. Nilai yang didefinisikan oleh user akan disimpan ke
; ruang yang telah disediakan.
;
; Pemberian label tidak diwajibkan, tapi jika data akan diakses maka pelabelan
; harus dilakukan.
;
; Definisi data dilakukan dengan instruksi dX dengan X adalah tipe data yang diinginkan.
;   db = tulis bytes (8-bit)
;   dw = tulis words (16-bits)
;   dd = tulis double words (32-bits)
;   dq = tulis quad words (64-bits) atau double-precision float
;   dt = tulis ten bytes (80-bits) atau extended-precision float

section .data
    ; declare integers
    db    0x55                      ; hanya sebuah byte 0x55
    db    0x55, 0x56, 0x57          ; tiga byte berturutan
    db    'a', 0x55                 ; campuran bentuk karakter dan angka
    db    'hello',13,10,'$'         ; campuran string dan angka
    dw    0x1234                    ; 0x34 0x12
    dw    'a'                       ; 0x61 0x00
    dw    'ab'                      ; 0x61 0x62 (bentuk karakter)
    dw    'abc'                     ; 0x61 0x62 0x63 0x00 (string)
    dd    0x12345678                ; 0x78 0x56 0x34 0x12
    dd    1.234567e20               ; nilai floating-point
    dq    0x123456789abcdef0        ; delapan byte
    ; comment it or it might be error in 32-bit
    dt    0x123456789abcdef01234    ; sepuluh byte

    ; declare floating points
    dq    1.234567e20           ; delapan byte sebagai double-precision float
    dt    1.234567e20           ; extended-precision float

; NASM dapat pula menulis data yang diambil dari binary data file.
; Instruksi ini sepadan dengan penggunaan db dengan konten dari file.

    incbin  "file.txt"

; Jika data berulang, awalan 'times' dapat digunakan untuk mengindikasikan bahwa
; data berikutnya akan direplikasi sebanyak sekian salinan.

    buffer1: times 10 db 0xA5   ; buffer1 akan ada 10 blok 0xA5 (e.g: 0xA5, 0xA5, 0xA5, ...)
    buffer2: times 5 db 1, 2    ; buffer2 akan ada 5 blok 1 and 2 (e.g: 1, 2, 1, ...)

; argumen untuk 'times' bukan hanya angka namun juga ekspresi
    
    buffer3: db 'Hello NASM'            ; menjamin buffer memiliki panjang 64
             times 64-$+buffer3 db ' '

section .text
_start:
    hlt         ; Hentikan eksekusi