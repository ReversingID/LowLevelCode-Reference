;   Comparison
;
; LLVM Bitcode:
;   $ llvm-as comparison.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o comparison.asm comparison.ll
;
;-----------------------------------------------------------------------------

source_filename = "comparison.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Control-Flow
; Ketika suatu program berjalan, eksekusi instruksi dilakukan secara berurutan 
; dari awal hingga akhir. Namun dalam beberapa kondisi tertentu, terdapat
; kebutuhan untuk mengeksekusi instruksi di lokasi lain sebagai bentuk
; penanganan kasus. Beberapa kelompok operasi yang berperan dalam pengendalian
; alur program antara lain jump / branch dan comparison. 


; Comparison (Perbandingan)
; Comparison (perbandingan) adalah sekelompok instruksi untuk membandingkan dua 
; nilai dan memberikan informasi terkait kondisi sama (equal) atau tidak sama (inequal).
; Perbandingan membutuhkan dua nilai: LHS (Left-Hand Side) dan RHS (Right-hand Side).
;
; Hanya terdapat dua instruksi perbandingan: icmp dan fcmp
;
; Perbandingan akan menghasilkan kondisi benar atau salah, terhadap operasi
; perbandingan yang diperiksa.
;
; Perbandingan hanya dapat dilakukan terhadap nilai primitif. Apabila nilai yang
; dibandingkan merupakan nilai agregat, maka perbandingan untuk setiap komponen
; secara individual harus didefinisikan.


; -- Integer Comparison --
; instruksi icmp mengembalikan nilai boolean (i1) atau vector nilai boolean berdasarkan 
; perbandingan dua integer, integer vector, pointer, atau pointer vector.
; 
; Operasi icmp memerlukan predikat yang berperan sebagai penentu operasi. 
; Predikat yang valid untuk icmp adalah: eq, ne, ugt, uge, ult, ule, sgt, sge, slt, sle

define i32 @icmp_compare () {

    %1      = alloca i32, align 4 
    %2      = alloca i32, align 4

    store i32 4, i32* %1, align 4
    store i32 5, i32* %2, align 4

    %ival1  = load i32, i32* %1, align 4
    %ival2  = load i32, i32* %2, align 4

    ; eq (Equal)
    ; menghasilkan True jika kedua operan bernilai sama. False, jika sebaliknya.
    %v01    = icmp eq i32 %ival1, %ival2    ; var = (var == var)
    %v02    = icmp eq i32 %ival1, 0         ; var = (var == imm)
    %v03    = icmp eq i32 0, %ival2         ; var = (imm == var)
    %v04    = icmp eq i32 1, 2              ; var = (imm == imm)    -> false
    %v05    = icmp eq i32* %1, %2           ; var = (ptr == ptr)    -> false
                                            ; kedua pointer tidak menunjuk alamat sama

    ; ne (Not Equal)
    ; menghasilkan True jika kedua operan bernilai tak sama. False, jika sebaliknya.
    %v11    = icmp ne i32 %ival1, %ival2    ; var = (var != var)
    %v12    = icmp ne i32 %ival1, 0         ; var = (var != imm)
    %v13    = icmp ne i32 0, %ival2         ; var = (imm != var)
    %v14    = icmp ne i32 3, 4              ; var = (imm != imm)    -> true
    %v15    = icmp ne i32* %1, %2           ; var = (ptr != ptr)    -> true
                                            ; kedua pointer tidak menunjuk alamat sama


; Unsigned operation
    ; ugt (Unsigned Greater Than)
    ; menghasilkan True jika operan pertama bernilai lebih besar dibandingkan operan kedua.
    ; False, jika sebaliknya.
    ; Kedua operan dianggap merupakan bilangan unsigned.
    %v21    = icmp ugt i32 %ival1, %ival2   ; var = (var > var)
    %v22    = icmp ugt i32 %ival1, 0        ; var = (var > imm)
    %v23    = icmp ugt i32 0, %ival2        ; var = (imm > var)
    %v24    = icmp ugt i32 5, 6             ; var = (imm > imm)     -> false
    %v25    = icmp ugt i32* %1, %2          ; var = (ptr > ptr)

    ; uge (Unsigned Greater or Equal)
    ; menghasilkan True jika operan pertama bernilai lebih besar atau sama dengan operan kedua.
    ; False, jika sebaliknya.
    ; Kedua operan dianggap merupakan bilangan unsigned.
    %v31    = icmp uge i32 %ival1, %ival2   ; var = (var >= var)
    %v32    = icmp uge i32 %ival1, 0        ; var = (var >= imm)
    %v33    = icmp uge i32 0, %ival2        ; var = (imm >= var)
    %v34    = icmp uge i32 7, 8             ; var = (imm >= imm)    -> false
    %v35    = icmp uge i32* %1, %2          ; var = (ptr <= ptr)

    ; ult (Unsigned Lower Than)
    ; menghasilkan True jika operan pertama bernilai lebih kecil dibandingkan operan kedua.
    ; False, jika sebaliknya.
    ; Kedua operan dianggap merupakan bilangan unsigned.
    %v41    = icmp ult i32 %ival1, %ival2   ; var = (var < var)
    %v42    = icmp ult i32 %ival1, 0        ; var = (var < imm)
    %v43    = icmp ult i32 0, %ival2        ; var = (imm < var)
    %v44    = icmp ult i32 9, 10            ; var = (imm < imm)     -> true
    %v45    = icmp ult i32* %1, %2          ; var = (ptr < ptr)

    ; ule (Unsigned Lower or Equal)
    ; menghasilkan True jika operan pertama bernilai lebih kecil ata sama dengan operan kedua.
    ; False, jika sebaliknya.
    ; Kedua operan dianggap merupakan bilangan unsigned.
    %v51    = icmp ule i32 %ival1, %ival2   ; var = (var <= var)
    %v52    = icmp ule i32 %ival1, 0        ; var = (var <= imm)
    %v53    = icmp ule i32 0, %ival2        ; var = (imm <= var)
    %v54    = icmp ule i32 11, 12           ; var = (imm <= imm)    -> true
    %v55    = icmp ule i32* %1, %2          ; var = (ptr <= ptr)


; signed operation
    ; sgt (Signed Greater Than)
    ; menghasilkan True jika operan pertama bernilai lebih besar dibandingkan operan kedua.
    ; False, jika sebaliknya.
    ; Kedua operan dianggap merupakan bilangan signed.
    %v61    = icmp sgt i32 %ival1, %ival2   ; var = (var > var)
    %v62    = icmp sgt i32 %ival1, 0        ; var = (var > imm)
    %v63    = icmp sgt i32 0, %ival2        ; var = (imm > var)
    %v64    = icmp sgt i32 -5, 6            ; var = (imm > imm)     -> false
    %v65    = icmp sgt i32* %1, %2          ; var = (ptr > ptr)

    ; sge (Signed Greater or Equal)
    ; menghasilkan True jika operan pertama bernilai lebih besar atau sama dengan operan kedua.
    ; False, jika sebaliknya.
    ; Kedua operan dianggap merupakan bilangan signed.
    %v71    = icmp sge i32 %ival1, %ival2   ; var = (var >= var)
    %v72    = icmp sge i32 %ival1, 0        ; var = (var >= imm)
    %v73    = icmp sge i32 0, %ival2        ; var = (imm >= var)
    %v74    = icmp sge i32 7, -8            ; var = (imm >= imm)    -> true
    %v75    = icmp sge i32* %1, %2          ; var = (ptr <= ptr)

    ; slt (Signed Lower Than)
    ; menghasilkan True jika operan pertama bernilai lebih kecil dibandingkan operan kedua.
    ; False, jika sebaliknya.
    ; Kedua operan dianggap merupakan bilangan signed.
    %v81    = icmp slt i32 %ival1, %ival2   ; var = (var < var)
    %v82    = icmp slt i32 %ival1, 0        ; var = (var < imm)
    %v83    = icmp slt i32 0, %ival2        ; var = (imm < var)
    %v84    = icmp slt i32 9, -10           ; var = (imm < imm)     -> false
    %v85    = icmp slt i32* %1, %2          ; var = (ptr < ptr)

    ; sle (Signed Lower or Equal)
    ; menghasilkan True jika operan pertama bernilai lebih kecil atau sama dengan operan kedua.
    ; False, jika sebaliknya.
    ; Kedua operan dianggap merupakan bilangan signed.
    %v91    = icmp sle i32 %ival1, %ival2   ; var = (var <= var)
    %v92    = icmp sle i32 %ival1, 0        ; var = (var <= imm)
    %v93    = icmp sle i32 0, %ival2        ; var = (imm <= var)
    %v94    = icmp sle i32 11, -12          ; var = (imm <= imm)    -> false
    %v95    = icmp sle i32* %1, %2          ; var = (ptr <= ptr)

    ret i32 0
}


; -- Floating-Point Comparison --
; instruksi fcmp mengembalikan nilai boolean (i1) atau vector nilai boolean berdasarkan 
; perbandingan dua floating-point, floating-point vector.
; 
; Operasi icmp memerlukan predikat yang berperan sebagai penentu operasi. 
; Predikat yang valid untuk icmp adalah: 
;   oeq, one, ord, ogt, oge, olt, ole
;   ueq, une, uno, ugt, uge, ult, ule

define i32 @fcmp_compare () {

    %1      = alloca float, align 4 
    %2      = alloca float, align 4

    store float 4.0, float* %1, align 4
    store float 5.0, float* %2, align 4

    %ival1  = load float, float* %1, align 4
    %ival2  = load float, float* %2, align 4

; Ordered operation
; Operasi bertipe ordered adalah operasi dengan setiap operan bukan merupakan QNAN.
; Salah satu syarat yang harus dipenuhi untuk menghasilkan nilai True adalah tidak ada 
; operan bernilai QNAN.

    ; oeq (Ordered Equal)
    ; menghasilkan True jika kedua operan bernilai sama. False, jika sebaliknya.
    %v01    = fcmp oeq float %ival1, %ival2     ; var = (var == var)
    %v02    = fcmp oeq float %ival1, 0.0        ; var = (var == imm)
    %v03    = fcmp oeq float 0.0, %ival2        ; var = (imm == var)
    %v04    = fcmp oeq float 1.0, 1.0           ; var = (imm == imm)    -> false

    ; one (Ordered Not Equal)
    ; menghasilkan True jika kedua operan bernilai tak sama. False, jika sebaliknya.
    %v11    = fcmp one float %ival1, %ival2     ; var = (var != var)
    %v12    = fcmp one float %ival1, 0.0        ; var = (var != imm)
    %v13    = fcmp one float 0.0, %ival2        ; var = (imm != var)
    %v14    = fcmp one float 1.0, 1.0           ; var = (imm != imm)    -> true
 
    ; ogt (Ordered Greater Than)
    ; menghasilkan True jika operan pertama bernilai lebih besar dibandingkan operan kedua.
    ; False, jika sebaliknya.
    %v21    = fcmp ogt float %ival1, %ival2     ; var = (var > var)
    %v22    = fcmp ogt float %ival1, 0.0        ; var = (var > imm)
    %v23    = fcmp ogt float 0.0, %ival2        ; var = (imm > var)
    %v24    = fcmp ogt float 1.0, 1.0               ; var = (imm > imm)     -> false

    ; oge (Ordered Greater or Equal)
    ; menghasilkan True jika operan pertama bernilai lebih besar atau sama dengan operan kedua.
    ; False, jika sebaliknya.
    %v31    = fcmp oge float %ival1, %ival2     ; var = (var >= var)
    %v32    = fcmp oge float %ival1, 0.0        ; var = (var >= imm)
    %v33    = fcmp oge float 0.0, %ival2        ; var = (imm >= var)
    %v34    = fcmp oge float 1.0, 1.0           ; var = (imm >= imm)    -> false

    ; olt (Ordered Lower Than)
    ; menghasilkan True jika operan pertama bernilai lebih kecil dibandingkan operan kedua.
    ; False, jika sebaliknya.
    %v41    = fcmp olt float %ival1, %ival2     ; var = (var < var)
    %v42    = fcmp olt float %ival1, 0.0        ; var = (var < imm)
    %v43    = fcmp olt float 0.0, %ival2        ; var = (imm < var)
    %v44    = fcmp olt float 1.0, 1.0           ; var = (imm < imm)     -> true

    ; ole (Ordered Lower or Equal)
    ; menghasilkan True jika operan pertama bernilai lebih kecil ata sama dengan operan kedua.
    ; False, jika sebaliknya.
    %v51    = fcmp ole float %ival1, %ival2     ; var = (var <= var)
    %v52    = fcmp ole float %ival1, 0.0        ; var = (var <= imm)
    %v53    = fcmp ole float 0.0, %ival2        ; var = (imm <= var)
    %v54    = fcmp ole float 1.0, 1.0           ; var = (imm <= imm)    -> true

    ; ord (Ordered)
    ; menghasilkan True jika kedua operan bukan QNAN.
    %v61    = fcmp ord float %ival1, %ival2
    %v62    = fcmp ord float %ival1, 0.0
    %v63    = fcmp ord float 0.0, %ival2
    %v64    = fcmp ord float 1.0, 1.0


; Unordered operation
; Operasi bertipe unordered adalah operasi dengan setiap operan memiliki kemungkinan sebagai QNAN.

    ; ueq (Unordered Equal)
    ; menghasilkan True jika kedua operan bernilai sama. False, jika sebaliknya.
    %v71    = fcmp ueq float %ival1, %ival2     ; var = (var == var)
    %v72    = fcmp ueq float %ival1, 0.0        ; var = (var == imm)
    %v73    = fcmp ueq float 0.0, %ival2        ; var = (imm == var)
    %v74    = fcmp ueq float 1.0, 1.0           ; var = (imm == imm)    -> false

    ; une (Unordered Not Equal)
    ; menghasilkan True jika kedua operan bernilai tak sama. False, jika sebaliknya.
    %v81    = fcmp une float %ival1, %ival2     ; var = (var != var)
    %v82    = fcmp une float %ival1, 0.0        ; var = (var != imm)
    %v83    = fcmp une float 0.0, %ival2        ; var = (imm != var)
    %v84    = fcmp une float 1.0, 1.0           ; var = (imm != imm)    -> true

    ; ugt (Signed Greater Than)
    ; menghasilkan True jika operan pertama bernilai lebih besar dibandingkan operan kedua.
    ; False, jika sebaliknya.
    %v91    = fcmp ugt float %ival1, %ival2     ; var = (var > var)
    %v92    = fcmp ugt float %ival1, 0.0        ; var = (var > imm)
    %v93    = fcmp ugt float 0.0, %ival2        ; var = (imm > var)
    %v94    = fcmp ugt float 1.0, 1.0           ; var = (imm > imm)     -> false

    ; uge (Signed Greater or Equal)
    ; menghasilkan True jika operan pertama bernilai lebih besar atau sama dengan operan kedua.
    ; False, jika sebaliknya.
    %va1    = fcmp uge float %ival1, %ival2     ; var = (var >= var)
    %va2    = fcmp uge float %ival1, 0.0        ; var = (var >= imm)
    %va3    = fcmp uge float 0.0, %ival2        ; var = (imm >= var)
    %va4    = fcmp uge float 1.0, 1.0           ; var = (imm >= imm)    -> true

    ; ult (Signed Lower Than)
    ; menghasilkan True jika operan pertama bernilai lebih kecil dibandingkan operan kedua.
    ; False, jika sebaliknya.
    %vb1    = fcmp ult float %ival1, %ival2     ; var = (var < var)
    %vb2    = fcmp ult float %ival1, 0.0        ; var = (var < imm)
    %vb3    = fcmp ult float 0.0, %ival2        ; var = (imm < var)
    %vb4    = fcmp ult float 1.0, 1.0           ; var = (imm < imm)     -> false

    ; ule (Signed Lower or Equal)
    ; menghasilkan True jika operan pertama bernilai lebih kecil atau sama dengan operan kedua.
    ; False, jika sebaliknya.
    %vc1    = fcmp ule float %ival1, %ival2     ; var = (var <= var)
    %vc2    = fcmp ule float %ival1, 0.0        ; var = (var <= imm)
    %vc3    = fcmp ule float 0.0, %ival2        ; var = (imm <= var)
    %vc4    = fcmp ule float 1.0, 1.0           ; var = (imm <= imm)    -> false
 
    ; uno (Unordered)
    ; menghasilkan True jika salah satu operan merupakan QNAN.
    %vd1    = fcmp ord float %ival1, %ival2
    %vd2    = fcmp ord float %ival1, 0.0
    %vd3    = fcmp ord float 0.0, %ival2
    %vd4    = fcmp ord float 1.0, 1.0

    ret i32 0
}