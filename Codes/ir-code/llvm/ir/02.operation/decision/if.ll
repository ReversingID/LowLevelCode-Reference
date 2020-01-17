;   If 
;   Decision-Making
;
;   Percabangan, pengambilan keputusan dengan pengecekan kondisi tunggal.
;
; LLVM Bitcode:
;   $ llvm-as if.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o if.asm if.ll
;
;-----------------------------------------------------------------------------

source_filename = "if.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Control-Flow
; Ketika suatu program berjalan, eksekusi instruksi dilakukan secara berurutan 
; dari awal hingga akhir. Namun dalam beberapa kondisi tertentu, terdapat
; kebutuhan untuk mengeksekusi instruksi di lokasi lain sebagai bentuk
; penanganan kasus.
;
; Konstruksi control-flow secara high-level dapat diterjemahkan menggunakan
; kombinasi percabangan antar Basic Block.


;   Percabangan adalah perpindahan eksekusi ke sekumpulan instruksi menggunakan
;   satu atau lebih instruksi branching.
;
; Tujuan:
;   implementasi statement "If-Then"
;   percabangan sederhana yang mengarahkan ke sekelompok instruksi jika kondisi 
;   terpenuhi
;
; Bentuk umum:
;   if (condition) then
;       do_action


define i32 @algorithm () {
entry:
    %ivar       = alloca i32, align 4
    store       i32 0, i32* %ivar, align 4

    ; periksa apakah kondisi terpenuhi dan lakukan percabangan jika true
    ; ini adalah implementasi efisien di level logic LLVM IR
    ;
    ;   if (var == 2)
    ;       var = 1;
     

    ; pemeriksaan kondisi
    %ivar.val   = load i32, i32* %ivar, align 4
    %cond       = icmp eq i32 %ivar.val, 2
    br          i1 %cond, label %do_action, label %end

do_action:
    ; eksekusi do_action karena kondisi terpenuhi
    store       i32 1, i32* %ivar, align 4
    br          label %end 

end:
    ; block ini akan dieksekusi terlepas dari hasil percabangan
    ret i32 0
}