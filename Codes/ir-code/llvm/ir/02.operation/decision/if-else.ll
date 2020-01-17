;   If-Else
;   Decision-Making
;
;   Percabangan, pengambilan keputusan dengan pengecekan kondisi tunggal, aksi,
;   dan alternatifnya.
;
; LLVM Bitcode:
;   $ llvm-as if-else.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o if-else.asm if-else.ll
;
;-----------------------------------------------------------------------------

source_filename = "if-else.c"
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
;   implementasi statement "If-Else"
;   percabangan sederhana yang mengarahkan ke sekelompok instruksi jika kondisi 
;   terpenuhi
;
; Bentuk umum:
;   if (condition) then
;       do_action
;   else
;       do_alternative_action


define i32 @algorithm () {
entry:
    %ivar       = alloca i32, align 4
    store       i32 0, i32* %ivar, align 4

    ; periksa apakah kondisi terpenuhi dan lakukan percabangan jika true
    ; ini adalah implementasi efisien di level logic LLVM IR
    ;
    ;   if (var == 2)
    ;       var = 1;
    ;   else
    ;       var = 0;
     

    ; pemeriksaan kondisi
    %ivar.val   = load i32, i32* %ivar, align 4
    %cond       = icmp eq i32 %ivar.val, 2
    br          i1 %cond, label %do_action, label %do_alternative_action

do_action:
    ; eksekusi do_action karena kondisi terpenuhi
    store       i32 1, i32* %ivar, align 4
    
    ; hindari block untuk "else" atau aksi alternatif
    br          label %end 

do_alternative_action:
    ; eksekusi do_alternative_action karena kondisi tak terpenuhi
    store       i32 0, i32* %ivar, align 4

    ; secara eksplisit menyebutkan bahwa block penerus adalah block end
    br          label %end

end:
    ; block ini akan dieksekusi terlepas dari hasil percabangan
    ret i32 0
}