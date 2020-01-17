# Low-Level Code Reference

Introduction to Ruby bytecode

## Ruby Bytecode

Ruby Bytecode adalah Instruction Set yang digunakan oleh Ruby Interpreter.

Ruby interpreter adalah Process Virtual Machine berbasis stack. Instruksi Ruby akan diterjemahkan secara dinamis menjadi kode yang berjalan secara native di host.

## Computation Model

## Dialect

Ruby tidak memberikan spesifikasi standard untuk merepresentasikan bytecode dalam bentuk teks. Tidak ada tools standard yang digunakan untuk melakukan reassembler (disassemble - assemble) sebuah bytecode.

Daftar berikut adalah implementasi Ruby dengan bytecode masing-masing:

- rubinius
- tinyrb
- yarv