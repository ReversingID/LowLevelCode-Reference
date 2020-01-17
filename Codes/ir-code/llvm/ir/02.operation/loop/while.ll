;   While
;   Loop
;
;   Perulangan sederhana dengan satu kondisi.
;
; LLVM Bitcode:
;   $ llvm-as while.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o while.asm while.ll
;
;-----------------------------------------------------------------------------

source_filename = "while.c"
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


;   Perulangan adalah serangkaian instruksi (dan block) yang ditulis sekali namun
;   dapat dieksekusi berkali-kali secara berturut-turut.
;
;   Instruksi perulangan dapat dikendalikan berdasarkan banyaknya perulangan
;   maupun kondisi perulangan yang harus terpenuhi.
;
; Tujuan:
;   implementasi konstruksi "While" sebagai perulangan sederhana.
;   While memiliki konstruksi yang mirip dengan Do-While namun dengan 
;   pemeriksaan kondisi terjadi di awal.
;
; Bentuk umum:
;   while (condition)
;       do_action
;
; catatan: 
;   kondisi kompleks merupakan kombinasi dari berbagai kondisi sederhana.


define i32 @algorithm () {
entry:
    %ivar       = alloca i32, align 4

    ; 
    ;
    ;   while (var <= 10) 
    ;   {
    ;       var ++;
    ;   }
    ;
    ; pada kasus tertentu, beberapa instruksi dapat mengubah kondisi.
    ; misal: perubahan counter, perubahan treshold, dsb.
     
    
    ; lakukan inisialisasi apapun jika diperlukan di sini
    store       i32 0, i32* %ivar, align 4

    ; secara eksplisit menyebutkan block penerus
    br          label %condition_check

condition_check:
    ; pemeriksaan kondisi
    ; periksa apakah perulangan akan dilakukan
    %ivar.val   = load i32, i32* %ivar, align 4
    %cond       = icmp sle i32 %ivar.val, 10
    br          i1 %cond, label %loop_body, label %end

loop_body:
    ; eksekusi do_action
    %ivar.old   = load i32, i32* %ivar, align 4
    %ivar.new   = add nsw i32 %ivar.old, 1
    store       i32 %ivar.new, i32* %ivar, align 4

    ; secara eksplisit menyebutkan block penerus
    br          label %condition_check

end:
    ; di luar loop
    ret i32 0
}