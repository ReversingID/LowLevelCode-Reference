;   Calling Convention
;
;   Penggunaan Calling Convention pada LLVM IR
;
; LLVM Bitcode:
;   $ llvm-as calling-convention.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o calling-convention.asm calling-convention.ll
;
;-----------------------------------------------------------------------------

; -- LLVM IR - Module --
source_filename = "calling-convention.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Calling Convention, adalah konvensi (perjanjian) atau aturan yang mengendalikan 
; bagaimana pemanggilan fungsi dilakukan.
; Umumnya, sebuah calling convention mengatur:
;   - bagaimana argumen diberikan
;   - bagaimana nilai dikembalikan oleh fungsi
;   - bagaimana nilai register dipertahankan ketika pemanggilan fungsi
;   - siapa yang bertanggung jawab membersihkan stack (argumen) setelah pemanggilan.


; ccc
; C Calling Convention, atau CDECL
; Konvensi standard yang digunakan jika Calling Convention tidak disebutkan.
; Standard atau default digunakan di C.

define ccc i32 @function.cdecl (i32 %arg) {
    ret i32 %arg
}

; fastcc
; fastcall Calling Convention
; Sebagian argumen akan diberikan melalui register sehingga pemanggilan fungsi 
; dapat dilakukan secepat mungkin

define fastcc i32 @function.fastcc (i32 %arg) {
    ret i32 %arg
}


; coldcc
; Cold Calling Convention
; Mencoba untuk membuat kode pada Caller seefisien mungkin dengan asumsi bahwa call
; tidak secara umum dilakukan. Pemanggilan ini berusaha preserve semua register.

define coldcc i32 @function.coldcc (i32 %arg) {
    ret i32 %arg
}


; cc 10
; GHC Calling Convention
; Implementasi yang secara spesifik digunakan untuk Glasgow Haskell Compiler (GHC).
; Semua argumen diberikan ke register.

define cc 10 i32 @function.cc10 (i32 %arg)  {
    ret i32 %arg
}

; cc 11
; HiPE Calling Convention
; Implementasi yang secara spesifik digunakan untuk High-Performance Erlang (HiPE).

define cc 11 i32 @function.cc11 (i32 %arg) {
    ret i32 %arg
}


; webkit_jscc
; WebKit JavaScript Calling Convention

define webkit_jscc i32 @function.webkit_jscc (i32 %arg) {
    ret i32 %arg
}

; anyregcc
; Dynamic Calling Convention for Code patching

define anyregcc i32 @function.anyregcc (i32 %arg) {
    ret i32 %arg
}

; preserve_mostcc
; PreserveMost Calling Convention

define preserve_mostcc i32 @function.preserve_mostcc (i32 %arg) {
    ret i32 %arg
}

; preserve_allcc
; PreserveAll Calling Convention

define preserve_allcc i32 @function.preserve_allcc (i32 %arg) {
    ret i32 %arg
}

; cxx_fast_tlscc
; CXX_FAST_TLS Calling Convention

define cxx_fast_tlscc i32 @function.cxx_fast_tlscc (i32 %arg) {
    ret i32 %arg
}

; swiftcc
; Swift Calling Convention

define swiftcc i32 @function.swiftcc (i32 %arg) {
    ret i32 %arg
}