;   Function Call
;
;   Pemanggilan fungsi secara langsung dan tak langsung
;
; LLVM Bitcode:
;   $ llvm-as call.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o call.asm call.ll
;
;-----------------------------------------------------------------------------

source_filename = "call.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Function Call
; Pemanggilan fungsi merupakan sebuah aksi untuk memindahkan alur eksekusi sehingga
; instruksi di dalam fungsi dapat dieksekusi.
; Terdapat dua jenis pemanggilan, yaitu pemanggilan langsung dan tak langsung.
;
; Pemanggilan secara langsung (direct call) terhadap fungsi adalah pemanggilan tanpa
; melalui pointer. Nama fungsi yang akan dipanggil disebut dengan menyertakan argumen
; yang diperlukan, lengkap dengan tipe data yang diperlukan.
;
; Pemanggilan secara tak langsung (indirect call) terhadap fungsi adalah pemanggilan
; melalui media pointer. Sebuah pointer akan menyimpan alamat sebuah fungsi. Pointer
; tersebut kemudian disebut dengna menyertakan argumen yang diperlukan, lengkap dengan
; tipe data yang diperlukan.


define i32 @function (i32) {
    ret i32 0
}


define i32 @algorithm () {

    %fncvar     = alloca i32 (i32)*, align 8
    store       i32 (i32)* @function, i32 (i32)** %fncvar, align 8

; direct call (pemanggilan langsung)
    ;           return-value        daftar argumen
    call        i32     @function   (i32 0)
    ;                   nama fungsi

; indirect call (pemanggilan tak langsung)
    ; menyimpan alamat fungsi yang akan dipanggil ke sebuah pointer.
    %fncptr     = load i32 (i32)*, i32 (i32)** %fncvar, align 8

    ;           return-value        daftar argumen
    call        i32     %fncptr     (i32 0)
    ;                   variabel memuat fungsi

    ret i32 0
}