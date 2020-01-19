# Low-Level Code Reference

Static Binary Translator

* Github: https://github.com/revng/revng
* Site: https://rev.ng/revng

Category:

- binary lifting
- recompiler
- executable

## Introduction

Revng adalah Static Binary Translator, melakukan lifting dari sembarang ELF binary yang didukung (MIPS, ARM, x86-64) dan menghasilkan LLVM IR. Tidak seperti tools sejenis, revng menggunakan Qemu sebagai front end untuk menghasilkan Intermediate Representation (TCG IR) dan menerjemahkannya ke LLVM IR yang sesuai.

Revng dapat digunakan untuk menghasilkan binary baru untuk target berbeda.

#### Notes

## Reference

