;   Multi-If
;   Decision-Making
;
;   Banyak pilihan percabangan dengan masing-masing memiliki kondisi sederhana 
;
; LLVM Bitcode:
;   $ llvm-as multi-if.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o multi-if.asm multi-if.ll
;
;-----------------------------------------------------------------------------

source_filename = "multi-if.c"
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
;   implementasi statement "Multi-If"
;   setiap cabang memiliki kondisi sederhana dan akan mengarahkan eksekusi ke blok
;   tertentu jika kondisi terpenuhi.
;
; Bentuk umum:
;   if (condition_1) then
;       do_action_1
;   else if (condition_2) then
;       do_action_2
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
    ;   else if (var == 1)
    ;       var = 0;
    ;   else
    ;       var = 2;
     

    ; pemeriksaan kondisi
    %ivar.val   = load i32, i32* %ivar, align 4
    %cond1      = icmp eq i32 %ivar.val, 2
    br          i1 %cond1, label %do_action_1, label %check_condition_2

do_action_1:
    ; eksekusi do_action_1 karena kondisi terpenuhi
    store       i32 1, i32* %ivar, align 4
    
    ; hindari block lain
    br          label %end 

check_condition_2:
    ; pemeriksaan kondisi untuk condition_2
    %cond2      = icmp eq i32 %ivar.val, 1
    br          i1 %cond2, label %do_action_2, label %do_alternative_action

do_action_2:
    ; eksekusi do_action_2 karena kondisi terpenuhi
    store       i32 0, i32* %ivar, align 4
    
    ; hindari block lain
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