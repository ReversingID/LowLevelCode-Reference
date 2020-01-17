;   Value Selection
;
;   Pemilihan nilai berdasarkan kondisi.
;
; LLVM Bitcode:
;   $ llvm-as select.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o select.asm select.ll
;
;-----------------------------------------------------------------------------

source_filename = "select.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Selection
; Pemilihan nilai dari dua pilihan nilai berdasarkan kondisi yang harus dipenuhi.

define i32 @selection () {

; Selection (pemilihan)
; Instruksi pemilihan menerima sebuah nilai kondisi boolean. Dua nilai sebagai opsi
; nilai akan dipilih berdasarkan kondisi yang diberikan. Nilai pertama dipilih bila
; kondisi True terjadi, sebaliknya nilai kedua akan dipilih.
;
; Umumnya nilai boolean (i1) didapatkan dari evaluasi perbandingan (comparison)
; dua buah nilai.

    ; Kondisi didapat dari evaluasi instruksi perbandingan
    %cond       = icmp eq i32 0, 5
    %value      = select i1 %cond, i8 135, i8 182

    ; Kondisi true diberikan untuk memaksa pemilihan nilai pertama
    %value2     = select i1 true, i8 135, i8 182
    
    ret i32 0
}