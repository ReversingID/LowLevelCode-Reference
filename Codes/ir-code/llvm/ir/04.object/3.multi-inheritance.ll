;   Multiple Base Inheritance
;   Object Model & Manipulation
;
;   Memodelkan turunan dan warisan dalam LLVM IR
;
; LLVM Bitcode:
;   $ llvm-as multi-inheritance.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o multi-inheritance.asm multi-inheritance.ll
;
;-----------------------------------------------------------------------------

source_filename = "multi-inheritance.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Inheritance
; Salah satu konsep penting dalam Object-Oriented Programming.
; Inheritance (warisan) adalah konsep dimana sebuah Class yang didefinisikan dapat 
; memiliki segala property dari Class lain.
;
; Dalam pewarisan, apabila suatu Class memiliki lebih dari satu induk (Base), maka
; penyusunan field akan dilakukan secara berurutan sesuai dengan deklarasi Class 
; indu.

;   Class yang terlibat
;
;       class BaseA 
;       {
;           int _a;
;       public:
;           void setA(int value)
;           {
;               _a = value;
;           }
;       };
;       
;       class BaseB
;       {
;           int _b;
;       public:
;           void setB(int value)
;           {
;               _b = value;
;           }
;       };
;       
;       class Derived : public BaseA, public BaseB
;       {
;           int _c;
;       public:
;           void setc(int value)
;           {
;               _c = value;
;           }
;       };
;
;

; Derived mewarisi method yang didefinisikan oleh Base Class.
; Dengan demikian Derived dapat melakukan pemanggilan method yang sama 
; sebagaimana didefinisikan oleh Base Class.

; Derived akan mewarisi semua field di Class Base.
; Di memory, _a dan _b akan diletakkan berdekatan dan berurutan.
; Secara layout di memory, Base akan diletakkan lebih awal sebelum Derived.
; Jika sebuah Class lain diturunkan dari Derived, maka field Class tersebut akan diletakkan
; setelah semua field Base dan Derived.

; -- Deklarasi BaseA --
%class.BaseA    = type { 
    i32     ; _a di BaseA
}

; _a berada di urutan pertama BaseA
define void @BaseA.setA (%class.BaseA* %this, i32 %value) {
    %_a.addr    = getelementptr %class.BaseA, %class.BaseA* %this, i32 0, i32 0
    store       i32 %value, i32* %_a.addr 

    ret void
}

; -- Deklarasi BaseB --
%class.BaseB    = type {
    i32     ; _b di BaseB
}

; _b berada di urutan pertama BaseB
define void @BaseB.setB (%class.BaseB* %this, i32 %value) {
    %_b.addr    = getelementptr %class.BaseB, %class.BaseB* %this, i32 0, i32 0
    store       i32 %value, i32* %_b.addr 

    ret void
}

; -- Deklarasi Derived --
%class.Derived    = type { 
    i32,    ; _a dari BaseA
    i32,    ; _b dari BaseB
    i32     ; _c dari Derived
}

define void @Derived.setC (%class.Derived* %this, i32 %value) {
    %_b.addr    = getelementptr %class.Derived, %class.Derived* %this, i32 0, i32 2
    store       i32 %value, i32* %_b.addr 

    ret void
}


define i32 @algorithm () {

    %object.BaseA   = alloca %class.BaseA
    %object.BaseB   = alloca %class.BaseB
    %object.Derived = alloca %class.Derived 

; -- Pemanggilan --
    ; memanggil method setA dari BaseB
    call        void @BaseA.setA (%class.BaseA* %object.BaseA, i32 10)

    ; memanggil method setB dari BaseB
    call        void @BaseB.setB (%class.BaseB* %object.BaseB, i32 20)

    ; memanggil method setC dari Derived
    call        void @Derived.setC (%class.Derived* %object.Derived, i32 30)

    ; memanggil method setA dari Derived
    ; BaseA berada di awal sehingga cast secara langsung dapat dilakukan.
    %cast.DtoA  = bitcast %class.Derived* %object.Derived to %class.BaseA*
    call        void @BaseA.setA (%class.BaseA* %cast.DtoA, i32 40)

    ; memanggil method setB dari Derived
    ; BaseB berada di bawah BaseB sehingga perhitungan perlu dilakukan
    %cast.bit   = bitcast %class.Derived* %object.Derived to i8*
    %ptr.BaseB  = getelementptr inbounds i8, i8* %cast.bit, i64 4           ; i32 = 4 byte
    %cast.DtoB  = bitcast i8* %ptr.BaseB to %class.BaseB*
    call        void @BaseB.setB (%class.BaseB* %cast.DtoB, i32 50)

    ret i32 0
}