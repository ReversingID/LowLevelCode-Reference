# Low-Level Code Reference

Decompiler Toolchain

* Github: https://github.com/lifting-bits/anvill

Category:

- decompiler
- binary lifting
- executable

## Introduction

Anvill adalah implementasi decompiler sederhana dengan [Remill](remill.md) dan [Rellic](rellic.md).

Dalam prosesnya, Bitcode akan dihasilkan dari Executable Binary oleh Remill. Bitcode kemudian diolah sehingga didapatkan padanan kode dalam bahasa C menggunakan Rellic.

#### Notes

- Anvill adalah executable yang menggunakan beberapa library.
- Dekompilasi dapat dikonfigurasi melalui file JSON.

## Reference
