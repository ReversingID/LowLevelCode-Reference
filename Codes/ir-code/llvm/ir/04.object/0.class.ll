;   Class
;   Object Model & Manipulation
;
;   Memodelkan Class ke dalam LLVM IR
;
; LLVM Bitcode:
;   $ llvm-as class.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o class.asm class.ll
;
;-----------------------------------------------------------------------------

source_filename = "class.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Class
; Sebuah template yang memodelkan sebuah entitas dan perilakunya.
; Class terdiri atas beberapa komponen:
;   - Field / variable
;   - Method / function
;
; Instansiasi Class akan menghasilkan objek dengan data masing-masing.
; Sebuah Class dapat diturunkan dari Class lain.
;
; LLVM IR tidak mendukung paradigma pemrograman berorientasi objek, sehingga
; tidak ada dukungan terhadap notasi Class secara alamiah. Class dapat diimplementasikan
; ke LLVM IR melalui pemetaan.
;
; Dalam LLVM IR, sebuah Class dapat dianggap sebagai sebuah Structure yang
; berasosiasi dengan sekelompok fungsi (method). Fungsi tersebut digunakan untuk
; memanipulasi sifat atau properti dari objek, sehingga umumnya parameter pertama
; method adalah pointer ke Structure.

; Contoh Class yang akan dipetakan:
;
;   class Square
;   {   
;   private:
;       int _length;
;   public:
;       int id;
;
;       Square(int id, int length)
;       { 
;           this->id = id;
;           this->_length = length;
;       }
;
;       int length()
;       {
;           return _length;
;       }
;   };


; -- Deklarasi Struktur Objek --
; Semua Field atau variabel yang membentuk Class dapat direpresentasikan sebagai
; sebuah Structure.
;
; Terdapat dua field pada Class Square, yaitu
;   - id, field public bertipe int
;   - _length, field private bertipe int
;
; Sebuah Class dapat memberikan Access Specifier ke Class: Public, Private, Protected.
; LLVM IR tidak dapat memetakan secara langsung Access Specifier, sehingga pembatasan
; akses harus dilakukan di level kode.

%class.Square   = type {
    i32,        ; merepresentasikan _length
    i32         ; merepresentasikan id
}

; Setiap Class perlu memiliki minimal satu Field untuk dapat membentuk Structure.
; Bila secara logis sebuah Class tidak memiliki anggota Field, maka sebuah Field
; dummy harus disertakan dalaam definisi Structure.

%class.EmptyClass   = type { i8 }


; -- Deklarasi Method --
; Terdapat dua method yang didefinisikan secara public, yaitu: Square() dan length()

; Square::Square(int id, int length)
; Constructor
; Method khusus yang dipanggil pertama kali ketika objek diciptakan / instansiasi.
; Method ini umumnya digunakan untuk menginisiasi field sebuah Class.

define linkonce_odr dso_local void @Square (%class.Square* %this, i32 %id, i32 %length) {
entry:
    ; this->id = id
    %this.id        = getelementptr inbounds %class.Square, %class.Square* %this, i32 0, i32 1
    store           i32 %id, i32* %this.id, align 4

    ; this->_length = length;
    %this._length   = getelementptr inbounds %class.Square, %class.Square* %this, i32 0, i32 0
    store           i32 %length, i32* %this._length, align 4

    ret void
}


; int Square::length()
; Instance Object
; Setiap nama field dan method akan mengalami Name-Mangling dengan pola tertentu.
; Name-Mangling dilakukan untuk membuat identitas unik terhadap setiap anggota di Class
; berdasarkan signature. Hal ini dilakukan untuk mendukung method overload di level Class.

; Dalam contoh ini, penggunaan Name-Mangling tidak akan dilakukan.
define linkonce_odr dso_local i32 @Square.length (%class.Square* %this) {
entry:
    ; tmp = this->_length;
    %_length.addr   = getelementptr inbounds %class.Square, %class.Square* %this, i32 0, i32 0
    %retval         = load i32, i32* %_length.addr 

    ret i32 %retval
}