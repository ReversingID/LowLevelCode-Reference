;   Branching
;
; LLVM Bitcode:
;   $ llvm-as branching.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o branching.asm branching.ll
;
;-----------------------------------------------------------------------------

source_filename = "branching.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Control-Flow
; Ketika suatu program berjalan, eksekusi instruksi dilakukan secara berurutan 
; dari awal hingga akhir. Namun dalam beberapa kondisi tertentu, terdapat
; kebutuhan untuk mengeksekusi instruksi di lokasi lain sebagai bentuk
; penanganan kasus. Beberapa kelompok operasi yang berperan dalam pengendalian
; alur program antara lain jump / branch dan comparison. 


; Jump / Branch
; Jump (lompat) adalah perpindahan alur eksekusi (execution flow) ke lokasi lain.
; Lokasi tujuan perpindahan ditandai dengan sebuah label, menjadi isyarat sebuah
; blok kode baru (Basic Block).
;
; Terdapat dua tipe jump: unconditional jump dan conditional jump
; Conditional Jump adalah jump dimana perpindahan hanya terjadi apabila kondisi
; tertentu terpenuhi. Sementara Unconditional Jump akan mengubah alur apapun kondisi
; yang terjadi pada saat itu.

define i32 @branching () {

; Branching (percabangan)
; Unconditional Branch diimplementasikan sebagai branching dengan hanya satu Label.
; Tidak ada evaluasi kondisi sebelum perpindahan perpindahan alur eksekusi terjadi.
;
; Conditional Branc diimplementasikan sebagai pemilihan dua alternatif Branch,
; berdasarkan nilai kondisi yang dievaluasi. Label pertama dipilih bila kondisi True
; terjadi, seblaiknya label kedua akan dipilih.
;
; Umumnya nilai boolean (i1) didapatkan dari evaluasi perbandingan (comparison)
; dua buah nilai.

; -- Unconditional Branch --
    br      label %Execute

    ret i32 2       ; Tidak akan dieksekusi

; -- Conditional Branch --
Execute:
    %cond   = icmp eq i32 0, 5
    br      i1 %cond, label %IfEqual, label %IfInequal

IfEqual:
    ret i32 1

IfInequal:
    ret i32 0


; Sebuah label dianggap sebagai sebuah "variabel" yang menyimpan alamat Basic Block.
}