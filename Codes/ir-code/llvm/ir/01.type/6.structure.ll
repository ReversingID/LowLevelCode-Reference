;   Structure
;   LLVM IR Data Type
;
; LLVM Bitcode:
;   $ llvm-as structure.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o structure.asm structure.ll
;
;-----------------------------------------------------------------------------

source_filename = "structure.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; LLVM IR menggunakan prinsip Strong Type yang ketat. Setiap data yang terlibat
; dalam operasi, setiap nilai yang dihasilkan, harus menyertakan tipe data 
; secara eksplisit.

; Pemberlakuan Strong Type memberikan kemudahan dalam menghasilkan kode yang 
; sesuai dengan arsitektur target.


; Structure
; Structure adalah kumpulan beberapa data dengan tipe yang dapat berlainan namun
; dianggap sebagai satu kesatuan.
;
; Structure akan menempati ruang memori secara kontigu. 
; 
; Tidak ada batasan banyaknya komponen yang membentuk sebuah struktur. Komponen
; struktur atau field dapat berupa tipe dasar (integer, float, dsb) maupun 
; tipe agregasi lain (struct, array, dsb).
;
; Setiap komponen dapat diakses (load/store) secara individu.


; Deklarasi Tipe
; Structure didefinisikan dengan mendeklarasikan semua tipe data field secara
; berurutan dari awal hingga akhir. TIpe yang disebutkan lebih awal akan
; diletakkan dengan offset lebih awal.
;
; Structure yang digunakan memiliki tipe ekivalen di C:
;
;   struct person_t { 
;       char name [10];
;       int age; 
;   };

; Deklarasi tipe normal struct
; Structure dideklarasikan sebagai kumpulan tipe data yang diapit oleh { }
;
;   type { TYPE_1, TYPE_2, ... }
;
;                         name   age
%struct.normal_t    = type { [10 x i8],  i32 }

; Deklarasi tipe packed struct
; Structure dapat pula merupakan packed struct dimana padding antar elemen
; ditiadakan
;
;   type <{ TYPE_1, TYPE_2, ... }>
;
;                         name   age
%struct.pack_t      = type <{ [10 x i8], i32 }>

; Deklarasi tipe opaque structure
; Structure berbentuk Opaque Structure hanya merepresentasikan (deklarasi)
; tipe tanpa adanya badan (definisi) struktur.
%struct.opaque_t    = type opaque


; Sebuah structure dapat bersifat nested (bersarang) dimana di dalam definisi 
; structure terdapat komponen structure.
;
;   struct employee_t {
;       person_t    person;
;       int         salary;    
;   }
%struct.nested_t    = type {
    %struct.normal_t,         ; mengacu kepada sebuah structure yang telah didefinisikan
    i32*
}


; -- Deklarasi instance global --
; Deklarasi global variable bertipe struct
@g_normal   = global %struct.normal_t zeroinitializer, align 4
@g_pack     = global %struct.pack_t zeroinitializer, align 1


define i32 @algorithm () {

; -- Deklarasi instance lokal --
; Deklarasi local variable bertipe struct

; Normal Struct
    %l_normal   = alloca %struct.normal_t, align 4

; Packed Struct
    %l_pack     = alloca %struct.pack_t, align 4

; Nested Struct
    %l_nested   = alloca %struct.nested_t, align 4


; -- Akses Field --
; Akses terhadap field dapat dibedakan menjadi dua operasi dasar yaitu baca (read)
; dan tulis (write). Dalam LLVM IR, operasi baca/tulis dapat dilakukan secara
; langsung maupun tak langsung. 
; 
; Akses tak langsung terhadap elemen Structure dilakukan dalam beberapa tahap
;   - Mendapatkan alamat memori dari elemen terkait melalui GetElementPtr
;   - Melakukan Load atau Store untuk operasi baca atau tulis.
; 
; Reference ke elemen atau alamat memori dari item dapat diperoleh menggunakan
; instruksi GetElementPtr.
;
; Sementara akses langsung terhadap elemen Structure dilakukan menggunakan 
; ExtractValue dan InsertValue.

    ; load objek terlebih dahulu
    %l_normal.tmp   = load %struct.normal_t, %struct.normal_t* %l_normal

; ==== GetElementPtr + Load/Store ====
; Case: assign nilai ke struct.normal_t::age dan baca kembali nilainya
;   l_normal.age = 17

    ; dapatkan reference ke elemen
    ; dapatkan potongan (chunk) pertama.
    ; Age adalah field dengan index 1 pada %st_struct, sehingga dengan mengambil
    ; elemen index 1 pada chunk, kita mendapatkan alamat ke age.
    %age.addr       = getelementptr inbounds %struct.normal_t, %struct.normal_t* %l_normal, i32 0, i32 1

    ; Store (Write)
    ; simpan nilai ke elemen
    ; Operasi store/write merupakan operasi dasar yang berlaku untuk tipe tersebut.
    store           i32 17, i32* %age.addr, align 4

    ; Load (Read)
    ; dapatkan nilai dari elemen.
    ; Operasi load/read merupakan operasi dasar yang berlaku untuk tipe tersebut.
    %age.val        = load i32, i32* %age.addr, align 4

; Case: assign nilai ke st_employee::person.age dan baca kembali nilainya
;   l_nested.person.age = 17

    ; dapatkan reference ke person_t
    %person.addr    = getelementptr inbounds %struct.nested_t, %struct.nested_t* %l_nested, i32 0, i32 0

    ; dapatkan reference ke age
    %age2.addr      = getelementptr inbounds %struct.normal_t, %struct.normal_t* %person.addr, i32 0, i32 1

    ; Store (Write)
    ; simpan nilai elemen
    store           i32 17, i32* %age2.addr, align 4

    ; Load (Read)
    ; dapatkan nilai dari elemen
    %age2.val       = load i32, i32* %age2.addr, align 4


; ==== ExtractValue + InsertValue ====
; Case: assign nilai ke struct.normal_t::age
;   l_normal.age = 17
    ; Store (Write)
    ; simpan nilai elemen
    insertvalue %struct.normal_t %l_normal.tmp, i32 17, 1

    ; Load (Read)
    ; dapatkan nilai dari elemen
    %age3.val       = extractvalue %struct.normal_t %l_normal.tmp, 1


    ret i32 0
}