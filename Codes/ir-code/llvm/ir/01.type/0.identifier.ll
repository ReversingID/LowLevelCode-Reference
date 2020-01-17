;   Variable Scope
;
;   Deklarasi variabel dalam scope berbeda
;
; LLVM Bitcode:
;   $ llvm-as identifier.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o identifier.asm identifier.ll
;
;-----------------------------------------------------------------------------

source_filename = "identifier.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Variable & Constant
; Variabel dan konstanta adalah unit yang menyimpan nilai saat program berjalan.
; Sebuah variabel atau konstanta dapat dideklarasikan di dua scope, 
; yaitu: Global dan Local.
;
; Meski secara konsep variabel dan konstanta memiliki peran sama untuk menampung
; nilai, namun konstanta merupakan penampung nilai yang bersifat tetap, tidak
; diperbolehkan terjadi perubahan apapun terhadap nilai.

; Dalam impelemntasinya, sebuah variabel dapat direpresentasikan sebagai suatu
; ruang memory atau register. Penentuan variabel apa yang akan menempati ruang
; memory mana adalah kewenangan dari code-generator dan linker. Kecuali jika
; secara eksplisit disebutkan alamat yang akan ditempati oleh variabel atau
; konstanta tersebut.

; Variabel dan Konstanta yang menjadi simbol global dapat dikenali dari scope
; manapun di dalam module. Simbol ini dikenali dengan nama dan diawali dengan
; tanda @.
;
; Variabel dan konstanta yang menjadi simbol lokal dapat dikenali dari scope
; lokal tersebut saja (misal, function). Simbol ini dikenali dengan nama dan
; diawali dengan tanda %.

; LLVM memandang sebuah simbol global (terutama variabel) sebagai pointer,
; sehingga dereference harus dilakukan secara eksplisit untuk mengakses nilai.
; 
; Variabel lokal pada LLVM IR memiliki dua tipe kategori:
;   - Register allocated local variable
;   - Stack allocated local variable.


; -- Variabel dan Konstanta Global --
; Variable
; deklarasi variabel dengan pengaturan normal 
@g_var1     = global i32 1

; deklarasi variabel dengan alignment 4 byte 
@g_var2     = global i32 2, align 4

; deklarasi variabel pada section yang ditentukan
@g_var3     = global i32 3, section "custom"

; deklarasi variabel yang berada di luar (external) module
@g_var4     = external global i32

; deklarasi Thread-Local global dengan model initialexec TLS
@g_var5     = thread_local(initialexec) global i32 5, align 4

; deklarasi variabel yang terletak di alamat memory tertentu
@g_var6     = addrspace(1000) global i32 6


; Constant
; deklarasi konstanta dengan pengaturan normal
@g_const1   = constant i32 1

; deklarasi konstanta pada section yang ditentukan
@g_const2   = constant i32 2, section "floo", align 4

; deklarasi konstanta pada alamat memory tertentu
@g_const3   = addrspace(1004) constant i32 3

; Selain alokasi memory, variabel di LLVM IR juga dapat digunakan untuk menampung
; nilai sementara. Umumnya nilai ini digunakan untuk melakukan assignment terhadap
; variabel lokal.


define i32 @algorithm () {

; Register-Allocated Local Variable
; Variabel temporer yang dialokasikan sebagai Virtual Register. Virtual Register
; akan diterjemahkan menjadi register fisik saat fase code-generation.

    %l_reg      = mul i32 9, 15

; Stack-Allocated Local Variable
; Variable yang dialokasikan di bagian memory bernama stack. Variabel akan hidup di
; scope sebuah fungsi. Instruksi alloca akan mengembalikan sebuah pointer yang 
; mengarah ke lokasi variabel di Stack.

    %l_stack    = alloca i32, align 4

    ret i32 0
}

; LLVM IR menggunakan prinsip Strong Type yang ketat. Setiap data yang terlibat dalam
; operasi, setiap nilai yang dihasilkan, harus menyertakan tipe data secara eksplisit.

; LLVM memiliki beberapa tipe data:
;   - Function      (lihat function.ll)
;   - Single Value
;       - Integer   (lihat integer.ll)
;       - Float     (lihat float.ll)
;       - Pointer   (lihat pointer.ll)
;       - Vector    (lihat vector.ll)
;   - Aggregate
;       - Array     (lihat array.ll)
;       - Structure (lihat structure.ll)