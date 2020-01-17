;   Pointer
;   LLVM IR Data Type
;
; LLVM Bitcode:
;   $ llvm-as pointer.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o pointer.asm pointer.ll
;
;-----------------------------------------------------------------------------

source_filename = "pointer.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; LLVM IR menggunakan prinsip Strong Type yang ketat. Setiap data yang terlibat
; dalam operasi, setiap nilai yang dihasilkan, harus menyertakan tipe data 
; secara eksplisit.

; Pemberlakuan Strong Type memberikan kemudahan dalam menghasilkan kode yang
; sesuai dengan arsitektur target.


; Pointer
; Pointer (penunjuk) adalah tipe data yang menyimpan suatu alamat memory, spesifik
; terhadap suatu lokasi. Umumnya Pointer digunakan untuk melakukan Reference dan
; Dereference objek di memori.

; Pointer merupakan sebuah variabel yang memerlukan alokasi ruang. Implementasi
; ini bergantung kepada masing-masing arsitektur dimana ukuran Pointer bergantung
; kepada panjang data yang dapat dioperasikan oleh processor.


; Deklarasi
; Pointer dideklarasikan dengna sintaks TYPE*, dimana TYPE adalah segala macam 
; tipe data yang valid dan dikenali dalam module.


; -- Deklarasi Pointer global --
; Jika sebuah Pointer dideklarasikan secara global namun tidak berisi nilai secara
; eksplisit, maka Pointer harus merujuk ke null.
@gptr_int   = global i32* null, align 8

; Ragam deklarasi Pointer dapat dilihat pada bagian selanjutnya.


define i32 @algorithm () {

    ; Variabel yang akan ditunjuk oleh Pointer
    %ivar       = alloca i32, align 4
    store       i32 135, i32* %ivar, align 4

    ; Array dengan elemen yang akan ditunjuk oleh Pointer
    %iarr       = alloca [5 x i32], align 16

; -- Deklarasi Pointer lokal --
    ; Pointer to Variable
    %iptr.addr  = alloca i32*, align 8

; -- Address Assignment --
    ; Pointer to Variable
    ;   iptr.addr   = &ivar
    store       i32* %ivar, i32** %iptr.addr, align 8

    ; Pointer to Array element at index
    ;   iptr.addr   = &iarr[2]
    %iarr.idx2  = getelementptr inbounds [5 x i32], [5 x i32]* %iarr, i64 0, i64 2
    store       i32* %iarr.idx2, i32** %iptr.addr, align 8



    ret i32 0
}