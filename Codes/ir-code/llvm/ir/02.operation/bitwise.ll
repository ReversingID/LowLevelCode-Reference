;   Bitwise
;
;   Operasi bitwise.
;
; LLVM Bitcode:
;   $ llvm-as bitwise.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o bitwise.asm bitwise.ll
;
;-----------------------------------------------------------------------------

source_filename = "bitwise.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Bitwise
; Operasi bitwise adalah operasi logik yang dilakukan pada level bit secara
; individual, bit demi bit. Operasi bitwise dilakukan terhadap integer.
;
; Beberapa operasi bitwise:
;     - AND
;     - OR
;     - exclusive OR
;     - NOT
;     - shift (left / right)
; 
; Pada operasi shift, operan 2 menunjukkan pergeseran dalam bit yang memiliki
; nilai maksimum sebanyak jumlah bit dalam operan 1.
;
; LLVM IR tidak memiliki instruksi khusus untuk melakukan operasi NOT, namun
; operasi ini dapat disimulasikan menggunakan operasi lain.

define i32 @algorithm () {

    %ivar1  = alloca i32, align 4
    %ivar2  = alloca i32, align 4

    store   i32 135, i32* %ivar1, align 4
    store   i32 3, i32* %ivar2, align 4

    %val_1  = load i32, i32* %ivar1, align 4
    %val_2  = load i32, i32* %ivar2, align 4

; AND (bitwise logical add)
    %v01.val    = and i32 %val_1, %val_2        ; var = and var, var
    %v02.val    = and i32 %val_1, 11            ; var = and var, imm
    %v03.val    = and i32 12, %val_2            ; var = and imm, var
    %v04.val    = and i32 13, 14                ; var = and imm, imm

; OR (bitwise logical or)
    %v11.val    = or i32 %val_1, %val_2         ; var = or var, var
    %v12.val    = or i32 %val_1, 21             ; var = or var, imm
    %v13.val    = or i32 22, %val_2             ; var = or imm, var
    %v14.val    = or i32 23, 24                 ; var = or imm, imm

; XOR (bitwise logical exclusive or)
    %v21.val    = xor i32 %val_1, %val_2        ; var = xor var, var
    %v22.val    = xor i32 %val_1, 31            ; var = xor var, imm
    %v23.val    = xor i32 32, %val_2            ; var = xor imm, var
    %v24.val    = xor i32 33, 34                ; var = xor imm, imm

; NOT (bitwise logical not)
    %v31.val    = xor i32 %val_1, -1            ; var = not var

; SHL (bitwise logical shift left)
    %v41.val    = shl i32 %val_1, %val_2        ; var = shl var, var
    %v42.val    = shl i32 %val_1, 41            ; var = shl var, imm
    %v43.val    = shl i32 42, %val_2            ; var = shl imm, var
    %v44.val    = shl i32 43, 4                 ; var = shl imm, imm

; ASHR (bitwise arithmetic shift right)
    %v51.val    = ashr i32 %val_1, %val_2       ; var = ashr var, var
    %v52.val    = ashr i32 %val_1, 51           ; var = ashr var, imm
    %v53.val    = ashr i32 52, %val_2           ; var = ashr imm, var
    %v54.val    = ashr i32 53, 4                ; var = ashr imm, imm

; LSHR (bitwise logical shift right)
    %v61.val    = lshr i32 %val_1, %val_2       ; var = lshr var, var
    %v62.val    = lshr i32 %val_1, 61           ; var = lshr var, imm
    %v63.val    = lshr i32 62, %val_2           ; var = lshr imm, var
    %v64.val    = lshr i32 63, 4                ; var = lshr imm, imm


    ret i32 0
}