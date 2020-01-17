;   String
;   LLVM IR Data Type
;
; LLVM Bitcode:
;   $ llvm-as string.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o string.asm string.ll
;
;-----------------------------------------------------------------------------

source_filename = "string.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; LLVM IR menggunakan prinsip Strong Type yang ketat. Setiap data yang terlibat
; dalam operasi, setiap nilai yang dihasilkan, harus menyertakan tipe data 
; secara eksplisit.

; Pemberlakuan Strong Type memberikan kemudahan dalam menghasilkan kode yang 
; sesuai dengan arsitektur target.


; String
; String adalah Array karakter, umumnya berupa karakter cetak (printable character).
; Terdapat banyak style dan jenis string dilihat dari elemen, terminasi string, dsb.
; Elemen dalam string dapat berupa byte atau multibyte seperti unicode.

; LLVM tidak mendefinisikan tipe khusus untuk mengakomodir string jenis tertentu.
; Namun pemetaan string ke dalam Array karakter dapat dilakukan dengan mudah.


; Deklarasi
; Deklarasi string tak berbeda dengan deklarasi sebuah Array, namun umumnya
; diikuti dengan inisialisasi.


; -- Deklarasi String global --
; C-Style string
; null-terminated, string diakhiri dengan NULL (byte 00)
@str_c      = private unnamed_addr constant [13 x i8] c"Reversing.ID\00", align 1

; Pascal-Style string (short)
; string diawali dengan sebuah byte yang menyatakan panjang string. Maksimum 255 karakter
@str_pshort = private unnamed_addr constant [13 x i8] c"\0cReversing.ID", align 1

; Wide-Char string (4 byte)
; elemen string merupakan multibyte, 4 byte, dan diakhiri dengan NULL
@str_wide   = private unnamed_addr constant [13 x i32] [i32 82, i32 101, i32 118, i32 101, i32 114, i32 115, i32 105, i32 110, i32 103, i32 46, i32 73, i32 68, i32 0], align 16

; operasi terhadap string akan bergantung dengan jenis string.

define i32 @algorithm () {

    ret i32 0
}