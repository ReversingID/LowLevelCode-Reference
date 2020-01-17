;   floats.asm
;
;   Deklarasi floating-point.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o floats.o floats.asm
;
;   (win32)
;   $ nasm -f win32 -o floats.o floats.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o floats floats.o
;
;   (windows)
;   $ ld -m i386pe -o floats floats.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
; 
;-----------------------------------------------------------------------------

    global _start

; Konstanta floating point hanya diterima sebagai argumen untuk instruksi
;   DB, DW, DD, DQ, DT, and D0

; atau sebagai argument untuk operator khusus:
;   __float8__,    __float16__,  __float32__, 
;   __float64__,   __float80m__, __float80e__,
;   __float128l__, __float128h__

section .data
    db    -0.2                    ; "Quarter precision" 
    dw    -0.5                    ; IEEE 754r/SSE5 half precision 
    dd    1.2                     ;  
    dd    1.222_222_222           ; penggunaan underscore diperbolehkan memisah digit
    dd    0x1p+2                  ; 1.0x2^2 = 4.0 
    dq    0x1p+32                 ; 1.0x2^32 = 4 294 967 296.0 
    dq    1.e10                   ; 10 000 000 000.0 
    dq    1.e+10                  ; sama dengan 1.e10 
    dq    1.e-10                  ; 0.000 000 000 1 
    dt    3.141592653589793238462 ; pi 
    do    1.e+4000                ; IEEE 754r quad precision

section .text
_start:

; Operator khusus digunakan untuk menghasilkan bilangan floating point (pecahan) di 
; konteks lain. Operator ini menghasilkan representasi biner dari floating point
; sebagai bilangan bulat.

    mov     eax, __float32__(3.141592653589793238462)

; akan menjadi

    mov     eax, 0x40490fdb

; Sesuai spesifikasi IEEE754, token khusus untuk mengidentifikasi infinity dan NaN
; juga tersedia.
;   __Infinity__        floating point number infinity value
;   __QNaN__, __NaN__   quiet NaN
;   __SNaN__            signaling NaN   

    hlt         ; Hentikan eksekusi