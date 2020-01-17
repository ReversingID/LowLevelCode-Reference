# Low-Level Code Reference

Introduction to JVM bytecode.

## JVM Bytecode

JVM Bytecode adalah Instruction Set yang digunakan oleh Java Virtual Machine (JVM).

JVM merupakan Process Virtual Machine berbasis stack. Instruksi JVM bytecode akan diterjemahkan secara dinamis menjadi kode yang berjalan secara native di host.

Setiap bytecode terdiri atas satu byte yang merepresentasikan opcode dengan satu atau lebih byte untuk operan. 

Instruksi dalam JVM bytecode dapat dibagi menjadi beberapa kategori:

- Load and Store
- Arithmetic and Logic
- Type Conversion
- Object Creation and Manipulation
- Operand Stack Management
- Control Transfer
- Method Invocation and Return.

## Computation Model

JVM bytecode berorientasi objek dan berbasis stack. Orientasi objek membuat sebuah program dibagi atas beberapa entitas objek yang saling berinteraksi. Operasi akan menggunakan stack untuk menyimpan operan dan nilai hasil operasi. 

prefix:

- i: integer
- l: long
- s: short
- b: byte
- c: character
- f: float
- d: double
- z: boolean
- a: reference

## Dialect

Java tidak memberikan spesifikasi standard untuk merepresentasikan bytecode dalam bentuk teks. Tidak ada tools standard yang digunakan untuk melakukan reassemble (disassemble - assemble) sebuah bytecode. Beberapa tools memiliki format representasi masing-masing.

- Jasmin
- Soot
