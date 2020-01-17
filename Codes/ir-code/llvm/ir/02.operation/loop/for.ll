;   For
;   Loop
;
;   Perulangan sederhana dengan satu kondisi.
;
; LLVM Bitcode:
;   $ llvm-as for.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o for.asm for.ll
;
;-----------------------------------------------------------------------------

source_filename = "for.c"
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
;   implementasi konstruksi "For" sebagai perulangan sederhana.
;   For adalah konstruksi perulangan yang dikontrol menggunakan sebuah counter
;   untuk mengeksekusi block kode sebanyak sekian kali.
;
; Bentuk umum:
;   for (initialization; condition; counter_update)
;       do_action
;
; catatan: 
;   kondisi kompleks merupakan kombinasi dari berbagai kondisi sederhana.


define i32 @algorithm () {
entry:
    %iarr       = alloca [10 x i32], align 16
    %ictr       = alloca i32, align 4

    ; struktur loop For dapat dipecah menjadi empat bagian:
    ;   - initialization
    ;   - condition checking
    ;   - counter update (increment/decrement)
    ;   - loop body
    ;
    ; sehingga struktur for dapat dipecah dari
    ;
    ;   for (i = 0; i < 10; i++)
    ;       iarr[i] = i;
    ;
    ; menjadi
    ;
    ;   i = 0;
    ;   while (i < 10) {
    ;       iarr[i] = i;
    ;       i ++;
    ;   }
     
    
    ; inisialisasi
    store       i32 0, i32* %ictr, align 4

    ; secara eksplisit menyebutkan block penerus
    br          label %condition_check

condition_check:
    ; pemeriksaan kondisi
    ; periksa apakah perulangan akan dilakukan lagi
    %ictr.val   = load i32, i32* %ictr, align 4
    %cond       = icmp sle i32 %ictr.val, 10
    br          i1 %cond, label %loop_body, label %end

loop_body:
    ; eksekusi do_action
    ; %ictr digunakan sebagai counter dan nilai yang dimasukkan ke array
    %rhs.val    = load i32, i32* %ictr, align 4
    %idx.val    = load i32, i32* %ictr, align 4

    ; extend agar i32 menjadi i64
    %idx.sext   = sext i32 %idx.val to i64
    %arr.addr   = getelementptr inbounds [10 x i32], [10 x i32]* %iarr, i64 0, i64 %idx.sext
    store       i32 %rhs.val, i32* %arr.addr, align 4

    ; secara eksplisit menyebutkan block penerus
    br          label %loop_update

loop_update:
    ; tingkatkan nilai counter
    %ictr.old   = load i32, i32* %ictr, align 4
    %ictr.new   = add nsw i32 %ictr.old, 1
    store       i32 %ictr.new, i32* %ictr, align 4

    ; secara eksplisit menyebutkan block penerus
    br          label %condition_check

end:
    ; di luar loop
    ret i32 0
}