;   strings.asm
;
;   Deklarasi string.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o strings.o strings.asm
;
;   (win32)
;   $ nasm -f win32 -o strings.o strings.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o strings strings.o
;
;   (windows)
;   $ ld -m i386pe -o strings strings.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
; 
;-----------------------------------------------------------------------------

    global _start

; String adalah array of characters atau deretan karakter yang padu.
; Karakter adalah representasi byte.
; Sebuah string dapat didefinisikan dalam berbagai kombinasi.

section .data

; [1] String constant
; Seperti konstanta karakter, tapi lebih panjang.

    db 'Hello'                  ; string constant
    db 'H', 'e', 'l', 'l', 'o'  ; konstanta karakter yang speadan

    dd 'ninechars'              ; doubleword string constant
    dd 'nine', 'char', 's'      ; menjadi tiga dwords
    db 'ninechars', 0, 0, 0     ; sama dengan dua deklarasi sebelumnya.


; [2] Unicode string 
; Operator khusus disediakan untuk mendefinisikan unicode string.
;   __utf16__       __utf16le__         __utf16be__
;   __utf32__       __utf32le__         __utf32be__
;
; Fungsi tersebut menerima string UTF-8 dan mengubahnya menjadi UTF-16
; atau UTF-32. Jika tak disebutkan, output akan menggunakan little endian.
    dw __utf16__('C:\WINDOWS'), 0       ; pathname in UTF-16
    dd __utf32__('A + B = \u206a'), 0   ; string in UTF-32

section .text
_start:
    hlt         ; Hentikan eksekusi