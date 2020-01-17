;   Memory
;
;   Operasi terhadap alamat memory atau nilai yang disimpan dalam memory.
;
; LLVM Bitcode:
;   $ llvm-as memory.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o memory.asm memory.ll
;
;-----------------------------------------------------------------------------

source_filename = "memory.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Memory Access
; Operasi pembacaan (read/load) atau penulisan (write/store) terhadap informasi
; yang disimpan di memory. Akses memory dapat dilakukan terhadap wilayah yang dibatasi
; sebagai stack, heap, memory mapped, maupun wilayah lain yang tidak dibatasi 
; secara khusus.
;
;
; Memory Allocation
; Operasi untuk memesan atau menyediakan ruang memory dengan ukuran tertentu untuk 
; digunakan menyimpan data. Alokasi memory dapat dilakukan sebelum akses dapat 
; dilakukan. Alokasi dapat dilakukan secara implisit dan eksplisit. 
; Alokasi implisit dilakukan dengan cara deklarasi variabel atau konstanta global.
; Alokasi eksplisit dilakukan dengan menggunakan instruksi khusus, umumnya dalam 
; mempersiapkan ruang di lokasi tertentu (stack dan heap).
;
; Dalam LLVM IR, alokasi eksplisit yang didukung adalam alokasi Stack. Sementara 
; alokasi lain (contoh: heap) dilakukan oleh API (libc) di luar kewenangan LLVM IR.

define i32 @algorithm () {

; Stack Allocation
; Alokasi ruang di stack frame fungsi jika fungsi tersebut aktif atau sedang dieksekusi.
; Ruang yang telah dialokasikan akan dilepas secara otomatis setelah scope berakhir.
; Penyebutan tipe data dilakukan untuk memberikan kepastian ukuran ruang yang dipesan.
;
; Apabila alokasi ruang disimpan ke dalam variabel, maka variabel tersebut bertipe
; pointer terhadap tipe data yang dialokasikan.

    ; alokasi stack dengan alignment.
    %v01.addr   = alloca i32, align 4

    ; alokasi stack dengan 10 elemen (tanpa alignment)
    %v02.addr   = alloca i32, i32 10

; Store (Write)
; Menyimpan nilai ke alamat memory tertentu
    ; simpan nilai 135 ke alamat memory yang ditunjuk pointer %v01.addr
    store i32 135, i32* %v01.addr

; Load (Read)
; Mengambil nilai yang tersimpan pada alamat memory tertentu.
    ; baca nilai yang tersimpan di alamat memory yang ditunjuk pointer %v01.addr
    %v11.val    = load i32, i32* %v01.addr

; Fence 
    ; 
    ; fence 

    ;
    ; cmpxchg 

    ;
    ; atomicrmw

    ;
    ; getelementptr
    

    ret i32 0
}