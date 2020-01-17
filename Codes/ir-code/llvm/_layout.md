# Low-Level Code Reference

LLVM Intermediate-Representation Layout

## Overview

LLVM IR merupakan intermediate representation yang digunakan di atas LLVM Compiler Infrastructure. LLVM IR bukan merupakan machine code. Beberapa konstruksi terlihat seperti high-level language (seperti fungsi dan strong type). Sementara sebagian terlihat seperti low-level assembly.

Sebagai abstraksi dari sebuah program (source), LLVM IR merepresentasikan komponen seperti:

- Module
- Function
- Basic Block
- Instruction

Operasi terhadap LLVM IR dapat dibagi menjadi dua kategori, yaitu: `Analysis` (analisis) dan `Transformation` (transformasi/perubahan bentuk). Analisis adalah memindai IR untuk mendapatkan informasi tertentu seputar flow dari code. Sementara Transformasi adalah mengubah IR dengan struktur tertentu menjadi struktur lain dengan mempertahankan maksud awal dari code.

#### Module

Module merupakan abstraksi dari sebuah module, sebuah source code file, atau sering disebut sebagai translation unit. Module merupakan kontainer untuk komponen-komponen lain. Di dalam sebuah Module dapat pula dideklarasikan beberapa informasi, antara lain:

- Target Information
- Global Symbols: variable, function declaration, function definition
- Metadata

#### Function

Sebuah Function mengabstraksi komponen function/subroutine. Fungsi adalah potongan kode yang diidentifikasi dengan sebuah nama. Istilah high-level seperti function pada paradigma `imperative` dan method pada paradigma `OOP` dipetakan sebagai sebuah "function" di LLVM.

Sebuah function terdiri dari:

- Argument: argumen yang dibutuhkan oleh fungsi
- Basic Block: basic block yang ada di dalam fungsi
- Entry Basic Block: basic-block yang dieksekusi pertama kali ketika fungsi dipanggil.

#### Basic Block

Sebuah Basic Block mengabstraksi sekumpulan instruksi yang terikat sebagai satu kesatuan. Serangkaian instruksi dapat disebut sebagai Basic Block apabila instruksi tersebut instruksi `non-terminator` dan diakhiri oleh sebuah instruksi `terminator`.

Sebuah Basic Block terdiri dari:

- Label
- Instruction
- Phi Instruction
- Terminator Instruction

Ketika mengabstraksi alur dari program, setiap basic-block dieksekusi dalam urutan tertentu. Sebuah successor adalah sebuah Basic Block yang akan dieksekusi tepat setelah Basic Block terkini.

#### Instruction

Sebuah instruksi merepresentasikan operasi tunggal yang dapat dilakukan.