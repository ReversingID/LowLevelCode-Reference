;   Array
;   LLVM IR Data Type
;
; LLVM Bitcode:
;   $ llvm-as array.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o array.asm array.ll
;
;-----------------------------------------------------------------------------

source_filename = "array.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; LLVM IR menggunakan prinsip Strong Type yang ketat. Setiap data yang terlibat
; dalam operasi, setiap nilai yang dihasilkan, harus menyertakan tipe data 
; secara eksplisit.

; Pemberlakuan Strong Type memberikan kemudahan dalam menghasilkan kode yang 
; sesuai dengan arsitektur target.


; Array
; Array himpunan objek atau elemen dengan tipe seragam dan terletak secara
; sekuensial (berurutan) di memory.
;
; Elemen Array dapat berupa tipe dasar (integer, float, pointer, dsb) maupun
; tipe agregat (Array, Struct, dsb). Setiap elemen dapat diakses secara individual
; melalui pengalamatan berbasis indeks.
;
; LLVM IR mendukung penggunaan array multidimensi. Dimensi pada Array adalah
; banyaknya  titik atau indeks yang digunakan untuk memilih sebuah elemen pada
; Array.
;
; Array dimensi satu dapat diandaikan sebagai sebuah daftar.
; Array dimensi dua dapat diandaikan sebagai sebuah tabel.
; Array dimensi tiga dapat diandaikan sebagai kubus data.
; dsb.
; 
; Semakin banyak dimensi maka memory yang dibutuhkan akan semakin besar untuk
; menampung data.


; Deklarasi
; Deklarasi Array memerlukan jumlah elemen dan tipe data yang akan dianggap
; sebagai suatu tipe data bentukan.
;
;   [ N x TYPE ]
;
; Deklarasi Array multidimensi memiliki pola yang sama dimana type elemen
; merupakan sebuah Array.

; Array dapat dideklarasikan dalam keadaan initialized maupun uninitialized.
; Array yang terinisialisasi akan berisi nilai sebanyak jumlah elemen Array.
; Sementara Array yang tak terinisialisasi akan berisi nilai default.


; -- Deklarasi Array global --
; array global, inisialisasi dengan nol
@g_arr1     = global [17 x i8] zeroinitializer

; array global, inisialisasi dengan [1, 2, 3, 4, 5]
@g_arr2     = constant [5 x i32] [i32 1, i32 2, i32 3, i32 4, i32 5]


declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg)

define i32 @algorithm () {

; -- Deklarasi Array lokal --
; contoh deklarasi Array dimensi satu dan dua

; One-Dimension Array
    ; Array dengan 40 elemen i32
    %iarr.addr  = alloca [40 x i32], align 16

    ; Array dengan 8 elemen float
    %farr.addr  = alloca [8 x float]

    ; Array dengan 10 elemen i8
    %carr.addr  = alloca [10 x i8]

    ; Array dapat pula didefinisikan dengan mengalokasikan N variabel
    ; yang dirujuk dengan pointer (variabel).
    ; alokasikan 100 elemen i32 dan ditunjuk oleh %iarr2.addr
    %iarr2.addr = alloca i32, i32 100

; Two-Dimension Array
    ; Array 3x5 dengan elemen i32 (3 baris, 5 kolom)
    %itbl.addr  = alloca [3 x [5 x i32]]

    ; Array 12x10 dengan elemen float (12 baris, 10 kolom)
    %ftbl.addr  = alloca [12 x [10 x float]]

; array dimensi lain akan memiliki pola yang serupa.


; Inisialisasi Array lokal
; Proses inisialisasi Array lokal terbagi menjadi beberapa bagian:
;   - deklarasi Array di Stack (function)
;   - deklarasi nilai Array konstan di global
;   - penyalinan nilai Array konstan ke Array lokal
    %iarr_cast  = bitcast [40 x i32]* %iarr.addr to i8*
    call        void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %iarr_cast, i8* align 16 bitcast ([40 x i32]* @__const.main.iarr.data to i8*), i64 160, i1 false)


; -- Akses Elemen Array --

; Terdapat dua jenis akses terhadap elemen Array, yaitu: load dan store 
; (atau read dan write).
; Sebelum mengakses nilai dari elemen (load/store), alamat elemen terkait harus
; terlebih dahulu didapatkan. Operasi load/store kemudian akan menggunakan alamat
; tersebut sebagai rujukan.
;
; Untuk mendapatkan reference ke item, digunakan GetElementPtr.
; GetElementPtr mengembalikan sebuah pointer dengan tipe data tertentu ke elemen
; yang ditunjuk.

; One-Dimension Array
; Case: assign item pada index ke [2] pada %iarr.addr[40 x i32] dengan 135
;       iarr.addr[2] = 135

    ; dapatkan reference ke elemen
    ; dapatkan potongan (chunk) pertama, ambil elemen indeks 2 dari potongan tersebut.
    %iae.addr   = getelementptr [40 x i32], [40 x i32]* %iarr.addr, i64 0, i64 2
    ;                           tipe chunk          array           ^       ^
    ;                                             ambil chunk pertama       ^
    ;                                       ambil indeks 2 dari chunk pertama
    ; %iae.addr merupakan pointer ke elemen

    ; Store (Write)
    ; simpan nilai ke elemen Array
    ; Operasi store/write merupakan operasi dasar yang berlaku untuk tipe tersebut.
    store       i32 135, i32* %iae.addr, align 4
    ;           nilai                ^
    ;                pointer ke elemen

    ; Load (Read)
    ; dapatkan nilai dari elemen Array.
    ; Operasi load/read merupakan operasi dasar yang berlaku untuk tipe tersebut.
    %iarr.val   = load i32, i32* %iae.addr, align 4
    ;           tipe nilai              ^
    ;                   pointer ke elemen

; Two-Dimension Array
; Case: assign item pada index ke [2][3] pada %itbl.addr [3 x [5 x i32]] dengan 135
;       itbl.addr[2][3] = 135

    ; dapatkan reference ke elemen
    ; Array memiliki dua dimensi (tabel), sehingga elemen dirujuk berdasarkan baris
    ; dan kolom yang tepat.
    ; Mula-mula, perlu didapatkan potongan data dari baris yang tepat.
    ; Kemudian, dapatkan data pada offset kolom.
    ;
    ; [1] dapatkan baris data
    %row.addr   = getelementptr [3 x [5 x i32]], [3 x [5 x i32]]* %itbl.addr, i64 0, i64 2
    ;                           tipe chunk                  tabel               ^      ^
    ;                                                         ambil chunk pertama      ^
    ;                                                  ambil indeks 2 dari chunk pertama
    ; %row.addr adalah pointer ke chunk / potongan data.
    ;
    ; [2] dapatkan data pada baris
    %ite.addr   = getelementptr [5 x i32], [5 x i32]* %row.addr, i64 0, i64 3
    ;                           tipe chunk       array / baris       ^      ^
    ;                                              ambil chunk pertama      ^
    ;                                       ambil indeks 3 dari chunk pertama
    ; %ite.addr merupakan pointer ke elemen

    ; alternatif lain
    ; reference ke data dapat diperoleh dengan sekali pemanggilan GetElementPtr
    ; %ite.addr  = getelementptr [3 x [5 x i32]], [3 x [5 x i32]]* %itbl.addr, i64 0, i64 2, i64 3

    ; Store (Write) 
    store       i32 136, i32* %ite.addr, align 4

    ; Load (Read)
    %itbl.val   = load i32, i32* %ite.addr, align 4

    ; 


; Access Value



; Casting
; Casting array menjadi tipe lain
    ; casting dari [40 x i32] jadi i8*
    ; ekuivalen: int [40] -> char *
    %arr_cast   = bitcast [40 x i32]* %iarr.addr to i8*


    ret i32 0
}

; Proses inisialisasi Array lokal terbagi menjadi beberapa bagian:
;   - deklarasi Array di Stack (function)
;   - deklarasi nilai Array konstan di global
;   - penyalinan nilai Array konstan ke Array lokal
@__const.main.iarr.data = private unnamed_addr constant [40 x i32] [i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0], align 16