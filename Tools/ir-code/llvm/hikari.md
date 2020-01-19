# Low-Level Code Reference

LLVM Obfuscator

* Github: https://github.com/HikariObfuscator/Hikari

Category:

- obfuscator
- executable

## Introduction

Hikari adalah obfuscator berbasis LLVM dengan berfokus kepada penggunaan LLVM Pass untuk melakukan transformasi source code program. 

#### Design

Hikari didesain dengan tiga tujuan utama:

- __Minimal Impact__: Core dari Hikari harus mudah dipindahkan (port) ke compiler lain dengan LLVM sebagai backend.
- __Focus on the Compiler__: Tidak ada penambahan fitur yang memerlukan pustaka luar.
- __Keep it Abstract__: Lakukan obfuscation di level IR, bukan di backend sehingga menjamin abstraksi dan platform independent.

#### Pass 

- __Bogus Control Flow__: modifikasi Control Flow Graph dengan menambahkan Basic Block sebelum Basic Block saat ini. Basic Block baru mengandung Opaque Predicate sehingga terjadi Conditional Jump ke Basic Block asli.
- __Control Flow Flattening__: memodifikasi Control Flow Graph dengan membuat semua Basic Block berada pada level yang sama.
- __Function Call Obfuscate__: mengganti semua pemanggilan suatu fungsi ke fungsi lain berdasarkan pemetaan yang telah ditentukan .
- __Function Wrapper__: membuat dummy function yang membungkus pemanggilan ke fungsi sesungguhnya, sehingga terdapat beberapa pemanggilan yang harus dilakukan sebelum memanggil fungsi asli.
- __Indirect Branching__: instruksi Branching digantikan oleh Indirect Branching, sehingga menjadikan pemanggilan bersifat dinamis.
- __String Encryption__: enkripsi string dan buat sebuah stub untuk melakukan dekripsi sebelum string digunakan.

#### Notes

- Dikembangkan sebagai peningkatan (improvement) terhadap [Obfuscator-LLVM](https://github.com/obfuscator-llvm/obfuscator).

## Reference

