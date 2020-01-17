;   Complex Condition
;   Decision-Making
;
;   Percabangan dengan pemeriksaan kondisi kompleks.
;
; LLVM Bitcode:
;   $ llvm-as complex-condition.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o complex-condition.asm complex-condition.ll
;
;-----------------------------------------------------------------------------

source_filename = "complex-condition.c"
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
;   percabangan dengan pemeriksaan kondisi kompleks dan mengarahkan ke block
;   instruksi jika kondisi terpenuhi.
;   kondisi kompleks adalah kombinasi dari beberapa kondisi sederhana.
;
; Bentuk umum:
;   if (condition) then
;       do_action
;
;   tipe condition:
;       condition_1 AND condition_2
;       condition_1 OR condition_2


;-----------------------------------------------------------------------------
;   condition_1 AND condition_2
;
;   Ekspresi logika ini akan bernilai True jika kedua kondisi bernilai True
;   Karena itu, ketika evaluasi kondisi dari kiri ke kanan, jika terdapat satu 
;   kondisi bernilai False, maka aksi tidak akan dieksekusi.
;
;   if (var1 > 0 && var2 < 0)
;       var1 = 10;

define i32 @complex_and () {
entry:
    %ivar1      = alloca i32, align 4
    %ivar2      = alloca i32, align 4
    store       i32 0, i32* %ivar1, align 4
    store       i32 0, i32* %ivar2, align 4

    ; pemeriksaan kondisi
    
    ; jika var1 lebih kecil daripada 0
    ; kondisi kompleks akan dievaluasi sebagai False
    %ivar1.val  = load i32, i32* %ivar1, align 4
    %cond1      = icmp sgt i32 %ivar1.val, 0
    br          i1 %cond1, label %check_subcondition_2, label %end

check_subcondition_2:
    ; jika var2 lebih besar daripada 0
    ; kondisi kompleks akan dievaluasi sebagai False
    %ivar2.val  = load i32, i32* %ivar2, align 4
    %cond2      = icmp slt i32 %ivar2.val, 0
    br          i1 %cond2, label %do_action, label %end

do_action:
    ; eksekusi do_action karena kondisi terpenuhi
    store       i32 10, i32* %ivar1, align 4
    
    ; secara eksplisit menyebutkan bahwa block penerus adalah block end
    br          label %end

end:
    ; block ini akan dieksekusi terlepas dari hasil percabangan
    ret i32 0
}


;-----------------------------------------------------------------------------
;   condition_1 OR condition_2
;
;   Ekspresi logika ini akan bernilai True jika salah satu kondisi bernilai True
;   Karena itu, ketika evaluasi kondisi dari kiri ke kanan, jika terdapat satu 
;   kondisi bernilai True, maka aksi akan dieksekusi.
;
;   if (var1 > 0 || var2 > 0)
;       var1 = 10;

define i32 @complex_or () {
entry:
    %ivar1      = alloca i32, align 4
    %ivar2      = alloca i32, align 4
    store       i32 0, i32* %ivar1, align 4
    store       i32 0, i32* %ivar2, align 4

    ; pemeriksaan kondisi
    
    ; jika var1 lebih besar daripada 0
    ; kondisi kompleks akan dievaluasi sebagai True
    %ivar1.val  = load i32, i32* %ivar1, align 4
    %cond1      = icmp sgt i32 %ivar1.val, 0
    br          i1 %cond1, label %do_action, label %check_subcondition_2

check_subcondition_2:
    ; jika var2 lebih besar daripada 0
    ; kondisi kompleks akan dievaluasi sebagai False
    %ivar2.val  = load i32, i32* %ivar2, align 4
    %cond2      = icmp sgt i32 %ivar2.val, 0
    br          i1 %cond2, label %do_action, label %end

do_action:
    ; eksekusi do_action karena kondisi terpenuhi
    store       i32 10, i32* %ivar1, align 4
    
    ; secara eksplisit menyebutkan bahwa block penerus adalah block end
    br          label %end

end:
    ; block ini akan dieksekusi terlepas dari hasil percabangan
    ret i32 0
}