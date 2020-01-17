;   Private Function
;
;   Deklarasi private function
;
; LLVM Bitcode:
;   $ llvm-as private.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o private.asm private.ll
;
;-----------------------------------------------------------------------------

source_filename = "private.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Private Function
; Sebuah fungsi dapat dibatasi penggunaan atau akses terhadapnya.
; Pembatasan dapat berupa isolasi sehingga fungsi hanya dapat dikenali dan diakses
; di dalam sebuah modul. Dalam hal ini, referensi di luar module (yang mendefinisikan)
; tidak akan dapat dilakukan.


; Definisi sebuah fungsi
;   - diidentifikasi sebagai @priv_func
;   - tidak menerima argumen
;   - mengembalikan nilai bertipe i32
define private i32 @priv_func () {
    ret i32 135
}