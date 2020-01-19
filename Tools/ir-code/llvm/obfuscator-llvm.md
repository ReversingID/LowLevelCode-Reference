# Low-Level Code Reference

LLVM Obfuscator

* Github: https://github.com/obfuscator-llvm/obfuscator

Category:

- obfuscator
- executable

## Introduction

Obfuscator berbasis LLVM dengan berfokus kepada penggunaan LLVM Pass untuk melakukan transformasi source code program. 

#### Pass 

- __Bogus Control Flow__: modifikasi Control Flow Graph dengan menambahkan Basic Block sebelum Basic Block saat ini. Basic Block baru mengandung Opaque Predicate sehingga terjadi Conditional Jump ke Basic Block asli.
- __Control Flow Flattening__: memodifikasi Control Flow Graph dengan membuat semua Basic Block berada pada level yang sama.

## Reference

