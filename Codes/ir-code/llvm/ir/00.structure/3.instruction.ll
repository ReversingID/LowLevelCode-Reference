;   Instruction
;
;   Instruksi merupakan sebuah operasi tunggal yang dapat dikerjakan oleh pemroses.
;   Sebuah instruction memiliki format.
;
; LLVM Bitcode:
;   $ llvm-as instruction.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o instruction.asm instruction.ll
;
;-----------------------------------------------------------------------------

; -- LLVM IR - Module --
source_filename = "instruction.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; -- LLVM IR - Symbols --
declare i32 @algorithm ()

define  i32 @main () {

; Instruction adalah statement dalam satu baris tunggal.
; LLVM IR diklasifikasikan ke dalam RISC (Reduced Instruction Set Computer), dimana
; semua operasi yang didefinisikan merupakan operasi sederhana dan generik.

; Secara sintaksis, instruksi LLVM merupakan Three-Address Code (TAC atau 3AC).
; Setiap instruksi memiliki paling banyak tiga operan dan umumnya merupakan kombinasi 
; dari assignment dan operator binari.
;
; Format umum instruksi adalah sebagai berikut:
;
;   [label:] [%var = ] instruction [operands] [;comment]
;
; Field yang ada di dalam [] merupakan field opsional.

; Jumlah operan suatu instruksi dapat bervariasi. Sebagian besar instruksi memiliki dua.
; Beberapa dapat memiliki lebih dari itu. Sebuah operasi dapat menghasilkan nilai dan
; disimpan ke sebuah variabel (lokal/global). Hampir semua Instruction mengembalikan
; nilai.
;
; Sebagai bahasa yang Strong Type, LLVM IR mensyaratkan penegasan tipe data yang jelas
; untuk operasi yang dilakukan. Setiap operan harus memiliki tipe yang sepadan.


; Contoh One-Operand Instruction
    ; panggil (call) sebuah fungsi bernama @algorithm
    ; dalam hal ini, operan adalah nama fungsi dan instruksi adalah "call"
    call    i32 @algorithm ()

; Contoh Two-Operand Instruction
    ; kalikan 15 dan 9 kemudian simpan di %result
    ; dalam hal ini, operan adalah angka 15 dan 9 dan instruksi adalah mul
    %result     = mul i32 15, 9


; LLVM IR menggunakan prinsip SSA (Static Single Assignment).
; SSA adalah prinsip yang menegaskan bahwa:
;   - assignment setiap variabel hanya dapat dilakukan sekali.
;   - setiap variabel harus terdefinisi sebelum digunakan.
;
; Implikasinya adalah, dalam sebuah fungsi bisa terdapat banyak variabel untuk 
; menampung nilai masing-masing operasi.
;
; Karena kemudahan dalam traceback perubahan nilai, SSA digunakan untuk melakukan
; optimisasi oleh mesin, namun dapat menjadi kerumitan bagi manusia.


    ret i32 0
}
