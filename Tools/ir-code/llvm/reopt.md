# Low-Level Code Reference

Tool for Analyzing x86-64 Binaries

* Github: https://github.com/GaloisInc/reopt

Category:

- recompiler
- binary lifting
- disassembler
- optimizer

## Introduction

Reopt adalah tool yang berfokus kepada operasi dekompilasi dan rekompilasi kode. Reopt bekerja dengan melakukan binary lifting, memetakan binary ke LLVM bitcode kemudian melakukan optimisasi hingga akhirnya menerjemahkan kembali ke executable baru.

#### Targets

- Architecture:
    - 64-bit: x86-64
- Operating System: Linux, MacOS, iOS, Windows

#### Notes:

- membutuhkan Haskell

## Reference

- 