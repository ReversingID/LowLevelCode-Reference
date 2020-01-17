;   Nested-If
;   Decision-Making
;
;   Pemilihan keputusan secara bersarang. 
;
; LLVM Bitcode:
;   $ llvm-as nested-if.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o nested-if.asm nested-if.ll
;
;-----------------------------------------------------------------------------

source_filename = "nested-if.c"
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
;   implementasi percabangan bersarang.
;   sebuah percabangan dapat didefinisikan di dalam blok aksi percabangan lain.
;
; Bentuk umum:
;   if (condition_1) then
;       do_action_1
;       if (condition_2) then
;           do_action_2


define i32 @algorithm () {
entry:
    %ivar1      = alloca i32, align 4
    %ivar2      = alloca i32, align 4
    store       i32 0, i32* %ivar1, align 4
    store       i32 0, i32* %ivar2, align 4

    ; perlu dicatat bahwa pemeriksaan kondisi condition_2 hanya terjadi jika
    ; condition_1 terpenuhi.
    ; Dapat dikatakan bahwa pemeriksaan condition_2 berada pada block sama
    ; dengan do_action_1
    ;
    ;   if (var1 == 0)
    ;   {
    ;       var1 = 10;
    ;       if (var2 == 0)
    ;           var2 = 20;
    ;   }
     

    ; pemeriksaan kondisi condition_1
    %ivar1.val  = load i32, i32* %ivar1, align 4
    %cond1      = icmp eq i32 %ivar1.val, 0
    br          i1 %cond1, label %do_action_1, label %end

do_action_1:
    ; eksekusi do_action_1 karena kondisi terpenuhi
    store       i32 10, i32* %ivar1, align 4

    ; pemeriksaan kondisi untuk condition_2
    %ivar2.val  = load i32, i32* %ivar2, align 4
    %cond2      = icmp eq i32 %ivar2.val, 0
    br          i1 %cond2, label %do_action_2, label %end

do_action_2:
    ; eksekusi do_action_2 karena kondisi terpenuhi
    store       i32 20, i32* %ivar2, align 4
    
    ; secara eksplisit menyebutkan bahwa block penerus adalah block end
    br          label %end

end:
    ; block ini akan dieksekusi terlepas dari hasil percabangan
    ret i32 0
}