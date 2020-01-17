;   Parameter
;
;   Tipe parameter sebuah fungsi
;
; LLVM Bitcode:
;   $ llvm-as param.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o param.asm param.ll
;
;-----------------------------------------------------------------------------

source_filename = "param.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Parameter
; Parameter adalah variabel khusus yang digunakan dalam fungsi, merujuk kepada
; nilai yang diberikan sebagai input untuk fungsi tersebut.
;
; Tidak ada batasan dalam jumlah parameter yang dapat dimiliki oleh sebuah fungsi,
; selama setiap parameter dideklarasikan dengan jelas dan bertipe valid.


; typedef
%struct.struct_t    = type { [10 x i32], i32 }

; dummy functions
define void @dummy_void () {
    ret void
}

define i32 @dummy_int32 () {
    ret i32 0
}

; -- Deklarasi & Definisi Fungsi --
; Parameter pada LLVM IR dapat beragam, sesuai dengan tipe data yang didukung.
; Setidaknya sebuah parameter dapat bertipe:
;   - primitive (integer, float)
;   - structure
;   - array
;   - pointer
;   - function

; Fungsi tanpa argumen
define i32 @fnc_none () {
    ret i32 0
}

; Fungsi dengan argumen integer (bisa juga float, string, dsb)
define i32 @fnc_params (i32 %arg) {
    ret i32 0
}

; Fungsi dengan argumen Array
define i32 @fnc_array ([10 x i32] %arg) {
    ret i32 0
}

; Fungsi dengan parameter structure
define i32 @fnc_struct (%struct.struct_t * byval(%struct.struct_t) align 8 %arg) {
    ; 
    ret i32 0
}

; Fungsi dengan parameter pointer
define i32 @fnc_ptr (i32* %arg) {
    ; %arg adalah pointer ke i32
    ret i32 0
}

; Fungsi dengan parameter function
define i32 @fnc_func (i32 ()* %arg) {
    ; %arg adalah pointer ke fungsi, 
    ;   - tidak menerima parameter
    ;   - mengembalikan nilai i32
    ret i32 0
}


; -- Akses Parameter --
; Sebuah parameter adalah sebuah simbol, sebuah variabel biasa.
; Akses terhadap parameter di dalam badan fungsi dilakukan berdasarkan nama saat
; definisi fungsi. Apabila nama parameter ditiadakan, maka secara otomatis
; parameter akan diidentifikasi sebagai variabel dengan format %X dimana X adalah
; angka.
;
; LLVM IR memiliki sistem penamaan secara otomatis untuk setiap variabel lokal
; atau label yang tidak dinamai secara eksplisit. Penamaan secara implisit diberikan
; dengan sebuah angka yang terurut menaik dimulai dari 0.
;
; Tidak ada larangan untuk menamakan sebuah variabel secara eksplisit dengan angka.

; Definisikan sebuah fungsi yang menerima 2 parameter.
; Parameter pertama diidentifikasi sebagai %arg, parameter kedua tidak memiliki nama
define i32 @fnc_name (i32 %arg, i32) {

    %ivar1  = alloca i32, align 4
    %ivar2  = alloca i32, align 4

    ; akses terhadap parameter pertama, berdasarkan nama yang diberikan
    store i32 %arg, i32* %ivar1, align 4

    ; akses terhadap parameter kedua, berdasarkan angka
    store i32 %0, i32* %ivar2, align 4


    ret i32 0
}



define i32 @algorithm () {
    %ivar   = alloca i32, align 4
    %arr    = alloca [10 x i32]
    %stvar  = alloca %struct.struct_t, align 8

; -- Function Call --

; pemanggilan fungsi tanpa argumen
    call        i32 @fnc_none ()

; pemanggilan fungsi dengan argumen integer (bisa juga float, string, dsb)
    ; nilai konstan
    call        i32 @fnc_params (i32 0)

    ; pass sebuah variabel
    %ivar.val   = load i32, i32 * %ivar
    call        i32 @fnc_params (i32 %ivar.val)

; pemanggilan fungsi dengan argumen Array
    %arr.val    = load [10 x i32], [10 x i32]* %arr
    call        i32 @fnc_array ([10 x i32] %arr.val)

; pemanggilan fungsi dengan argumen Struct
    call        i32 @fnc_struct (%struct.struct_t* byval(%struct.struct_t) %stvar)

; pemanggilan fungsi dengan argumen pointer
    call        i32 @fnc_ptr (i32* %ivar)

; pemanggilan fungsi dengan argumen function
    ; fungsi dengan signature sesuai
    call        i32 @fnc_func (i32 ()* @dummy_int32)

    ; fungsi dengan signature berbeda
    call        i32 @fnc_func (i32 ()* bitcast (void ()* @dummy_void to i32 ()*))


    ret i32 0
}