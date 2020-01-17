# Low-Level Code Reference

Introduction to .NET Common Intermediate Language.

## .NET CIL Introduction

.NET CIL (Common Intermediate Language) adalah Instruction Set yang digunakan oleh .NET Common Language Runtime (CLR). Spesifikasi .NET CIL (instruksi, tipe data, grammar, dsb) diatur berdasarkan standard ECMA-335.

Sebuah CLR merupakan Process Virtual Machine berbasis stack. Instruksi .NET CIL akan diterjemahkan secara dinamis menjadi kode yang berjalan secara native di host.

Instruksi dalam .NET CL dapat dibagi menjadi beberapa kategori:

- Load and Store
- Arithmetic
- Type Conversion
- Object Creation and Manipulation
- Operand Stack Management
- Control Transfer
- Exceptions
- Data and Function Pointers Manipulation.

## Computation Model

.NET CIL berorientasi objek dan berbasis stack. Orientasi objek membuat sebuah program dalam CIL dibagi atas beberapa entitas objek yang saling berinteraksi. Operasi akan menggunakan stack untuk menyimpan operan dan nilai hasil operasi. 

## Dialect

- cil
