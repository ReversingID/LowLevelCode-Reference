# Low-Level Code Reference

Optimizing Decompiler

* Github: https://github.com/zneak/fcd
* Site: http://zneak.github.io/fcd/

Category:

- decompiler
- executable

## Introduction

fcd adalah decompiler berbasis LLVM. 

#### Notes

- menggunakan [Capstone](https://github.com/aquynh/capstone) sebagai disassembler.
- mengimplementasikan algoritma Pattern-Independent Structuring.
- mendukung plugin berupa LLVM Pass.

## Reference

- [Write custom optimization passes](http://zneak.github.io/fcd/2016/02/21/csaw-wyvern.html)
- [Discover function prototypes by header files](http://zneak.github.io/fcd/2016/09/04/parsing-headers.html)