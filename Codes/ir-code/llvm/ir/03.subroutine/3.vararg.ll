;   Vararg & Variadic Function
;
;   Deklarasi dan penggunaan fungsi dengan argumen dinamis
;
; LLVM Bitcode:
;   $ llvm-as vararg.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o vararg.asm vararg.ll
;
;-----------------------------------------------------------------------------

source_filename = "vararg.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Vararg
; Variable Argument (vararg) adalah argumen sebuah method yang dapat menerima
; sembarang jumlah argumen yang diberikan. Fungsi yang mengimplementasikan vararg
; disebut sebagai Variadic Function atau fungsi yang memiliki arity tak tentu.

; Normalnya sebuah fungsi dideklarasikan dengan jumlah dan tipe argumen yang pasti.
; Setiap fungsi memiliki signature berdasarkan tipe kembalian dan tipe tiap argumen
; yang dimiliki.

; Variadic Function tidak mendeklarasikan jumlah argumen yang pasti. Tidak pula tipe
; argumen yang diterima.


; Variadic function 
define i32 @variadic_func (...) {
    ret i32 0
}

; Variadic function dengan 1 argumen pasti
define i32 @variadic_func2 (i32, ...) {
    ret i32 0
}

define i32 @algorithm () {
    ; pemanggilan dengan 4 argumen
    call i32 (...) @variadic_func (i32 1, i32 2, i32 3, i32 4)

    ; pemanggilan dengan 2 argumen
    call i32 (...) @variadic_func (i32 8, i32 9)

    ; pemanggilan dengan 3 argumen: 1 argumen pasti, 2 vararg
    call i32 (i32, ...) @variadic_func2 (i32 1, i32 2, i32 3)
    
    
    ret i32 0
}