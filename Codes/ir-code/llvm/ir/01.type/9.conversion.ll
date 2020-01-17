;   Type Conversion
;   LLVM IR Data Type
;
;   Konversi data menjadi tipe databerbeda.
;
; LLVM Bitcode:
;   $ llvm-as conversion.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o conversion.asm conversion.ll
;
;-----------------------------------------------------------------------------

source_filename = "conversion.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; LLVM IR menggunakan prinsip Strong Type yang ketat. Setiap data yang terlibat
; dalam operasi, setiap nilai yang dihasilkan, harus menyertakan tipe data 
; secara eksplisit.

; Pemberlakuan Strong Type memberikan kemudahan dalam menghasilkan kode yang
; sesuai dengan arsitektur target.


; Type Conversion
; Mengubah suatu data dengan tipe tertentu menjadi tipe lain.
; Pada level LLVM IR, terdapat beberapa cara konversi 

define i32 @algorithm () {

    ; integer 
    %ivar       = alloca i32, align 4
    %lvar       = alloca i64, align 8

    store       i32 32, i32* %ivar,  align 1

    ; floating-point
    %fvar       = alloca float, align 4
    %dvar       = alloca double, align 8

    store       float 1.0, float* %fvar, align 4

; -- Promotion (Upcast) --
; Konversi dari tipe sejenis dalam keluarga yang sama dengan ukuran lebih besar
    ; Sign Extension (signed)
    %v01.val    = load i32, i32* %ivar, align 4
    %v01.conv   = sext i32 %v01.val to i64
    store       i64 %v01.conv, i64* %lvar, align 8
    
    ; Zero Extension (unsigned)
    %v02.val    = load i32, i32* %ivar, align 4
    %v02.conv   = zext i32 %v02.val to i64
    store       i64 %v02.conv, i64* %lvar, align 8

    ; floating-point 
    %v03.val    = load float, float* %fvar, align 4
    %v03.conv   = fpext float %v03.val to double
    store       double %v03.conv, double* %dvar, align 8


; -- Truncating (Downcast) --
; Konversi dari tipe sejenis dalam keluarga yang sama dengan ukuran lebih besar
    ; integer truncate
    %v11.val    = load i64, i64* %lvar, align 8
    %v11.conv   = trunc i64 %v11.val to i32
    store       i32 %v11.conv, i32* %ivar, align 1

    ; floating-point truncate 
    %v12.val    = load double, double* %dvar, align 8
    %v12.conv   = fptrunc double %v12.val to float
    store       float %v12.conv, float* %fvar, align 1


; -- Cross Number Format -- 
    ; unsigned integer to floating-point
    %v21.val    = load i32, i32* %ivar, align 4
    %v21.conv   = uitofp i32 %v21.val to float
    store       float %v21.conv, float* %fvar, align 4

    ; signed integer to floating-point
    %v22.val    = load i32, i32* %ivar, align 4
    %v22.conv   = sitofp i32 %v22.val to float
    store       float %v22.conv, float* %fvar, align 4

    ; floating-point to unsigned integer
    %v23.val    = load float, float* %fvar, align 4
    %v23.conv   = fptoui float %v23.val to i32
    store       i32 %v23.conv, i32* %ivar, align 4

    ; floating-point to signed integer
    %v24.val    = load float, float* %fvar, align 4
    %v24.conv   = fptosi float %v24.val to i32
    store       i32 %v24.conv, i32* %ivar, align 4


; Pointer Typecast
    ; pointer to integer
    %v31.val    = ptrtoint i32* %ivar to i64

    ; integer to pointer
    %v32.addr   = inttoptr i64 %v31.val to i32*


; Bitwise Cast
; interpretasi ulang bit menjadi tipe lain tanpa mengubah bit apapun.
    ; interpretasi i32* menjadi i8*
    %v41.addr   = bitcast i32* %ivar to i8*


    ret i32 0
}