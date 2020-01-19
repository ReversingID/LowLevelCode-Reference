# Low-Level Code Reference

Binary to LLVM Translator

* Github: https://github.com/S2E/tools

Category:

- binary lifting
- recompiler
- executable

## Introduction

Tool berbasis [S2E](s2e.md) untuk menerjemahkan binary menjadi LLVM IR.

Proess penerjemahan dilakukan dalam empat langkah:

- Disassemble binary menggunakan IDA Pro
- Recover Congrol Flow Graph (CFG) dengan McSema
- Terjemahkan setiap Basic Block dalam CFG menjadi potongan LLVM Bitcode dengan Qemu translator
- Susun keseluruhan Basic Block menjadi fungsi utuh.

Dengan demikian terdapat beberapa dependensi seperti IDA Pro, McSema, dan Qemu.

#### Notes

## Reference

