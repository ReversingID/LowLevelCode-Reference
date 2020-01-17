;   Method
;   Object Model & Manipulation
;
;   Jenis Method dan Representasi dalam LLVM IR.
;
; LLVM Bitcode:
;   $ llvm-as method.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o method.asm method.ll
;
;-----------------------------------------------------------------------------

source_filename = "method.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Method / Function
; Kumpulan instruksi (dan Basic Block) yang diidentifikasi sebagai entitas
; tersendiri berdasarkan nama. Sebuah method berasosiasi dengan objek, baik secara
; langsung maupun tak langsung, untuk membentuk operasi yang dapat dilakukan. Umumnya
; method digunakan untuk memanipulasi nilai di objek.
;
; Semua Method atau fungsi yang membentuk Class dapat direpresentasikan sebagai 
; fungsi.
;
; Terdapat tiga jenis method:
;   - instance method
;   - static method
;   - virtual method


;   Class yang didefinisikan
;
;       class ClassDef
;       {
;       public:
;           int mtd_instance ()
;           { }
;       
;           static int mtd_static ()
;           { }
;       
;           virtual int mtd_virtual ()
;           { }
;       };

; catatan: apabila sebuah Class memiliki minimal satu virtual method, maka sebuah Field
; vtable disisipkan di awal Class. Virtual Table (vtable) adalah pointer menuju tabel,
; berisi Function Pointer. 
%vtable.ClassDef    = type { i32(%class.ClassDef*)* }       ; definisi vtable secara eksplisit
%class.ClassDef     = type { %vtable.ClassDef* }

; instansiasi vtable untuk ClassDef
@vtable.ClassDef.data = global %vtable.ClassDef {
    i32 (%class.ClassDef*)* @ClassDef.mtd_virtual
}

; -- Deklarasi Method --

;         int   ClassDef::mtd_instance ()
; _ZN8ClassDef12mtd_instanceEv

; Instance Method atau method di level instance adalah method yang terikat pada objek,
; membutuhkan objek (instance sebuah Class) ketika dipanggil.

; Parameter pertama Instance Method adalah pointer ke instance atau objek.
; Segala manipulasi terhadap data objek akan dilakukan terhadap pointer tersebut.
define linkonce_odr dso_local i32 @ClassDef.mtd_instance (%class.ClassDef* %this) {
    ret i32 0
}


; static  int   ClassDef::mtd_static ()
; _ZN8ClassDef10mtd_staticEv

; Static Method atau method di level Class adalah method yang terikat pada Class, tidak
; membutuhkan objek ketika dipanggil. 

; Static Method 
define linkonce_odr dso_local i32 @ClassDef.mtd_static () {
    ret i32 0
}


; virtual int   ClassDef::mtd_virtual ()
; _ZN8ClassDef11mtd_virtualEv

; Virtual Method adalah method yang dapat didefinisikan ulang pada Class turunan.

; Setiap Virtual Method tercatat di vtable. Vtable digunakan untuk melakukan resolusi
; Virtual Method yang sesuai jika Class turunan melakukan pemanggilan method.
; Di luar itu, Virtual Method tidak berbeda dengan Instance Method. 
define linkonce_odr dso_local i32 @ClassDef.mtd_virtual (%class.ClassDef* %this) {
    ret i32 0
}


define i32 @algorithm () {

    %object.ClassDef    = alloca %class.ClassDef

; -- Pemanggilan --

    ; Pemanggilan Instance Method
    ; Instance Method memerlukan objek instance Class terkait
    call        i32 @ClassDef.mtd_instance (%class.ClassDef* %object.ClassDef)

    ; Pemanggilan Static Method
    ; Static Method tak lebih dari function biasa
    call        i32 @ClassDef.mtd_static ()

    ; Pemanggilan Virtual Method (dengan resolusi)
    ; Virtual Method memerlukan objek instance Class terkait, sama seperti Instance Method
    ; dapatkan alamat vtable dari instance Class
    %vtable.addr    = getelementptr %class.ClassDef, %class.ClassDef* %object.ClassDef, i32 0, i32 0
    %vtable.data    = load %vtable.ClassDef*, %vtable.ClassDef** %vtable.addr

    ; resolusi alamat mtd_virtual
    %vtable.entry   = getelementptr %vtable.ClassDef, %vtable.ClassDef* %vtable.data, i32 0, i32 0
    %virt_method    = load i32 (%class.ClassDef*)*, i32(%class.ClassDef*)** %vtable.entry

    call        i32 %virt_method (%class.ClassDef* %object.ClassDef)

    ret i32 0
}