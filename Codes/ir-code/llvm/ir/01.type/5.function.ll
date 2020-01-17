;   Function
;   LLVM IR Data Type
;
; LLVM Bitcode:
;   $ llvm-as function.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o function.asm function.ll
;
;-----------------------------------------------------------------------------

source_filename = "function.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; LLVM IR memiliki prinsip strong type. Setiap data yang terlibat dalam operasi
; harus memiliki tipe data yang eksplisit.

; Pemberlakuan Strong Type memberikan kemudahan dalam menghasilkan kode yang 
; sesuai dengan arsitektur target.


; Function
; LLVM IR mendefinisikan Function sebagai suatu tipe tersendiri dalam Type System.
; Function dapat dianggap sebagai sebuah function signature yang dapat
; mengidentifikasi sebuah fungsi dan membedakan dengan fungsi lainnya.
; Function terdiri atas dua komponen: Return Type dan List of Formal Parameter.

; Bentuk umum tipe data Function (Function Signature):
;
;   RET ( LIST_OF_PARAM )

declare i32 @ext_function(i32)


define i32 @algorithm () {

; Alokasi stack untuk menyimpan function pointer

; -- Function Pointer Declaration --
; Signature: i32 (i32) *
    ; Pointer ke Function dengan 1 argumen i32, mengembalikan i32
    %fptr1      = alloca i32 (i32) *, align 8

; Signature: float (i16, i32* *) *
    ; Pointer ke Function dengan 2 argumen (i16 dan pointer ke i32),
    ; mengembalikan float
    %fptr2      = alloca float (i16, i32* *) *

; i32 (i8*, ...) *
    ; Pointer ke Function vararg, argumen pertama adalah pointer ke i8,
    ; mengembalikan i32
    %fptr3      = alloca i32 (i8*, ...) *

; Signature: {i32, i32} (i32)
    ; Pointer ke Function dengan 1 argumen i32,
    ; mengembalikan struktur dengan dua i32
    %fptr4      = alloca i32 (i8*, ...) *


; -- Function Pointer Assignment --
; Assign alamat fungsi ke variabel
    ; Simpan alamat @ext_fungsi ke variabel yang ditunjuk %fptr1
    ; %fptr merupakan sebuah pointer yang mengarah ke type i32(i32)*
    store       i32 (i32)* @ext_function, i32 (i32)** %fptr1, align 8


; -- Function Pointer Call --
; Call fungsi yang ditunjuk oleh funtion pointer
    ; dapatkan alamat fungsi
    %function   = load i32 (i32) *, i32 (i32)** %fptr1, align 8

    ; panggil, ext_function(135)
    %retval     = call i32 %function (i32 135)


    ret i32 0
}