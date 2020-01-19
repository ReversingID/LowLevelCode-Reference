# Low-Level Code Reference

Framework for Lifting x86, amd64, and aarch64 Binaries to LLVM Bitcode

* Github: https://github.com/lifting-bits/mcsema

Category:

- binary lifting

## Introduction

McSema adalah framework Binary Lifting, menerjemahkan (lift) executable binaries dari kode mesin menjadi LLVM bitcode. McSema juga dapat dikombinasikan dengan libFuzzer untuk melakukan fuzzing.

Secara garis besar, McSema digunakan untuk:

- Binary Lifting
- Static Binary Rewriting
- Binary Translation
- BInary Recompilation

McSema mendukung beberapa format executable seperti ELF (Linux) dan PE (Windows), serta sebagian besar instruksi untuk x86 dan amd64.

#### Notes

- terdiri atas dua komponen: `mcsema-disass` dan `mcsema-lift`.
- `mcsema-disass` melakukan Control-Flow Recovery dan Instruction Translation menggunakan dukungan dari IDA Pro, Binary Ninja, atau DynInst.
- `mcsema-lift` melakukan Instruction Translation ke LLVM Bitcode menggunakan pustaka [Remill](remill.md)

## Reference

Official

- [Walktrough](https://github.com/lifting-bits/mcsema/blob/master/docs/McSemaWalkthrough.md)
- [Using libFuzzer](https://github.com/lifting-bits/mcsema/blob/master/docs/UsingLibFuzzer.md)
- [Using KLEE](https://blog.trailofbits.com/2014/12/04/close-encounters-with-symbolic-execution-part-2/)

Unofficial