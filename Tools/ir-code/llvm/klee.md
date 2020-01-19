# Low-Level Code Reference

KLEE LLVM Execution Engine.

* Github: https://github.com/klee/klee
* Site: https://klee.github.io/

Category:

- symbolic execution
- executable

## Introduction

KLEE adalah symbolic virtual machine dibangun di atas LLVM Compiler Infrastructure.

#### Design 

KLEE didesain dengan dua komponen:

- __Core Symbolic Virtual Machine__: bertanggung jawab atas eksekusi LLVM bitcode dengan dukungan terhadap symbolic values.
- __POSIX Emulation Layer__: menggunakan uClibc untuk memberikan dukungan lingkungan eksekusi program.

#### Notes

## Reference 

- [Tutorials](https://klee.github.io/tutorials)