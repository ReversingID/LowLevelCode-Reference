;   Return Value
;
;   Beragam kemungkinan nilai kembalian sebuah fungsi
;
; LLVM Bitcode:
;   $ llvm-as retval.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o retval.asm retval.ll
;
;-----------------------------------------------------------------------------

source_filename = "retval.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Return Value
; Return Value (nilai kembalian) adalah sebuah nilai yang dihasilkan oleh fungsi
; setelah menyelesaikan eksekusi.


; typedef
%struct.struct_t    = type { [10 x i32], i32 }

; dummy functions
define i32 @dummy () {
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

; Fungsi tidak menghasilkan nilai apapun
define void @fnc_none () {
    ret void
}


; Fungsi menghasilkan nilai integer (bisa juga float, string, dsb)
define i32 @fnc_int32 () {
    ret i32 0
}


; Fungsi menghasilkan nilai Array
define [10 x i32] @fnc_array () {
    ; mengembalikan objek yang dibentuk di lokal (hanya contoh)
    %arr.addr   = alloca [10 x i32]

    %retval     = load [10 x i32], [10 x i32]* %arr.addr
    ret [10 x i32] %retval
}


; Fungsi menghasilkan nilai structure
; Bentuk [1] dimana nilai kembalian diletakkan sebagai kembalian.
; Bentuk tidak umum dan optimisasi kemungkinan besar akan mengubah bentuk ini 
; jadi bentuk [2]
define %struct.struct_t @fnc_struct1 () {
    ; mengembalikan objek yang dibentuk di lokal (hanya contoh)
    %st.addr    = alloca %struct.struct_t, align 4

    %retval     = load %struct.struct_t, %struct.struct_t* %st.addr 
    ret %struct.struct_t %retval
}

; Bentuk [2] dimana nilai kembalian diletakkan sebagai parameter pertama
; Bentuk umum yang dihasilkan oleh Front-End.
define void @fnc_struct2 (%struct.struct_t* noalias sret %retval) {
    ; parameter %retval merupakan nilai kembalian.

    ; secara semantik, fungsi tidak mengembalikan nilai
    ret void
}


; Fungsi menghasilkan nilai pointer
define i32* @fnc_ptr () {
    ; mengembalikan pointer yang dibentuk di lokal (hanya contoh)
    %i32.addr   = alloca i32, align 4

    ret i32* %i32.addr
}


; Fungsi menghasilkan nilai function
define i32 ()* @fnc_func () {
    ret i32 ()* @dummy
}


define i32 @algorithm () {
    %stvar  = alloca %struct.struct_t, align 8

; -- Function Call --

; pemanggilan fungsi tanpa nilai kembalian
    call        void @fnc_none ()

; pemanggilan fungsi dengan nilai kembalian integer (bisa juga float, string, dsb)
    %i32.retval = call i32 @fnc_int32 ()

; pemanggilan fungsi dengan nilai kembalian Array
    %arr.retval = call [10 x i32] @fnc_array ()

; pemanggilan fungsi dengan nilai kembalian Struct
    ; nilai kembalian bentuk [1]
    %st.retval1 = call %struct.struct_t @fnc_struct1 ()

    ; nilai kembalian bentuk [2]
    call        void @fnc_struct2 (%struct.struct_t* sret %stvar)

; pemanggilan fungsi dengan nilai kembalian pointer
    %ptr.retval = call i32* @fnc_ptr ()

; pemanggilan fungsi dengan nilai kembalian function
    %fnc.retval = call i32()* @fnc_func ()


    ret i32 0
}