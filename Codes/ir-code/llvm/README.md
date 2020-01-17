# Low-Level Code Reference

Introduction to LLVM Intermediate Representation (IR)

## LLVM IR Introduction

LLVM IR adalah Intermediate Representation yang digunakan oleh LLVM Compiler Infrastructure.

LLVM adalah Compiler Infrastructure yang digunakan untuk membangun compiler, menganalisis dan mentransformasi kode program pada fase-fase kompilasi.

Sebagai abstraksi komponen-komponen program, LLVM IR dapat dioperasikan dalam tiga wujud berbeda:

- In-Memory Data Structure
- Bitcode File (.bc)
- Text File (.ll)

Ketiga wujud LLVM IR digunakan untuk pemrosesan dan analisis dalam tiga kondisi berbeda.

`In-Memory Data Structure` adalah wujud IR sebagai struktur data yang hidup di memory, Abstract Syntax Tree yang dihasilkan dari proses parse dan translasi source code.

`Bitcode File` adalah representasi IR secara biner yang dituliskan ke dalam sebuah file menggunakan format yang space-efficient. Wujud ini berguna ketika digunakan oleh tools analisis maupun LLVM Pass.

`Text File` adalah representasi IR dalam notasi yang dapat dibaca oleh manusia.

## LLVM Infrastructure Tools

LLVM merupakan sebuah infrastruktur pengembangan compiler dan tools analisis program. Sebagai representasi kode program, LLVM IR diolah oleh beragam tools yang dibangun di atas infrastruktur LLVM.

Beberapa jenis tools yang dapat dikembangkan di atas LLVM dapat dilihat pada [tools](_tools.md).

## LLVM IR Layout

LLVM IR merupakan abstraksi dari sebuah program. Komponen-komponen program dipetakan menjadi komponen-komponen abstrak di LLVM yang independen terhadap machine code spesifik.

Untuk informasi lebih lanjut, lihat [layout](_layout.md)

## LLVM Pass

Pass adalah unit transformasi dan optimisasi di infrastruktur LLVM. Pass menerima LLVM IR dan melakukan `analisis` serta `transformasi` sesuai dengan aturan yang didefinisikan untuk menghasilkan LLVM IR yang lebih optimal.

LLVM Pass Framework sangat customizable untuk mengakomodir berbagai keperluan.

Untuk informasi lebih lanjut, lihat [pass](_pass.md)