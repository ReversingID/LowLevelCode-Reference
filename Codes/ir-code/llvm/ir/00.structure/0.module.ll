;   Module
;
;   LLVM IR terdiri atas beberapa komponen yang tersusun secara terstruktur
;
; LLVM Bitcode:
;   $ llvm-as module.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o module.asm module.ll
;
;-----------------------------------------------------------------------------

; LLVM IR - Module
; Module merupakan abstraksi dari sebuah module atau source code file.

; Module terdiri atas beberapa bagian:
;   - Target information
;   - Global symbols
;       - global variables
;       - function declarations
;       - function definition
;   - other stuff

; -- Target Information --
source_filename = "module.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; format datalayout:
;   e-m:e-i64:64-f80:128-n8:16:32:64-S128
;
;   e           endian (little)
;   m:e         ELF mangling
;   i64:64      ABI alignment i64
;   f80:128     floating point
;   n8:16:32:64 native integer widths

; format triple
;   x86_64-pc-linux-gnu
;
;   x86_64              architecture
;   pc-linux            vendor
;   gnu                 system


; -- Global Symbols --
; Simbol global diidentifikasi dengan sebuah nama dan diawali dengan 
; simbol @ sebagai penanda Global Symbol.

; Semua simbol yang akan digunakan harus telah terdeklarasi sebelumnya.

; Deklarasi (declaration) memberikan informasi keberadaan sebuah simbol.
; Definisi (definition) memberikan informasi wujud konkret dari sebuah simbol.
; Deklarasi dapat dilakukan tanpa adanya definisi.

; Penjelasan serta contoh deklarasi dan definisi akan diberikan kemudian.


; Global variables

; variable
@var = global i32 135, align 4

; string constant
@.str = private unnamed_addr constant [13 x i8] c"Hello World\0A\00"


; Function declaration

; Function definition


; -- Other Stuffs --
; Informasi opsional yang memberikan informasi tambahan terkait modul
; dan simbol di dalamnya.

; Attribute
; Memberikan informasi bagaimana sebuah komponen diperlakukan. 
; Atrribute diidentifikasi dengan sebuah bilangan
attributes #0 = { noinline nounwind optnone uwtable }

; Metadata
; Memberikan informasi flag dan metadata yang digunakan dalam module.
; Sebuah flag diidentifikasi dengan sebuah bilangan.
!llvm.module.flags =!{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"RevID LLVM IR"}
