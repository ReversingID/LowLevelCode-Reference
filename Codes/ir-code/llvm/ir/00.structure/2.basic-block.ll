;   Basic Block
;
;   LLVM IR terdiri atas beberapa komponen yang tersusun secara terstruktur
;
; LLVM Bitcode:
;   $ llvm-as basic-block.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o basic-block.asm basic-block.ll
;
;-----------------------------------------------------------------------------

; LLVM IR - Module

source_filename = "basic-block.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; LLVM IR - Function
; Implementasi fungsi faktorial
define i32 @algorithm (i32 %arg) {


; LLVM IR - Basic Block
; Basic Block terdiri atas beberapa komponen:
;   - Label
;   - Instructions
;       - Phi Instruction
;   - Terminator

    ; -- Basic Block --
    ; Basic Block tidak didefinisikan secara eksplisit.
    ; Instruksi-instruksi yang diakhiri dengan Terminator akan dianggap sebagai
    ; sebuah Basic Block.
    ; Terminator dapat berupa:
    ;   - br    (branch)
    ;   - ret   (return)

    ; Basic Block 0
    ; melakukan perbandingan nilai
entry:
    %is_base_case = icmp eq i32 %arg, 0
    br  i1 %is_base_case, label %base_case, label %recursive_case

    ; Basic Block 1
    ; mengembalikan nilai 1
base_case:
    ret i32 1

    ; Basic Block 2
    ; menghitung nilai (arg - 1), memanggil @algorithm() secara rekursif
    ; menghitung nilai dan mengembalikannya.
recursive_case:
    %0 = add    i32 -1, %arg 
    %1 = call   i32 @algorithm(i32 %0)
    %2 = mul    i32 %arg, %1
    ret i32 %2
}

; Label
; Label adalah token untuk identifikasi posisi dalam kode (dan memori nantinya).
; Sebuah label dapat dianggap sebagai tujuan dari branching atau bagian dari loop.
; Dengan kata lain, label merupakan penanda sebuah Basic Block.
; Tidak seperti assembly pada arsitektur tertentu, label pada LLVM IR bukan
; merupakan penanda sebuah fungsi.


; Instructions
; Instruksi merupakan sebuah operasi tunggal yang dapat dikerjakan oleh pemroses.
; Terdapat banyak tipe instruksi, lihat juga contoh pada 'data-movement', 
; 'arithmetic-operation', 'comparision', dan 'logical'


; Terminator
; Terminator atau Terminator Instruction adalah sebuah instruksi yang mengakhiri
; sebuah Basic Block. Terminator akan mengarahkan alur eksekusi menuju ke 
; Basic Block lain (successor).