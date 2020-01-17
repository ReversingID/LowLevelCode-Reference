;   Function
;
;   LLVM IR terdiri atas beberapa komponen yang tersusun secara terstruktur
;
; LLVM Bitcode:
;   $ llvm-as function.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o function.asm function.ll
;
;-----------------------------------------------------------------------------

; LLVM IR - Module

source_filename = "function.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; LLVM IR - Function

; Function terdiri atas beberapa komponen:
;   - Argument
;   - Basic Block
;       - Entry Basic Block

; Sebuah fungsi merupakan identitas global yang diidentifikasi melalui sebuah nama
; dengan diawali simbol @ sebagai penanda Global Symbol.

; Setiap fungsi harus dideklarasikan atau didefinisikan sebelum dapat digunakan.


; -- Function Declaration --
; Deklarasi (declaration) memberikan informasi keberadaan fungsi di modul.
; Deklarasi menyatakan bahwa sebuah fungsi didefinisikan di luar (eksternal) module.

; Deklarasi sebuah fungsi
;   - diidentifikasi sebagai @fnc_declare
;   - menerima 1 argumen bertipe i32 dengan nama %arg
;   - mengembalikan nilai bertipe i32
declare i32 @fnc_declare (i32 %arg)


; -- Function Definition --
; Definisi (definition) memberikan informasi wujud konkret dari fungsi.
; Definisi menyatakan deklarasi sebuah fungsi beserta badan fungsi tersebut.

; Definisi sebuah fungsi
;   - diidentifikasi sebagai @fnc_define
;   - menerima 1 argumen bertipe i32 dengan nama %arg
;   - mengembalikan nilai bertipe i32
;   - pada badan fungsi melakukan pemanggilan terhadap @func_declare
define i32 @fnc_define (i32 %arg) {
    %ret = call i32 @func_declare(i32 %arg)
    ret i32 %ret
}