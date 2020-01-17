;   Float
;   LLVM IR Data Type
;
; LLVM Bitcode:
;   $ llvm-as float.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o float.asm float.ll
;
;-----------------------------------------------------------------------------

source_filename = "float.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; LLVM IR menggunakan prinsip Strong Type yang ketat. Setiap data yang terlibat
; dalam operasi, setiap nilai yang dihasilkan, harus menyertakan tipe data 
; secara eksplisit.

; Pemberlakuan Strong Type memberikan kemudahan dalam menghasilkan kode yang
; sesuai dengan arsitektur target.


; Floating-Point Number
; Floating Point atau bilangan pecahan adalah bilangan yang memiliki komponen
; pecahan atau nilai di belakang koma. Definisi bilangan Floating Point untuk
; sistem komputer didefinisikan melalui beberapa ketentuan seperti IEEE 7544.
;
; Dalam sistem komputer atau mesin digital, bilangan pecahan direpresentasikan
; dalam rentang yang terbatas. Umumnya, terdapat N kemungkinan nilai untuk
; floating point:
;   - bilangan positif: F > 0.0
;   - bilangan negatif: F < 0.0
;   - nol: 0.0
;   - inifinity positif: ∞
;   - infinity negatif: -∞
;   - NaN (Not a Number)


; Type Signature
; Sebuah floating-point number dideklarasikan dengan tipe yang sesuai.
;
; Beberapa tipe yang umum: half, float, double.
; Selain ketiga tipe tersebut, terdapat beberapa tipe yang cukup machine-dependent:
; fp128, x86_fp80, ppc_fp128

; Deklarasi global variabel bertipe floating-point number
@global.half    = global half   16.0
@global.float   = global float  32.0
@global.double  = global double 64.0

; Deklarasi constant bertipe floating-point number
@const.half     = constant half   16.0
@const.float    = constant float  32.0
@const.double   = constant double 64.0


; Deklarasi variabel lokal bertipe integer (di dalam fungsi)
define i32 @algorithm () {

; Half      - 16-bit floating point value
    ; alokasi stack
    %1      = alloca half
    %2      = alloca half 

    ; simpan nilai ke stack
    store half 1.0, half* %1
    store half 2.0, half* %2

    ; load nilai dari stack
    %val1   = load half, half* %1
    %val2   = load half, half* %2

; Float     - 32-bit floating point value
    ; alokasi stack
    %3      = alloca float, align 4
    %4      = alloca float, align 4

    ; simpan nilai ke stack
    store float 3.0, float* %3, align 4
    store float 4.0, float* %4, align 4

    ; load nilai dari stack
    %val3   = load float, float* %3, align 4
    %val4   = load float, float* %4, align 4

; Double    - 64-bit floating point value
    ; alokasi stack
    %5      = alloca double, align 8
    %6      = alloca double, align 8 

    ; simpan nilai ke stack
    store double 5.0, double* %5
    store double 6.0, double* %6

    ; load nilai dari stack
    %val5   = load double, double* %5, align 8
    %val6   = load double, double* %6, align 8


; Karena sifat strong-type, setiap operasi pada LLVM IR harus menegaskan tipe
; data dan semua operan yang terlibat memiliki tipe yang sama.


; Arithmetic
; FADD (penjumlahan)
    ; Tambahkan nilai dari kedua operan.
    ; Nilai yang dihasilkan akan disimpan ke variabel baru.
    %add8   = fadd half   %val1, %val2    ; var = fadd var, var
    %add16  = fadd float  %val3, 11.0     ; var = fadd var, imm
    %add32  = fadd double 12.0, %val6     ; var = fadd imm, var

; FSUB (pengurangan) 
    ; Kurangkan nilai kedua dari nilai pertama.
    ; Nilai yang dihasilkan akan disimpan ke variabel baru.
    %sub8   = fsub half   %val2, %val1    ; var = fsub var, var
    %sub16  = fsub float  %val4, 13.0     ; var = fsub var, imm
    %sub32  = fsub double 14.0, %val5     ; var = fsub imm, var

; FMUL (perkalian)
    ; Kalikan nilai dari kedua operan.
    ; Nilai yang dihasilkan akan disimpan ke variabel baru.
    %mul8   = fmul half   %val2, %val1    ; var = fmul var, var
    %mul16  = fmul float  %val4, 15.0     ; var = fmul var, imm
    %mul32  = fmul double 16.0, %val6     ; var = fmul imm, var

; FDIV (pembagian)
    ; Bagi nilai dari operan pertama dengan nilai dari operan kedua.
    ; Nilai yang dihasilkan akan disimpan ke variabel baru
    %div8   = fdiv half   %val2, %val1    ; var = fdiv var, var
    %div16  = fdiv float  %val4, 17.0     ; var = fdiv var, imm
    %div32  = fdiv double 18.0, %val6     ; var = fdiv imm, var


    ret i32 0
}