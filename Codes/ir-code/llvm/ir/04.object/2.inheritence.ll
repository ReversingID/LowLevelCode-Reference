;   Inheritance
;   Object Model & Manipulation
;
;   Memodelkan turunan dan warisan dalam LLVM IR
;
; LLVM Bitcode:
;   $ llvm-as inheritance.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o inheritance.asm inheritance.ll
;
;-----------------------------------------------------------------------------

source_filename = "inheritance.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Inheritance
; Salah satu konsep penting dalam Object-Oriented Programming.
; Inheritance (warisan) adalah konsep dimana sebuah Class yang didefinisikan dapat 
; memiliki segala property dari Class lain.
;
; Class dapat diturunkan dari Class atau Interface lain, dengan aturan tertentu.
; Class yang diturunkan dari Class lain disebut sebagai Derived Class (Class anak).
; Sementara Class yang menjadi orang tua disebut sebagai Base Class.

;   Class yang terlibat
;
;       class Base 
;       {
;           int _a;
;       public:
;           void setA(int value)
;           {
;               _a = value;
;           }
;       };
;       
;       class Derived : public Base
;       {
;           int _b;
;       public:
;           void setB(int value)
;           {
;               _b = value;
;           }
;       };

; Derived mewarisi method yang didefinisikan oleh Base Class.
; Dengan demikian Derived dapat melakukan pemanggilan method yang sama 
; sebagaimana didefinisikan oleh Base Class.

; Derived akan mewarisi semua field di Class Base.
; Di memory, _a dan _b akan diletakkan berdekatan dan berurutan.
; Secara layout di memory, Base akan diletakkan lebih awal sebelum Derived.
; Jika sebuah Class lain diturunkan dari Derived, maka field Class tersebut akan diletakkan
; setelah semua field Base dan Derived.

; -- Deklarasi Base --
%class.Base     = type { 
    i32     ; _a di Base
}

define void @Base.setA (%class.Base* %this, i32 %value) {
    %_a.addr    = getelementptr %class.Base, %class.Base* %this, i32 0, i32 0
    store       i32 %value, i32* %_a.addr 

    ret void
}

; -- Deklarasi Derived --
%class.Derived    = type { 
    i32,    ; _a dari Base
    i32     ; _b dari Derived
}

define void @Derived.setB (%class.Derived* %this, i32 %value) {
    %_b.addr    = getelementptr %class.Derived, %class.Derived* %this, i32 0, i32 1
    store       i32 %value, i32* %_b.addr 

    ret void
}


define i32 @algorithm () {

    %object.Base    = alloca %class.Base 
    %object.Derived = alloca %class.Derived 

; -- Pemanggilan --
    ; memanggil method setA dari Base
    call        void @Base.setA (%class.Base* %object.Base, i32 10)

    ; memanggil method setB dari Derived
    call        void @Derived.setB (%class.Derived* %object.Derived, i32 20)

    ; memanggil method setA dari Derived
    ; Derived harus diubah (casting) menjadi Base, sesuai dengan signature.
    %cast.DtoB  = bitcast %class.Derived* %object.Derived to %class.Base*
    call        void @Base.setA (%class.Base* %cast.DtoB, i32 30)

    ret i32 0
}