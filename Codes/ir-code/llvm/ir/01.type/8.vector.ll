;   Vector
;   LLVM IR Data Type
;
; LLVM Bitcode:
;   $ llvm-as vector.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o vector.asm vector.ll
;
;-----------------------------------------------------------------------------

source_filename = "vector.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; LLVM IR menggunakan prinsip Strong Type yang ketat. Setiap data yang terlibat
; dalam operasi, setiap nilai yang dihasilkan, harus menyertakan tipe data 
; secara eksplisit.

; Pemberlakuan Strong Type memberikan kemudahan dalam menghasilkan kode yang 
; sesuai dengan arsitektur target.


; Vector
; Vector memiliki kesamaan dengan Array, dimana Vector merupakan himpunan objek
; atau elemen dengan tipe seragam. Namun, Vector secara khusus merupakan tipe
; yang merepresentasikan vector of elements.
;
; Operasi vector merupakan operasi SIMD (Single Instruction Multiple Data) yang
; diberlakukan kepada data elemen primitif.


; Deklarasi
; Vector memerlukan jumlah elemen, tipe data primitif, dan skala untuk
; merepresentasikan vector, menyesuaikan dengan panjang vector di hardware.


define i32 @algorithm () {

; -- Deklarasi Vector lokal --
    ; Vector dengan 4 elemen i32
    %ivec   = alloca <4 x i32>
    %ivec2  = alloca <4 x i32>

    ; Vector dengan 8 elemen float
    %vfloat = alloca <8 x float>

    ; Vector dengan 2 elemen i64
    %vlong  = alloca <2 x i64>


; -- Akses Elemen Vector --

; Extract & Insert
; Elemen scalar dapat diekstrak maupun disisipkan secara individu ke/dari vector.
    ; load objek terlebih dahulu
    %ivec.tmp   = load <4 x i32>, <4 x i32>* %ivec
    %ivec2.tmp  = load <4 x i32>, <4 x i32>* %ivec2

; Extract
; Dapatkan elemen Vector pada indeks tertentu secara individual

    ; Dapatkan elemen di indeks ke-2 dari vector %ivec
    %ext.addr   = extractelement <4 x i32> %ivec.tmp, i32 2

; Insert
; Ubah nilai elemen Vector pada indeks tertentu secara individual
    ; Letakkan elemen di indeks ke-3 dari vector %ivec
    insertelement <4 x i32> %ivec.tmp, i32 3, i32 135

; Shuffle
; Lakukan permutasi terhadap elemen Vector, berdasarkan posisi yang diberikan.
    %shuffle.val= shufflevector <4 x i32> %ivec.tmp, <4 x i32> %ivec2.tmp, <4 x i32> <i32 0, i32 4, i32 1, i32 5>


    ret i32 0
}