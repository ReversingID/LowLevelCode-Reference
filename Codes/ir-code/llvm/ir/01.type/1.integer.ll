;   Integer
;   LLVM IR Data Type
;
;   Bilangan bulat dan operasinya.
;
; LLVM Bitcode:
;   $ llvm-as integer.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o integer.asm integer.ll
;
;-----------------------------------------------------------------------------

source_filename = "integer.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; LLVM IR menggunakan prinsip Strong Type yang ketat. Setiap data yang terlibat
; dalam operasi, setiap nilai yang dihasilkan, harus menyertakan tipe data 
; secara eksplisit.

; Pemberlakuan Strong Type memberikan kemudahan dalam menghasilkan kode yang
; sesuai dengan arsitektur target.


; Integer
; Integer atau bilangan bulat adalah bilangan yang dapat diekspresikan tanpa
; adanya komponen pecahan.
; Bilangan bulat dapat memiliki 3 kemungkinan nilai:
;   - bilangan bulat positif: 1, 2, 3, ...
;   - bilangan bulat negatif: -1, -2, -3, ...
;   - nol: 0
;
; Secara matematis, bilangan bulat dapat mencapai nilai tak terhingga (positif/negatif).
; Namun dalam komputer dan mesin digital umumnya, bilangan bulat direpresentasikan
; dalam rentang yang terbatas. Batas nilai yang dapat ditampung bergantung kepada
; panjang data yang dapat dioperasikan oleh mesin tersebut (dalam bit). Antar
; mesin dapat memiliki kapasitas yang berbeda.
;
; LLVM IR mengabstraksikan integer dan memetakannya sesuai dengan kapasitas yang
; didukung tiap mesin.


; Type Signature
; Sebuah integer dideklarasikan dengan sintaks iN, dimana N adalah panjang bit integer.
;
; Beberapa integer yang umum: i1, i8, i16, i32, i64

; Deklarasi global variabel bertipe integer
@global.i1      = global i1  1
@global.i8      = global i8  8
@global.i16     = global i16 16
@global.i32     = global i32 32
@global.i64     = global i64 64

; Deklarasi constant bertipe integer
@const.i1      = constant i1  1
@const.i8      = constant i8  8
@const.i16     = constant i16 16
@const.i32     = constant i32 32
@const.i64     = constant i64 64


; Deklarasi variabel lokal bertipe integer (di dalam fungsi)
define i32 @algorithm () {

; i1    - Boolean
    ; alokasi stack dengan i1
    %1      = alloca i1
    %2      = alloca i1

; i8    - Character
    ; alokasi stack dengan i8
    %3      = alloca i8, align 1
    %4      = alloca i8, align 1 

    ; simpan nilai ke stack
    store i8 3, i8* %3, align 1
    store i8 4, i8* %4, align 1

    ; load nilai dari stack
    %val3   = load i8, i8* %3, align 1
    %val4   = load i8, i8* %4, align 1

; i16   - Wide character & 16-bit integer
    ; alokasi stack dengan i16
    %5      = alloca i16, align 2
    %6      = alloca i16, align 2

    ; simpan nilai ke stack
    store i16 5, i16* %5, align 2
    store i16 6, i16* %6, align 2

    ; load nilai dari stack
    %val5   = load i16, i16* %5, align 2
    %val6   = load i16, i16* %6, align 2

; i32
    ; alokasi stack dengan i32
    %7      = alloca i32, align 4 
    %8      = alloca i32, align 4

    ; simpan nilai ke stack
    store i32 7, i32* %7, align 4
    store i32 8, i32* %8, align 4

    ; load nilai dari stack
    %val7   = load i32, i32* %7, align 4
    %val8   = load i32, i32* %8, align 4

; i64
    ; alokasi stack dengan i64
    %9      = alloca i64, align 8
    %10     = alloca i64, align 8

    ; simpan nilai ke stack
    store i64  9, i64*  %9, align 8
    store i64 10, i64* %10, align 8

    ; load nilai dari stack
    %val9   = load i64, i64*  %9, align 8
    %val10  = load i64, i64* %10, align 8


; Signness
; LLVM IR tidak membedakan operasi antara signed integer dan unsigned integer.
; LLVM IR mengabstraksi kedua operasi tersebut menjadi satu pandangan yang sama.

; Karena sifat strong-type, setiap operasi pada LLVM IR harus menegaskan tipe
; data dan semua operan yang terlibat memiliki tipe yang sama.


; -- Arithmetic --
; ADD (penjumlahan)
    ; Tambahkan nilai dari kedua operan.
    ; Nilai yang dihasilkan akan disimpan ke variabel baru.
    %add8   = add i8  %val3, %val4    ; var = add var, var
    %add16  = add i16 %val5, 11       ; var = add var, imm
    %add32  = add i32 12, %val8       ; var = add imm, var
    %add64  = add i64 %val9, %val10

; SUB (pengurangan) 
    ; Kurangkan nilai kedua dari nilai pertama.
    ; Nilai yang dihasilkan akan disimpan ke variabel baru.
    %sub8   = sub i8  %val4, %val3    ; var = sub var, var
    %sub16  = sub i16 %val6, 13       ; var = sub var, imm
    %sub32  = sub i32 14, %val7       ; var = sub imm, var
    %sub64  = sub i64 %val9, %val10

; MUL (perkalian)
    ; Kalikan nilai dari kedua operan.
    ; Nilai yang dihasilkan akan disimpan ke variabel baru.
    %mul8   = mul i8  %val4, %val3    ; var = mul var, var
    %mul16  = mul i16 %val6, 15       ; var = mul var, imm
    %mul32  = mul i32 16, %val8       ; var = mul imm, var
    %mul64  = mul i64 %val9, %val10

; UDIV (pembagian unsigned)
    ; Bagi nilai dari operan pertama dengan nilai dari operan kedua.
    ; Nilai yang dihasilkan akan disimpan ke variabel baru
    ; pembagian terhadap bilangan unsigned integer.
    %udiv8  = udiv i8  %val4, %val3    ; var = udiv var, var
    %udiv16 = udiv i16 %val6, 17       ; var = udiv var, imm
    %udiv32 = udiv i32 18, %val8       ; var = udiv imm, var
    %udiv64 = udiv i64 %val9, %val10

; SDIV (pembagian ssigned)
    ; Bagi nilai dari operan pertama dengan nilai dari operan kedua.
    ; Nilai yang dihasilkan akan disimpan ke variabel baru
    ; pembagian terhadap bilangan signed integer.
    %sdiv8  = sdiv i8  %val4, %val3    ; var = sdiv var, var
    %sdiv16 = sdiv i16 %val6, 19       ; var = sdiv var, imm
    %sdiv32 = sdiv i32 20, %val8       ; var = sdiv imm, var
    %sdiv64 = sdiv i64 %val9, %val10

; UREM (sisa bagi)
    ; Bagi nilai dari operan pertama dengan nilai dari operan kedua.
    ; Sisa bagi akan disimpan ke variabel baru
    ; pembagian terhadap bilangan unsigned integer.
    %urem8  = urem i8  %val4, %val3    ; var = urem var, var
    %urem16 = urem i16 %val6, 21       ; var = urem var, imm
    %urem32 = urem i32 22, %val8       ; var = urem imm, var
    %urem64 = urem i64 %val9, %val10

; SREM (sisa bagi)
    ; Bagi nilai dari operan pertama dengan nilai dari operan kedua.
    ; Sisa bagi akan disimpan ke variabel baru
    ; pembagian terhadap bilangan signed integer.
    %srem8  = srem i8  %val4, %val3    ; var = srem var, var
    %srem16 = srem i16 %val6, 23       ; var = srem var, imm
    %srem32 = srem i32 24, %val8       ; var = srem imm, var
    %srem64 = srem i64 %val9, %val10


    ret i32 0
}