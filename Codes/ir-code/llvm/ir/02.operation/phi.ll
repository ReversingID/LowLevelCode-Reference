;   Phi
;
; LLVM Bitcode:
;   $ llvm-as phi.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o phi.asm phi.ll
;
;-----------------------------------------------------------------------------

source_filename = "phi.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Phi Operator
; Implementasi Phi Node pada prinsip SSA.
; Prinsip SSA (Static Single Assignment) mengharuskan bahwa sebuah assignment nilai
; terhadap sebuah variabel hanya dapat dilakukan sekali selama eksekusi program.
; Permasalahan terjadi ketika sebuah nilai harus diperbarui secara berkala, misal
; melalui loop. 
;
; Phi Node digunakan untuk memilih nilai berdasarkan dua atau lebih kondisi nilai.
; Jika sebuah Basic Block dapat dicapai dari dua atau lebih jalan, maka Phi Node
; tinggal memeriksa Basic Block asal dan mengisikan nilai yang sesuai ke variabel.
;
; Singkatnya, Phi Node disisipkan untuk menggabungkan dua nilai yang berbeda.

define i32 @phi (i32 %a, i32 %b) {
entry:
    ; percabangan, pindah ke btrue atau bfalse berdasarkan nilai kondisi
    %cond   = icmp slt i32 %a, %b
    br      i1 %cond, label %btrue, label %bfalse

btrue:
    ; jika kondisi bernilai true, %retval akan bernilai a
    br      label %finish

bfalse:
    ; jika kondisi bernilai false, %retval akan bernilai b
    br      label %finish 

    ; nilai kembalian %retval didapat dari %a atau %b.
    ; terdapat dua path berbeda untuk mengisi %retval, yaitu %btrue dan %bfalse.
    ; SSA tidak mengijinkan redefinisi dan reassignment sebuah variabel, sehingga 
    ; jika terdapat dua kemungkinan nilai dari dua path berbeda maka proses merge
    ; harus dilakukan.
finish:
    ; %retval akan berisi nilai dari %b jika block sebelumnya adalah %bfalse
    ; %retval akan berisi nilai dari %a jika block sebelumnya adalah %btrue
    %retval = phi i32 [ %b, %bfalse ], [ %a, %btrue ]

    ret i32 %retval
}